import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/constraints.dart';
import '../../widgets/paciente/bottom_nav_bar_paciente.dart';

class PLogin extends StatelessWidget {
  const PLogin({Key? key}) : super(key: key);

  static String id = '/loginPaciente';

  @override
  Widget build(BuildContext context) {
    return const PLoginWidget();
  }
}

class PLoginWidget extends StatefulWidget {
  const PLoginWidget({Key? key}) : super(key: key);

  @override
  _PLoginWidgetState createState() => _PLoginWidgetState();
}

class _PLoginWidgetState extends State<PLoginWidget> {
  final _keyForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late bool _passwordVisible;

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    Navigator.pushNamed(context, PBottomNavBar.id);
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
                            Icon(Icons.camera_alt_outlined),
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
                            Icon(Icons.camera_alt_outlined),
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
                                    border: OutlineInputBorder(),
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
                      // SizedBox(
                      //   width: 200.0,
                      //   height: 260.0,
                      //   child: Flexible(
                      //     child: Image.asset('assets/image/deaf_person.png'),
                      //   ),
                      // )
                    ],
                  ),
                )
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
