import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:outstock/Widgets/round_button.dart';
import 'package:outstock/Widgets/stock_card.dart';
import 'package:outstock/Widgets/text_input.dart';
import 'package:outstock/controllers/user_database_controller.dart';
import 'package:outstock/models/stock.dart';
import 'package:outstock/pages/home/stocks/add_stock_page.dart';
import 'package:outstock/pages/home/stocks/open_stock_page.dart';
import 'package:outstock/repositories/stock_repository.dart';
import 'package:provider/provider.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final stockName = TextEditingController();
  final stockAddress = TextEditingController();
  final stockCapacity = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late StockRepository stockRepository;

  @override
  Widget build(BuildContext context) {
    stockRepository = Provider.of<StockRepository>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Armazéns Cadastrados'),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: stockRepository.stocks.length,
              itemBuilder: (context, index) {
                return StockCard(
                    onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>OpenStockPage(stock: stockRepository.stocks[index]))),
                    onDelete: () async{
                      UserDatabaseController databaseController = UserDatabaseController(user: FirebaseAuth.instance.currentUser);

                      await databaseController.deleteStock(stockRepository.allStocks[index]);
                      stockRepository.allStocks = await databaseController.getStocks();
                      stockRepository.stocks = stockRepository.allStocks;
                    },
                    onEdit: ()=>Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AddStockPage(stock: stockRepository.stocks[index]))),
                    stock: stockRepository.stocks[index]);
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const AddStockPage())),
          child: const Icon(Icons.add),
        ),
        );
  }

  _onSubmitted() async {
    if (_formKey.currentState!.validate()) {}
  }

  String? _validator(value) {
    if (value!.isEmpty) return "Este campo não pode ser vazio";
  }
}
