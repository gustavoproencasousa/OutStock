import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outstock/home.dart';
import 'package:outstock/Widgets/textobom.dart';
import 'Widgets/botoes.dart';
import 'Widgets/input.dart';

final _usuario = TextEditingController();
final _senha = TextEditingController();

class TelaCadastro extends StatelessWidget {
  const TelaCadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InputTextos("Usuário", "Usuário", controller: _usuario),
            InputTextos("Senha", "Senha", controller: _senha),
            Botoes("Voltar", onPressed: () {
              _clickvolta(context, Home());
            }),
          ],
        ),
      ),
    );
  }

  _clickvolta(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
}
