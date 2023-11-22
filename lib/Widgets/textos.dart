import 'package:flutter/material.dart';
class Textos extends StatelessWidget {
  String meuTexto;
  Textos(this.meuTexto);

  @override
  Widget build(BuildContext context) {
    return Text(
        this.meuTexto + "\n",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      );
  }
}
