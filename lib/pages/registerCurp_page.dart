import 'package:gravini/providers/registro_form_provider.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:gravini/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:gravini/widgets/boton_azul.dart';
import 'package:gravini/widgets/labels.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class RegisterCurpPage extends StatefulWidget {
  @override
  State<RegisterCurpPage> createState() => _RegisterCurpPageState();
}

class _RegisterCurpPageState extends State<RegisterCurpPage> {
  final TextEditingController textEditingController = TextEditingController();

  final etSkillScore1Key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final datosRegistro = Provider.of<RegistroFormProvider>(context);
    final authService = Provider.of<AuthService>(context);
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {'curp': 'Garciakdkdkdkdkdks'};
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
                    Text("Ingresa tu curp, esto facilitará tu registro."),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Form(
                        key: myFormKey,
                        child: Column(children: [
                          //Campo  de  Curp
                          TextFormField(
                            initialValue: datosRegistro.datosget?.curp ??= "",
                            textCapitalization: TextCapitalization.characters,
                            onChanged: (value) {
                              formValues['curp'] = value;
                              datosRegistro.datosget?.curp = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Este campo es requerido';
                              }
                              return (value.length < 18 || value.length > 18)
                                  ? 'El Curp debe ser de 18 caracteres'
                                  : null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese su curp',
                                labelText: 'Curp',
                                prefixStyle: TextStyle(height: 300)),
                          ),
                          //Separacion
                          const SizedBox(
                            height: 20,
                          ),

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
                                  return;
                                } else {
                                  final resp = await authService.validarCurp(
                                      datosRegistro.datosget!.curp!);
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
                                        inputFormat.parse(authService
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
                                        context, 'registerName');
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
