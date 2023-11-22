import 'package:flutter/material.dart';
class Botoes extends StatelessWidget {
  final String texto;
  final void Function() onPressed;
  Botoes(this.texto, {required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(this.texto),
        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[850],
        onPrimary: Colors.white,
      ),

    );
  }
}
