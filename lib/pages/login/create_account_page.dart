import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outstock/Widgets/text_input.dart';

import '../../Widgets/round_button.dart';
import '../../controllers/user_controller.dart';
import '../../utils/theme_colors.dart';
import '../home/home_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final userPassword = TextEditingController();
  final userEmail = TextEditingController();
  final confirmPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  String pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
              child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/outstock_transparent.png', width: 200),
              TextFormInput(
                controller: userEmail,
                icon: Icons.email,
                label: 'Email',
                hint: 'example@mail.com',
                validator: (value) {
                  if (value!.isEmpty) return 'O campo é obrigatório';
                  if (!RegExp(pattern).hasMatch(value)) {
                    return "Obrigatório um e-mail válido";
                  }
                  return null;
                },
              ),
              TextFormInput(
                controller: userPassword,
                onFieldSubmitted: (value) => _onSubmitted,
                label: 'Senha',
                icon: Icons.lock,
                obscure: true,
                validator: (value) {
                  if (value!.isEmpty) return 'O campo é obrigatório';
                  if (value.length < 6) return 'Informe no mínimo 6 caracteres';
                },
                hint: 'pass1234',
              ),
              TextFormInput(
                controller: confirmPass,
                onFieldSubmitted: (value) => _onSubmitted,
                label: 'Confirmar senha',
                icon: Icons.lock,
                obscure: true,
                validator: (value) {
                  if (value!.isEmpty) return 'O campo é obrigatório';
                  if (value.length < 6) return 'Informe no mínimo 6 caracteres';
                  if (value != userPassword.text)
                    return 'As senhas não conferem';
                },
                hint: 'pass1234',
              ),
              errorMessage == null
                  ? const SizedBox()
                  : Text(
                      errorMessage!,
                      style: TextStyle(color: MainTheme.red),
                    ),
              RoundButton(text: 'Criar', onPressed: _onSubmitted),
            ],
          ),
        ),
      ))),
    );
  }

  _onSubmitted() async {
    if (_formKey.currentState!.validate()) {
      UserController user = UserController(
          userEmail: userEmail.text, userPassword: userPassword.text);
      errorMessage = await user.createAccount();
      setState(() {
        errorMessage = errorMessage;
      });
      _clearTextControllers();
      Fluttertoast.showToast(msg: 'Conta criada com sucesso.');
    }
  }

  _clearTextControllers() {
    confirmPass.clear();
    userEmail.clear();
    userPassword.clear();
  }
}
