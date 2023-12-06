import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outstock/Widgets/round_button.dart';
import 'package:outstock/Widgets/text_input.dart';
import 'package:outstock/controllers/user_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormInput(
                controller: oldPassword,
                hint: 'senha123',
                label: 'Senha antiga',
                obscure: true,
                validator: (value) {
                  if (value!.isEmpty) return 'O campo é obrigatório';
                  if (value.length < 6) return 'Informe no mínimo 6 caracteres';
                },
              ),
              TextFormInput(
                controller: newPassword,
                hint: 'senha123',
                label: 'Nova senha',
                obscure: true,
                validator: (value) {
                  if (value!.isEmpty) return 'O campo é obrigatório';
                  if (value.length < 6) return 'Informe no mínimo 6 caracteres';
                  if (value != confirmPassword.text)
                    return 'Senhas não coincidem';
                },
              ),
              TextFormInput(
                controller: confirmPassword,
                hint: 'senha123',
                label: 'Confirmar nova senha',
                obscure: true,
                validator: (value) {
                  if (value!.isEmpty) return 'O campo é obrigatório';
                  if (value.length < 6) return 'Informe no mínimo 6 caracteres';
                  if (value != newPassword.text) return 'Senhas não coincidem';
                },
              ),
              RoundButton(text: 'Alterar Senha', onPressed: _onSubmitted)
            ],
          ),
        ),
      ),
    );
  }

  _onSubmitted() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserController controller = UserController(
            userEmail: FirebaseAuth.instance.currentUser!.email!,
            userPassword: oldPassword.text);
        await controller.login();
        await controller.changePassword(newPassword.text);
        Fluttertoast.showToast(msg: 'Senha alterada com sucesso');
        if(mounted) Navigator.pop(context);
      } catch (e) {
        debugPrint('Error: $e');
        Fluttertoast.showToast(msg: 'Não foi possível alterar a senha');
      }
    }
  }
}
