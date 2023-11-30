import 'package:flutter/material.dart';

class BotaoEnter extends StatelessWidget {
  final String texto;
  final void Function() onPressed;
  BotaoEnter(this.texto, {required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(this.texto),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[850],
        onPrimary: Colors.white,
      ),
    );
  }
}
