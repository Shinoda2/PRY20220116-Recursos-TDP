//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:pry20220116/widgets/input_with_help.dart';
import 'package:pry20220116/widgets/primary_button.dart';
import 'package:pry20220116/widgets/with_tooltip.dart';

class LoginMedico extends StatefulWidget {
  @override
  _LoginMedicoState createState() => _LoginMedicoState();
}

class _LoginMedicoState extends State<LoginMedico> {

  String user = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 60),
              child: Text( "BIENVENIDO",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Form(
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "USUARIO",
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white,
                        filled: true
                      ),
                      keyboardType: TextInputType.name,
                      onChanged: (value) => setState(()=>user = value),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "CONTRASEÑA",
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onChanged: (value) => setState(()=> password = value),
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (context)=> AlertDialog(
                                title: Text('Error'),
                                content: Text('Usuario o contraseña incorrectos. Inténtelo nuevamente',
                                  style: TextStyle(color: Colors.red),
                                ),
                                actions: <Widget>[
                                  FlatButton(onPressed: () {  },
                                  child: Text('Ok')),
                                ],
                              ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                          fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(300)),
                          foregroundColor: MaterialStateProperty.all(Colors.black)
                        ),
                        child: Text("INGRESAR",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}