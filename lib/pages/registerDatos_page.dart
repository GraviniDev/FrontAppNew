import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gravini/helpers/mostrar_alerta.dart';
import 'package:gravini/models/listResidencia.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:gravini/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/registro_form_provider.dart';
import '../widgets/boton_azulShort.dart';

class RegisterDatosPage extends StatefulWidget {
  @override
  State<RegisterDatosPage> createState() => _RegisterDatosPageState();
}

class _RegisterDatosPageState extends State<RegisterDatosPage> {
  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _Form(),
                  ]),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final passConfirmacionCtrl = TextEditingController();
  int defaultChoiceIndex = 0;
  bool aviso = false;
  bool reglamento = false;
  final etSkillScore1Key = GlobalKey<FormState>();
  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 16.0);
  final ButtonStyle style = ElevatedButton.styleFrom(
    // Foreground color
    onPrimary: Colors.blue,
    // Background color
    primary: Colors.black,
  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final datosRegistro = Provider.of<RegistroFormProvider>(context);
    TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 16.0);
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'corre': '',
      'phone': '',
      'userName': '',
      'pass': '',
      'confPass': ''
    };
    final ColorScheme colors = Theme.of(context).colorScheme;

    String imagenPerfil = 'assets/images.png';
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: Form(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Text("Hola ${datosRegistro.datosget?.nombre}",
                  style: const TextStyle(fontSize: 20, color: Colors.grey)),

              Text("¡Ya casi terminamos tu registro!",
                  style: const TextStyle(fontSize: 15, color: Colors.grey)),

              const SizedBox(
                height: 20,
              ),
              Stack(
                  alignment: AlignmentDirectional.center,
                  fit: StackFit.loose,
                  children: [
                    Container(
                      child: CircleAvatar(
                        backgroundImage: datosRegistro.datosget!.imagenPerfil ==
                                null
                            ? AssetImage(imagenPerfil)
                            : Image.file(
                                    File(datosRegistro.datosget!.imagenPerfil!),
                                    fit: BoxFit.cover)
                                .image,
                        maxRadius: 60,
                      ),
                    ),
                    Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        fit: StackFit.loose,
                        children: [
                          Container(
                              child: RawMaterialButton(
                            child: Icon(
                              Icons.camera_alt,
                              size: 60.0,
                              color: Colors.transparent,
                            ),
                            padding: EdgeInsets.all(35.0),
                            elevation: 2.0,
                            fillColor: Colors.transparent,
                            shape: CircleBorder(),
                            onPressed: () {},
                          )),
                          RawMaterialButton(
                            onPressed: () async {
                              final picker = new ImagePicker();
                              final PickedFile? pickedFile =
                                  await picker.getImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 50);

                              if (pickedFile == null) {
                                return;
                              }
                              datosRegistro.datosget?.imagenPerfil =
                                  pickedFile.path;
                              authService
                                  .updateSelectedImageUser(pickedFile.path);
                            },
                            elevation: 2.0,
                            fillColor: Colors.blue,
                            child: Icon(
                              Icons.camera_alt,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(10.0),
                            shape: CircleBorder(),
                          )
                        ])
                  ]),
              const SizedBox(
                height: 30,
              ),
              DropdownButtonFormField<String>(
                value: datosRegistro.datosget?.estadoResidencia == null
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
                  formValues['residencia'] = value ?? 'Lugar de residencia';
                  FocusScope.of(context).requestFocus(FocusNode());
                  datosRegistro.datosget?.estadoResidencia = value;
                },
              ),
              //Separacion
              const SizedBox(
                height: 20,
              ),
              //Campo del Correo
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                initialValue: datosRegistro.datosget?.numeroCelular ??= "",
                onChanged: (value) {
                  formValues['phone'] = value;
                  datosRegistro.datosget?.numeroCelular = value;
                },
                validator: (value) => validateMobile(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                initialValue: datosRegistro.datosget?.password ?? "",
                onChanged: (value) {
                  formValues['pass'] = value;
                  datosRegistro.datosget?.password = value;
                },
                validator: (value) {
                  if (value == null) return 'Este campo es requerido';
                  return value.length < 3 ? 'Mínimo de 3 letras' : null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                initialValue: datosRegistro.datosget?.confPass ?? "",
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    hintText: 'Ingrese una contraseña',
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    prefixStyle: TextStyle(height: 300)),
              ),
              const SizedBox(
                height: 30,
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
                        Navigator.pushReplacementNamed(context, 'login');
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
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: authService.getAutenticando == true
                            ? null
                            : () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (myFormKey.currentState != null) {
                                  if (!myFormKey.currentState!.validate()) {
                                    print('Formulario no valido');
                                    return;
                                  }
                                } else {
                                  if (datosRegistro.datosget!.aviso! &&
                                      datosRegistro.datosget!.reclamento!) {
                                    final resp = await authService.registro(
                                        datosRegistro.datosget!.nombre!,
                                        datosRegistro
                                            .datosget!.apellidoPaterno!,
                                        datosRegistro
                                            .datosget!.apellidoMaterno!,
                                        datosRegistro.datosget!.curp!.trim(),
                                        datosRegistro.datosget!.numeroCelular!,
                                        datosRegistro
                                            .datosget!.estadoResidencia!,
                                        datosRegistro.datosget!.fechaNacimiento!
                                            .toString(),
                                        datosRegistro.datosget!.esEgresado!,
                                        datosRegistro.datosget!.anioIngreso!,
                                        datosRegistro.datosget!.campusVilla!,
                                        datosRegistro.datosget!.correo!.trim(),
                                        2,
                                        true,
                                        datosRegistro.datosget!.password!);

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
                                      Navigator.pushReplacementNamed(
                                          context, 'login');
                                    }
                                  } else {
                                    final String msnError;
                                    if (!datosRegistro.datosget!.aviso!) {
                                      msnError =
                                          "Para poderse registrar debe aceptar el aviso de privacidad.";
                                    } else {
                                      msnError =
                                          "Para poderse registrar debe aceptar el reglamento.";
                                    }
                                    mostrarAlerta(context,
                                        'Error al registrarse', msnError);
                                    return;
                                  }
                                }
                              },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .25,
                          height: 40,
                          child: const Center(
                              child: Text(
                            "Registrarse",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
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
