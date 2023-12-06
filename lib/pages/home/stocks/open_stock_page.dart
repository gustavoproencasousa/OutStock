import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outstock/Widgets/product_card.dart';
import 'package:outstock/Widgets/product_stock_card.dart';
import 'package:outstock/Widgets/round_button.dart';
import 'package:outstock/Widgets/text_input.dart';
import 'package:outstock/controllers/user_database_controller.dart';
import 'package:outstock/models/product.dart';
import 'package:outstock/models/stock.dart';
import 'package:outstock/repositories/stock_repository.dart';
import 'package:provider/provider.dart';

class OpenStockPage extends StatefulWidget {
  Stock stock;
  OpenStockPage({super.key, required this.stock});

  @override
  State<OpenStockPage> createState() => _OpenStockPageState();
}

class _OpenStockPageState extends State<OpenStockPage> {
  final amount = TextEditingController();
  Product? selectProduct;
  final _formKey = GlobalKey<FormState>();

  late StockRepository stockRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    stockRepository = Provider.of<StockRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stock.name),
        centerTitle: true,
      ),
      body: widget.stock.productsAmount.keys.isEmpty
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Flexible(child: Text('Nenhum produno neste armazém'))])
          : ListView.builder(
              itemCount: (stockRepository.allProducts.where((element) =>
                      widget.stock.productsAmount.keys.contains(element.code)))
                  .length,
              itemBuilder: (context, index) {
                Product product = stockRepository.allProducts[
                    stockRepository.allProducts.indexWhere((element) =>
                        element.code ==
                        widget.stock.productsAmount.keys.toList()[index])];
                return ProductStockCard(
                  stock: widget.stock,
                  onDelete: () async {
                    UserDatabaseController databaseController =
                        UserDatabaseController(
                            user: FirebaseAuth.instance.currentUser);

                    await databaseController.deleteProductFromStock(
                        widget.stock, product);
                    stockRepository.allStocks =
                        await databaseController.getStocks();
                    stockRepository.stocks = stockRepository.allStocks;
                    stockRepository.updateProductsInStocks();
                  },
                  editFunction: _editFunction,
                  amount: widget.stock.productsAmount.values.toList()[index],
                  product: product,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(child: StatefulBuilder(
                  builder: (context, setState) {
                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Adicionar produto ao estoque: ${widget.stock.name}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton(
                                        isExpanded: true,
                                        items: (stockRepository.allProducts
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(e.name),
                                                  value: e,
                                                ))
                                            .toList()),
                                        hint: Text('Selecione o produto'),
                                        value: selectProduct,
                                        onChanged: (Product? product) {
                                          setState(() {
                                            selectProduct = product;
                                          });
                                        }),
                                  )
                                ],
                              ),
                              TextFormInput(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                controller: amount,
                                validator: _validator,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                hint: '32 unidades',
                                label: 'Quantidade',
                              ),
                              RoundButton(
                                  text: 'Adicionar produto',
                                  margin: const EdgeInsets.all(4),
                                  onPressed: selectProduct == null
                                      ? null
                                      : _onSubmitted)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ));
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _onSubmitted() async {
    if (_formKey.currentState!.validate()) {
      if (!(widget.stock.productsAmount.keys.contains(selectProduct!.code))) {
        Map<String, int> tempAmount = widget.stock.productsAmount;
        tempAmount[selectProduct!.code] = int.parse(amount.text);

        UserDatabaseController databaseController =
            UserDatabaseController(user: FirebaseAuth.instance.currentUser);

        await databaseController.insertStock(Stock(
            name: widget.stock.name,
            address: widget.stock.address,
            capacity: widget.stock.capacity,
            id: widget.stock.id,
            productsAmount: tempAmount));

        stockRepository.allStocks = await databaseController.getStocks();
        stockRepository.stocks = stockRepository.allStocks;
        stockRepository.updateProductsInStocks();
        if (mounted) Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Este Produto já se encontra no armazém');
      }
    }
  }

  _editFunction(Product product, int amount) async {
    UserDatabaseController databaseController =
        UserDatabaseController(user: FirebaseAuth.instance.currentUser);
    Stock tempStock = widget.stock;
    tempStock.productsAmount[product.code] = amount;
    await databaseController.insertStock(tempStock);
    stockRepository.allStocks = await databaseController.getStocks();
    stockRepository.stocks = stockRepository.allStocks;
    stockRepository.updateProductsInStocks();
  }

  String? _validator(value) {
    if (value!.isEmpty) return "Este campo não pode ser vazio";
  }
}
