import 'package:flutter/material.dart';

const Color colorPrincipal = Color(0xFF48BDFF);

const Color colorSecundario = Color(0xFF4795CD);

const Color colorTres = Color.fromRGBO(0, 0, 0, 0.5);

const kLogo = TextStyle(
  fontSize: 60,
  fontWeight: FontWeight.bold,
  color: colorPrincipal,
  fontFamily: 'Homenaje-Regular',
);

const kTitulo1 = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);

const kTitulo2 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 14.0,
);

const kTituloCabezera = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const kHintText = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
);

const kLineaDivisora = Divider(color: Colors.black);

ButtonStyle estiloBoton = ElevatedButton.styleFrom(
  side: const BorderSide(width: 2.0, color: colorSecundario),
  backgroundColor: colorPrincipal,
  foregroundColor: Colors.white,
  fixedSize: const Size(180.0, 50.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);
