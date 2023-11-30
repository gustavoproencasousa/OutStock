import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outstock/TelaArmazem.dart';
import 'package:outstock/TelaProduto.dart';
import 'package:outstock/TelaSaldo.dart';
import 'Widgets/botaoenter.dart';
import 'home.dart';
import 'package:outstock/Widgets/textobom.dart';
import 'Widgets/botoes.dart';

class TelaSelect extends StatelessWidget {
  const TelaSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextoBom('Bem vindo ao OutStock'),
            BotaoEnter("Cadastrar Produto", onPressed: () {
              _clickCadProd(context, TelaProduto());
            }),
            BotaoEnter("Cadastrar Armazém", onPressed: () {
              _clickArmazem(context, TelaArmazem());
            }),
            BotaoEnter("Consultar saldo", onPressed: () {
              _ClickSaldo(context, TelaSaldo());
            }),
            Botoes("Voltar", onPressed: () {
              _ClickSaldo(context, Home());
            }),
          ],
        ),
      ),
    );
  }

  _clickCadProd(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  _clickArmazem(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  _ClickSaldo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
}
