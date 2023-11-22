import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outstock/TelaSelect.dart';
import 'package:outstock/Widgets/textobom.dart';
import 'Widgets/botoes.dart';
import 'package:outstock/Widgets/input.dart';




class TelaSaldo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text('Produto: 68156-09232  Quantia:1000   Endereço:E1A2', style: TextStyle(fontSize: 15,),),
            Text('Produto: N1WB-0P21  Quantia:20   Endereço:E5A4', style: TextStyle(fontSize: 15,),),
            Text('Produto: 1378-3467  Quantia:500   Endereço:E6A7', style: TextStyle(fontSize: 15,),),
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