import 'package:flutter/material.dart';
import 'package:gravini/helpers/mostrar_alerta.dart';
import 'package:gravini/providers/db_provider.dart';
import 'package:gravini/services/auth_service.dart';
import 'package:gravini/services/socket_service.dart';
import 'package:gravini/widgets/labels.dart';
import 'package:gravini/widgets/logo.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {'user': 'Yazmin', 'pass': 'Garcia'};
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      child: Scaffold(
          backgroundColor: const Color(0xffF2F2F2),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Logo(
                        titulo: 'INICIO DE SESIÓN',
                        radio: 150,
                        top: 30,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 0),
                          child: Form(
                              key: myFormKey,
                              child: Column(children: [
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  initialValue: "",
                                  onChanged: (value) {
                                    formValues['user'] = value;
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
                                      hintText: 'Ingrese su correo',
                                      labelText: 'Correo',
                                      prefixIcon: Icon(Icons.email),
                                      prefixStyle: TextStyle(height: 300)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  obscureText: true,
                                  initialValue: "",
                                  onChanged: (value) {
                                    formValues['pass'] = value;
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
                                      hintText: 'Ingrese su contraseña',
                                      labelText: 'Contraseña',
                                      prefixIcon: Icon(Icons.lock),
                                      prefixStyle: TextStyle(height: 300)),
                                ),
                                //Separacion
                                const SizedBox(
                                  height: 20,
                                ),
                                //Campo de Apellido Paterno
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
                                              FocusScope.of(context).unfocus();
                                              if (!myFormKey.currentState!
                                                  .validate()) {
                                                print('Formulario no valido');
                                                return;
                                              } else {
                                                final loginOk =
                                                    await authService.login(
                                                        formValues['user']
                                                            .toString()
                                                            .trim(),
                                                        formValues['pass']
                                                            .toString()
                                                            .trim());
                                                //Si es null es por que no hay internet
                                                if (loginOk != null) {
                                                  if (loginOk) {
                                                    //   socketService.connect();

                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context, 'loading');
                                                  } else {
                                                    await mostrarAlerta(
                                                        context,
                                                        "Login",
                                                        "Las credenciales son incorrectas.");
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context, 'login');
                                                  }
                                                } else {
                                                  await mostrarAlerta(
                                                      context,
                                                      "Error de conexión",
                                                      "Ha ocurrido un error, verifica tu conexión de internet");
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, 'login');
                                                }
                                              }
                                            },
                                      child: const SizedBox(
                                        width: double.infinity,
                                        height: 55,
                                        child: Center(
                                            child: Text(
                                          "Ingresar",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        )),
                                      )),
                                )
                              ]))),
                      const Labels(
                        ruta: 'registerCurp',
                        titulo: '¿No tienes cuenta?',
                        subTitulo: 'Crear una cuenta',
                      ),
                      const Text(
                        'Terminos y condiciones de uso',
                        style: TextStyle(fontWeight: FontWeight.w200),
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}
