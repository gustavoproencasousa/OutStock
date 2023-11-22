import 'package:flutter/material.dart';
class TextoRuim extends StatelessWidget {
  String meuTexto;
  TextoRuim(this.meuTexto);

  @override
  Widget build(BuildContext context) {
    return Text(
        this.meuTexto + "\n",
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 15,
        ),
      );
  }
}
