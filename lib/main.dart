import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outstock/controllers/user_database_controller.dart';
import 'package:outstock/models/product.dart';
import 'package:outstock/models/stock.dart';
import 'package:outstock/pages/home/home_page.dart';
import 'package:outstock/pages/login/login_page.dart';
import 'package:outstock/repositories/stock_repository.dart';
import 'package:outstock/utils/theme_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth auth = FirebaseAuth.instance;

  Widget page = const LoginPage();
  List<Product> products = [];
  List<Stock> stocks = [];
  List<Product> productsInRepository = [];

  if (auth.currentUser?.uid != null) {
    try {
      UserDatabaseController databaseController =
          UserDatabaseController(user: auth.currentUser);
      products = await databaseController.getProducts();
      stocks = await databaseController.getStocks();
      for (var element in stocks) {
        for (var key in element.productsAmount.keys) {
          for (var product in products) {
            if (product.code == key) productsInRepository.add(product);
          }
        }
      }
      page = const HomePage();
    } catch (e) {
      debugPrint('Error $e');
    }
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<StockRepository>(
          create: (context) =>
              StockRepository(allProducts: products, allStocks: stocks, productsInRepository: productsInRepository))
    ],
    child: MyApp(page: page),
  ));
}

class MyApp extends StatelessWidget {
  final Widget page;
  const MyApp({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Out Stock',
        theme: MainTheme.lightTheme,
        home: page);
  }
}
