import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outstock/TelaSelect.dart';
import 'package:outstock/Widgets/textobom.dart';
import 'Widgets/botoes.dart';
import 'package:outstock/Widgets/input.dart';



class TelaProduto extends StatelessWidget {
  final _codigo = TextEditingController();
  final _descricao = TextEditingController();
  final _armazem = TextEditingController();
  final _quantidade = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              InputTextos( "Part Number","Part Number",controller: _quantidade),
              InputTextos( "Descricao","Descricao",controller: _descricao),
              InputTextos( "Quantidade","Quantidade",controller: _descricao),
              InputTextos( "Armazem","Armazem",controller: _armazem),
              Botoes("Confirmar",onPressed: _clickConfirma),
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
  void _clickConfirma(){
      TextoBom("Produto cadastrado com sucesso!")
    ;}
}