import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:gravini/models/listResidencia.dart';
import 'package:gravini/providers/registro_form_provider.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:gravini/theme/app_theme.dart';
import 'package:gravini/widgets/boton_azul.dart';
import 'package:gravini/widgets/labels.dart';
import 'package:gravini/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RegisterNamePage extends StatefulWidget {
  @override
  State<RegisterNamePage> createState() => _RegisterNamePageState();
}

class _RegisterNamePageState extends State<RegisterNamePage> {
  final TextEditingController textEditingController = TextEditingController();

  final etSkillScore1Key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final datosRegistro = Provider.of<RegistroFormProvider>(context);

    final authService = Provider.of<AuthService>(context);
    String selectedDate;
    if (datosRegistro.datosget?.fechaNacimiento == null) {
      selectedDate = "";
    } else {
      selectedDate = DateFormat('yyyy-MM-dd').format(
          DateTime.parse(datosRegistro.datosget!.fechaNacimiento.toString()));
    }

    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'nombre': 'Yazmin',
      'aPaterno': 'Garcia',
      'aMaterno': 'Melendez',
      'curp': 'Garciakdkdkdkdkdks',
      'fechaNacimiento': '10-02-2020',
      'lugarResidencia': ''
    };

    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Logo(
                      titulo: 'REGISTRO',
                      width: 150,
                      radio: 60,
                      top: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Form(
                        key: myFormKey,
                        child: Column(children: [
                          //Campo del nombre
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            initialValue: datosRegistro.datosget?.nombre ??= "",
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) {
                              formValues['nombre'] = value;
                              datosRegistro.datosget?.nombre = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Este campo es requerido';
                              }
                              return value.length < 3
                                  ? 'Mínimo de 3 letras'
                                  : null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese su nombre',
                                labelText: 'Nombre',
                                prefixIcon: Icon(Icons.perm_identity_outlined),
                                prefixStyle: TextStyle(height: 300)),
                          ),
                          //Separacion
                          const SizedBox(
                            height: 20,
                          ),
                          //Campo de Apellido Paterno
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            initialValue:
                                datosRegistro.datosget?.apellidoPaterno ??= "",
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) {
                              formValues['aPaterno'] = value;
                              datosRegistro.datosget?.apellidoPaterno = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Este campo es requerido';
                              }
                              return value.length < 3
                                  ? 'Mínimo de 3 letras'
                                  : null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese su Apellido Paterno',
                                labelText: 'Apellido Paterno',
                                prefixStyle: TextStyle(height: 300)),
                          ),
                          //Separacion
                          const SizedBox(
                            height: 20,
                          ),
                          //Campo  de Apellido Materno
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            initialValue:
                                datosRegistro.datosget?.apellidoMaterno ??= "",
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) {
                              formValues['aMaterno'] = value;
                              datosRegistro.datosget?.apellidoMaterno = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Este campo es requerido';
                              }
                              return value.length < 3
                                  ? 'Mínimo de 3 letras'
                                  : null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese su Apellido Materno',
                                labelText: 'Apellido Materno',
                                prefixStyle: TextStyle(height: 300)),
                          ),
                          //Separacion
                          const SizedBox(
                            height: 20,
                          ),
                          //Campo  de  Curp

                          //Separacion
                          const SizedBox(
                            height: 20,
                          ),
                          //Boton
                          BotonAzul(
                              texto: 'Siguiente',
                              onPressr: () async {
                                //Desactivar el teclado
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                if (!myFormKey.currentState!.validate()) {
                                  print('Formulario no valido');
                                  return;
                                } else {
                                  final resp = await authService.validarName(
                                      '${datosRegistro.datosget!.apellidoPaterno!.replaceAll("  ", " ").trim()} ${datosRegistro.datosget!.apellidoMaterno!.replaceAll("  ", " ").trim()} ${datosRegistro.datosget!.nombre!.replaceAll("  ", " ").trim()}');
                                  if (resp == true) {
                                    datosRegistro.datosget!.nombre =
                                        authService.dataCurp!.nombre;
                                    datosRegistro.datosget!.apellidoMaterno =
                                        authService.dataCurp!.materno;
                                    datosRegistro.datosget!.apellidoPaterno =
                                        authService.dataCurp!.paterno;
                                    datosRegistro.datosget!.esEgresado = true;
                                    DateFormat inputFormat =
                                        DateFormat('dd/MM/yyyy');
                                    datosRegistro.datosget!.fechaNacimiento =
                                        inputFormat.parse(authService.dataCurp!
                                                    .fechaNacimiento ==
                                                null
                                            ? "01/01/1992"
                                            : authService
                                                .dataCurp!.fechaNacimiento!);
                                    datosRegistro.datosget!.anioIngreso =
                                        int.parse(authService
                                            .dataCurp!.alumnoAltainicial!);
                                    datosRegistro.datosget!.campusVilla =
                                        authService.dataCurp!.idCampus == 1
                                            ? "Chalco"
                                            : "Guadalajara";
                                    Navigator.pushReplacementNamed(
                                        context, 'registerDatos');
                                  } else {
                                    Navigator.pushReplacementNamed(
                                        context, 'register');
                                  }
                                }
                              }),
                        ]),
                      ),
                    ),
                    const Labels(
                      ruta: 'login',
                      titulo: '¿Ya tienes una cuenta?',
                      subTitulo: 'Ir a inicio de sesión',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Terminos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    )
                  ]),
            ),
          ),
        ));
  }
}
