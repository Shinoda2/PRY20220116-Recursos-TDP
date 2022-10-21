import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/constraints.dart';
import '../../widgets/medico/bottom_nav_bar_medico.dart';

class MLogin extends StatelessWidget {
  const MLogin({Key? key}) : super(key: key);

  static String id = '/loginMedico';

  @override
  Widget build(BuildContext context) {
    return const MLoginWidget();
  }
}

class MLoginWidget extends StatefulWidget {
  const MLoginWidget({Key? key}) : super(key: key);

  @override
  _MLoginWidgetState createState() => _MLoginWidgetState();
}

class _MLoginWidgetState extends State<MLoginWidget> {
  final _keyForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late bool _passwordVisible;

  Future signIn() async {
    try {
      showDialog(
        // The user CANNOT close this dialog  by pressing outside it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
              child: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Iniciando sesión...',
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ));
        },
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushNamed(context, MBottomNavBar.id);
    } on FirebaseAuthException catch (e) {
      showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(
                right: 20, left: 20, top: 20, bottom: 10.0),
            actionsPadding: const EdgeInsets.only(bottom: 10),
            title: const Text(
              'Autenticación Fallida',
              style: TextStyle(fontSize: 13),
            ),
            content: const Text(
                "Sus credenciales son incorrectas. Inténtelo nuevamente."),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "ACEPTAR",
                  style: TextStyle(fontSize: 10.0, color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
      if (e.code == 'user-not-found') {
        return "no se encontro usuario";
      } else if (e.code == "wrong-password") {
        return "contrasenia incorrecta";
      }
      return "algo salio mal";
    } catch (e) {
      return "algo salio mal";
    }

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 60.0),
                    child: Text('INICIAR SESIÓN', style: kTitulo1),
                  ),
                ),
                Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          children: [
                            const Icon(Icons.camera_alt_outlined),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 55.0,
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 13.0),
                                  controller: emailController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.deny(
                                        RegExp("[ ]")),
                                  ],
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    border: OutlineInputBorder(),
                                    labelText: "Correo",
                                    labelStyle: kHintText,
                                  ),
                                  validator: (value) {
                                    return validarTexto("Correo", value!);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          children: [
                            const Icon(Icons.camera_alt_outlined),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 55.0,
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 13.0),
                                  obscureText: !_passwordVisible,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    border: const OutlineInputBorder(),
                                    labelText: "Contraseña",
                                    labelStyle: kHintText,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      icon: Icon(_passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                  ),
                                  validator: (value) {
                                    return validatePassword(value!);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            if (_keyForm.currentState!.validate()) {
                              signIn();
                            }
                          },
                          child: Container(
                            width: 180.0,
                            height: 50.0,
                            padding: const EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                              color: colorPrincipal,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 2.0,
                                color: colorSecundario,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'INGRESAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validarTexto(String label, String value) {
  if (value.isEmpty) {
    return '$label es obligatorio';
  }
  return null;
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Contraseña es obligatorio';
  }
  if (value.length < 6) {
    return 'Contraseña debe tener mínimo 6 caracteres';
  }
  return null;
}
