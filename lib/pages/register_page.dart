import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:gravini/models/listResidencia.dart';
import 'package:gravini/providers/registro_form_provider.dart';
import 'package:gravini/theme/app_theme.dart';
import 'package:gravini/widgets/boton_azul.dart';
import 'package:gravini/widgets/labels.dart';
import 'package:gravini/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController textEditingController = TextEditingController();

  final etSkillScore1Key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final datosRegistro = Provider.of<RegistroFormProvider>(context);

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

                          const SizedBox(
                            height: 20,
                          ),
                          //Campo de Fecha de Nacimiento
                          TextFormField(
                            initialValue: selectedDate,
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) {
                              //  formValues['fechaNacimiento'] = value;

                              datosRegistro.datosget?.fechaNacimiento =
                                  DateTime.parse(value);
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Este campo es requerido';
                              }
                              return null;
                            },
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              var datePicked =
                                  await DatePicker.showSimpleDatePicker(context,
                                      initialDate: DateTime(1992, 08, 15),
                                      firstDate: DateTime(1960),
                                      lastDate: DateTime.now(),
                                      dateFormat: "dd-MMMM-yyyy",
                                      locale: DateTimePickerLocale.es,
                                      looping: true,
                                      titleText: "Fecha de nacimiento",
                                      textColor: AppTheme.primary);
                              selectedDate = datePicked == null
                                  ? ""
                                  : DateFormat('yyyy-MM-dd').format(datePicked);
                              datosRegistro.datosget?.fechaNacimiento =
                                  datePicked;
                              setState(() {});
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese su fecha de nacimiento',
                                labelText: 'Fecha de nacimiento',
                                prefixStyle: TextStyle(height: 300)),
                          ),
                          //Separacion
                          const SizedBox(
                            height: 20,
                          ),
                          //CAmpo de residencia
                          DropdownButtonFormField<String>(
                            value:
                                datosRegistro.datosget?.estadoResidencia == null
                                    ? datosRegistro.datosget?.estadoResidencia
                                    : null,
                            key: etSkillScore1Key,
                            validator: (value) {
                              if (value == null) {
                                return 'Seleccione el estado de residencia';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                                hintText: 'Lugar de residencia',
                                labelText: 'Lugar de residencia'),
                            items: dropdownItems,
                            onChanged: (value) {
                              formValues['residencia'] =
                                  value ?? 'Lugar de residencia';
                              FocusScope.of(context).requestFocus(FocusNode());
                              datosRegistro.datosget?.estadoResidencia = value;
                            },
                          ),
                          //Separacion
                          const SizedBox(
                            height: 20,
                          ),
                          //Boton
                          BotonAzul(
                              texto: 'Siguiente',
                              onPressr: () {
                                //Desactivar el teclado
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                if (!myFormKey.currentState!.validate()) {
                                  print('Formulario no valido');
                                  return;
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, 'register2');
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
