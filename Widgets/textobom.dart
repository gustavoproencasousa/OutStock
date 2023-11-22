import 'package:flutter/material.dart';
class TextoBom extends StatelessWidget {
  String meuTexto;
  TextoBom(this.meuTexto);

  @override
  Widget build(BuildContext context) {
    return Text(
        this.meuTexto + "\n",
        style: TextStyle(
          color: Colors.green,
          fontSize: 25,
        ),
      );
  }
}
