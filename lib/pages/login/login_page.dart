import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outstock/Widgets/round_button.dart';
import 'package:outstock/Widgets/text_input.dart';
import 'package:outstock/controllers/user_controller.dart';
import 'package:outstock/controllers/user_database_controller.dart';
import 'package:outstock/pages/home/home_page.dart';
import 'package:outstock/pages/login/create_account_page.dart';
import 'package:outstock/repositories/stock_repository.dart';
import 'package:outstock/utils/theme_colors.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late StockRepository stockRepository;
  late Widget image;
  String? errorMessage;
  String pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = Image.asset('assets/images/outstock_transparent.png', width: 200);
  }

  @override
  Widget build(BuildContext context) {
    stockRepository = Provider.of<StockRepository>(context);
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              image,
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
              errorMessage == null
                  ? const SizedBox()
                  : Text(
                      errorMessage!,
                      style: TextStyle(color: MainTheme.red),
                    ),
              RoundButton(text: 'Entrar', onPressed: _onSubmitted),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: const Size(double.maxFinite, 0),
                        padding: const EdgeInsets.all(8)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const CreateAccountPage();
                      }));
                    },
                    child: const Text('Criar Conta')),
              )
            ],
          ),
        ),
      )),
    ));
  }

  _onSubmitted() async {
    if (_formKey.currentState!.validate()) {
      UserController user = UserController(
          userEmail: userEmail.text, userPassword: userPassword.text);
      errorMessage = await user.login();
      setState(() {
        errorMessage = errorMessage;
      });
      if (errorMessage == null) {
        UserDatabaseController databaseController =
            UserDatabaseController(user: user.auth.currentUser);
        stockRepository.allProducts = await databaseController.getProducts();
        stockRepository.products = stockRepository.allProducts;

        stockRepository.allStocks = await databaseController.getStocks();
        stockRepository.stocks = stockRepository.allStocks;
        
        stockRepository.updateProductsInStocks();
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const HomePage();
        }));
      }
    }
  }
}
