import 'package:outstock/Widgets/input.dart';
import 'package:flutter/material.dart';
import 'Widgets/botoes.dart';
import 'TelaSelect.dart';
import 'TelaCadastro.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _usuario = TextEditingController();
  final _senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Up Stocking"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputTextos("Usuário", "Usuário", controller: _usuario),
              InputTextos("Senha", "Senha", controller: _senha),
              Botoes("Logar", onPressed: _click),
              Botoes("Criar", onPressed: _cadastro)
            ]));
  }

  void _click() {
    String usuario = _usuario.text;
    String senha = _senha.text;
    setState(() {
      if (usuario == "001866" && senha == "40028922") {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const TelaSelect())));
      } else
        () {
          Text('Usuário ou senha incorreto');
        };
    });
  }

  void _cadastro() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const TelaCadastro())));
    });
  }
}
