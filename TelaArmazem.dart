import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outstock/TelaSelect.dart';
import 'package:outstock/Widgets/textobom.dart';
import 'Widgets/botoes.dart';
import 'package:outstock/Widgets/input.dart';




class TelaArmazem extends StatelessWidget {
  final _codigoarma = TextEditingController();
  final _descricaoarma = TextEditingController();
  final _local = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            InputTextos( "Código do armazem","Código do armazem",controller: _codigoarma),
            InputTextos( "Descricao armazem","Descricao armazem",controller: _descricaoarma),
            InputTextos( "Endereço","Endereço",controller: _local),
            Botoes("Confirmar",onPressed: _clickConfirmaArma),
            Botoes("Voltar",
                onPressed:(){ _clickvolta(context, TelaSelect());}),
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
  void _clickConfirmaArma(){
    TextoBom("Armazém cadastrado com sucesso!")
    ;}
}