import 'package:flutter/material.dart';
import 'package:gravini/helpers/mostrar_alerta.dart';
import 'package:gravini/models/listResidencia.dart';
import 'package:gravini/providers/registro_form_provider.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:gravini/widgets/boton_azul.dart';
import 'package:gravini/widgets/boton_azulShort.dart';
import 'package:gravini/widgets/labels.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import '../widgets/logo.dart';

class RegistroStep2 extends StatefulWidget {
  const RegistroStep2({Key? key}) : super(key: key);

  @override
  State<RegistroStep2> createState() => _RegistroStep2State();
}

class _RegistroStep2State extends State<RegistroStep2> {
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final passConfirmacionCtrl = TextEditingController();
  int defaultChoiceIndex = 0;
  bool aviso = false;
  bool reglamento = false;

  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 16.0);
  //final TextEditingController textEditingController = TextEditingController();

  final etSkillScore1Key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final datosRegistro =
        Provider.of<RegistroFormProvider>(context, listen: false);

    final authService = Provider.of<AuthService>(context, listen: false);
    String selectedDate;
    if (datosRegistro.datosget?.fechaNacimiento == null) {
      selectedDate = "";
    } else {
      selectedDate = DateFormat('yyyy-MM-dd').format(
          DateTime.parse(datosRegistro.datosget!.fechaNacimiento.toString()));
    }

    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'corre': '',
      'phone': '',
      'userName': '',
      'pass': '',
      'confPass': '',
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
                    Text("Hola ${datosRegistro.datosget?.nombre}",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey)),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images.png'),
                      maxRadius: 22,
                      child: Positioned(
                          top: 60,
                          right: 20,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          )),
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

                          //Boton
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            initialValue: datosRegistro.datosget?.correo ??= "",
                            textCapitalization: TextCapitalization.none,
                            onChanged: (value) {
                              formValues['corre'] = value;
                              datosRegistro.datosget?.correo = value;
                            },
                            validator: (value) => validateEmail(value),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese su correo electronico',
                                labelText: 'Correo electronico',
                                prefixIcon: Icon(Icons.mail),
                                prefixStyle: TextStyle(height: 300)),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            autofocus: false,
                            initialValue:
                                datosRegistro.datosget?.numeroCelular ??= "",
                            onChanged: (value) {
                              formValues['phone'] = value;
                              datosRegistro.datosget?.numeroCelular = value;
                            },
                            validator: (value) => validateMobile(value),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese su número de celular',
                                labelText: 'Celular',
                                prefixIcon: Icon(Icons.phone_android),
                                prefixStyle: TextStyle(height: 300)),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: false,
                            obscureText: true,
                            initialValue:
                                datosRegistro.datosget?.password ?? "",
                            onChanged: (value) {
                              formValues['pass'] = value;
                              datosRegistro.datosget?.password = value;
                            },
                            validator: (value) {
                              if (value == null)
                                return 'Este campo es requerido';
                              return value.length < 3
                                  ? 'Mínimo de 3 letras'
                                  : null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese una contraseña',
                                labelText: 'Contraseña',
                                prefixIcon: Icon(Icons.lock),
                                prefixStyle: TextStyle(height: 300)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            autofocus: false,
                            obscureText: true,
                            initialValue:
                                datosRegistro.datosget?.confPass ?? "",
                            onChanged: (value) {
                              formValues['confPass'] = value;
                              datosRegistro.datosget?.confPass = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Este campo es requerido';
                              } else {
                                if (value.length < 3) {
                                  return 'Mínimo de 3 letras';
                                } else {
                                  if (datosRegistro.datosget?.confPass !=
                                      datosRegistro.datosget?.password) {
                                    return 'Las contraseñas deben coincidir';
                                  } else {
                                    return null;
                                  }
                                }
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese una contraseña',
                                labelText: 'Contraseña',
                                prefixIcon: Icon(Icons.lock),
                                prefixStyle: TextStyle(height: 300)),
                          ),
                          const SizedBox(
                            height: 30,
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
                          SwitchListTile(
                            value: datosRegistro.datosget?.aviso ?? false,
                            onChanged: (bool value) {
                              setState(() {
                                aviso = value;
                                datosRegistro.datosget?.aviso = value;
                              });
                            },
                            title: const Text(
                                'He leído el Aviso de privacidad y estoy de acuerdo en continuar.'),
                          ),
                          SwitchListTile(
                            value: datosRegistro.datosget?.reclamento ?? false,
                            onChanged: (bool value) {
                              setState(() {
                                reglamento = value;
                                datosRegistro.datosget?.reclamento = value;
                              });
                            },
                            title: const Text(
                                'He leido el reglamento y estoy dispuesto a continuar'),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Wrap(
                            children: [
                              BotonAzulShort(
                                  texto: 'Cancelar',
                                  colorBtn: Colors.grey,
                                  onPressr: () {
                                    Navigator.pushReplacementNamed(
                                        context, 'login');
                                  }),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      // Foreground color
                                      onPrimary: Colors.white,
                                      elevation: 2,
                                      shape: const StadiumBorder(),
                                      // Background color
                                      primary: Colors.blue,
                                    ).copyWith(
                                        elevation:
                                            ButtonStyleButton.allOrNull(0.0)),
                                    onPressed: authService.getAutenticando ==
                                            true
                                        ? null
                                        : () async {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            if (myFormKey.currentState !=
                                                null) {
                                              if (!myFormKey.currentState!
                                                  .validate()) {
                                                print('Formulario no valido');
                                                return;
                                              }
                                            } else {
                                              if (datosRegistro
                                                      .datosget!.aviso! &&
                                                  datosRegistro
                                                      .datosget!.reclamento!) {
                                                final resp = await authService.registro(
                                                    datosRegistro
                                                        .datosget!.nombre!,
                                                    datosRegistro.datosget!
                                                        .apellidoPaterno!,
                                                    datosRegistro.datosget!
                                                        .apellidoMaterno!,
                                                    datosRegistro
                                                        .datosget!.curp!
                                                        .trim(),
                                                    datosRegistro.datosget!
                                                        .numeroCelular!,
                                                    datosRegistro.datosget!
                                                        .estadoResidencia!,
                                                    datosRegistro.datosget!
                                                        .fechaNacimiento!
                                                        .toString(),
                                                    datosRegistro
                                                        .datosget!.esEgresado!,
                                                    datosRegistro
                                                        .datosget!.anioIngreso!,
                                                    datosRegistro
                                                        .datosget!.campusVilla!,
                                                    datosRegistro
                                                        .datosget!.correo!
                                                        .trim(),
                                                    2,
                                                    true,
                                                    datosRegistro
                                                        .datosget!.password!);

                                                if (resp.toString() != "") {
                                                  mostrarAlerta(
                                                      context,
                                                      'Error al registrarse',
                                                      resp.toString());
                                                } else {
                                                  await mostrarAlerta(
                                                      context,
                                                      'Registro exitoso',
                                                      "Ahora puede iniciar sesión");
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, 'login');
                                                }
                                              } else {
                                                final String msnError;
                                                if (!datosRegistro
                                                    .datosget!.aviso!) {
                                                  msnError =
                                                      "Para poderse registrar debe aceptar el aviso de privacidad.";
                                                } else {
                                                  msnError =
                                                      "Para poderse registrar debe aceptar el reglamento.";
                                                }
                                                mostrarAlerta(
                                                    context,
                                                    'Error al registrarse',
                                                    msnError);
                                                return;
                                              }
                                            }
                                          },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      height: 40,
                                      child: const Center(
                                          child: Text(
                                        "Registrarse",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      )),
                                    )),
                              )
                            ],
                          )
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

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Ingresa un correo correcto';
  } else {
    return null;
  }
}

String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
  if (value == null) {
    if (value!.length != 10) {
      return 'El numero de culular no puede ser mayor a 10 digitos.';
    }
  } else {
    return null;
    return null;
  }
  return null;
}
