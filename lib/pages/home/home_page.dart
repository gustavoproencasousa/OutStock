import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outstock/Widgets/navigator_button.dart';
import 'package:outstock/controllers/user_controller.dart';
import 'package:outstock/pages/home/balance/balance_page.dart';
import 'package:outstock/pages/home/products/add_products_page.dart';
import 'package:outstock/pages/home/products/products_page.dart';
import 'package:outstock/pages/home/settings/settings_page.dart';
import 'package:outstock/pages/home/stocks/stock_page.dart';
import 'package:outstock/pages/login/login_page.dart';
import 'package:outstock/utils/theme_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(auth.currentUser!.email ?? ''),
        actions: [
          IconButton(
              onPressed: () async {
                await auth.signOut();
                if(!mounted)return;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                  return const LoginPage();
                }));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/outstock_transparent.png',
                    width: 200),
                Text('Bem-Vindo ao OutStock',
                    style: TextStyle(
                        fontSize: 24,
                        color: MainTheme.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const NavigatorButton(
                    page: ProductsPage(),
                    text: 'Cadastrar Produtos',
                    icon: Icon(Icons.shopping_cart)),
                const NavigatorButton(
                  page: StockPage(),
                  text: 'Cadastrar Armazéns',
                  icon: Icon(Icons.inventory),
                ),
                const NavigatorButton(
                  page: BalancePage(),
                  text: 'Consultar Saldo',
                  icon: Icon(Icons.attach_money),
                ),
                const NavigatorButton(
                  page: SettingsPage(),
                  text: 'Configurações',
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
