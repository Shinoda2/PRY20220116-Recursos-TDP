import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pry20220116/screens/admin/login_admin.dart';
import 'package:pry20220116/screens/medico/login_medico.dart';
import 'package:pry20220116/screens/paciente/auth/login.dart';

import '../../utilities/constraints.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  static String id = '/';

  @override
  _Inicio createState() => _Inicio();
}

class _Inicio extends State<Inicio> {
  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 14);
  TextStyle linkStyle = TextStyle(color: Colors.blue);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrincipal,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Text("WISHA", style: kLogo),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPacientePage.id);
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 2.0, color: colorSecundario),
                    backgroundColor: colorPrincipal,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(180.0, 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text("PACIENTE"),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MLogin.id);
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 2.0, color: colorSecundario),
                    backgroundColor: colorPrincipal,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(180.0, 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text("MÉDICO"),
                ),
              ),
            ),
            Flexible(
              child: Image.asset('assets/image/medico.png'),
            ),
            Center(
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: "Eres administrador?", style: defaultStyle),
                  TextSpan(
                      text: "Iniciar sesión",
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            (() => Navigator.pushNamed(context, ALogin.id))),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
