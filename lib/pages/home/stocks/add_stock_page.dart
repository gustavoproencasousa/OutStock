import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outstock/Widgets/round_button.dart';
import 'package:outstock/Widgets/text_input.dart';
import 'package:outstock/controllers/user_database_controller.dart';
import 'package:outstock/models/product.dart';
import 'package:outstock/models/stock.dart';
import 'package:outstock/repositories/stock_repository.dart';
import 'package:outstock/utils/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:uuid/v4.dart';

class AddStockPage extends StatefulWidget {
  final Stock? stock;
  const AddStockPage({super.key, this.stock});

  @override
  State<AddStockPage> createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final stockName = TextEditingController();
  final stockAddress = TextEditingController();
  final stockCapacity = TextEditingController();
  final stockCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late StockRepository stockRepository;

  Map<String, int>? amount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stockCode.text = const UuidV4().generate().substring(0, 7);
    if (widget.stock != null) {
      stockName.text = widget.stock!.name;
      stockAddress.text = widget.stock!.address;
      stockCapacity.text = widget.stock!.capacity.toString();
      stockCode.text = widget.stock!.id;
      amount = widget.stock!.productsAmount;
    }
  }

  @override
  Widget build(BuildContext context) {
    stockRepository = Provider.of<StockRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.stock != null ? 'Editar Armazém' : 'Cadastrar Armazém'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormInput(
                  enable: false,
                  validator: _validator,
                  controller: stockCode,
                  icon: Icons.code,
                  hint: 'Código x',
                  label: 'Código do Armazém',
                ),
                TextFormInput(
                  controller: stockName,
                  validator: _validator,
                  hint: 'Armazém X',
                  icon: Icons.description,
                  label: 'Nome do Armazém',
                ),
                TextFormInput(
                  controller: stockAddress,
                  validator: _validator,
                  hint: 'Endereçp X',
                  icon: Icons.location_on,
                  label: 'Endereço do Armazém',
                ),
                TextFormInput(
                  controller: stockCapacity,
                  validator: _validator,
                  hint: '30 m²',
                  icon: Icons.account_tree,
                  label: 'Capacidade do armazém',
                ),
                RoundButton(text:widget.stock != null? 'Editar' : 'Cadastrar', onPressed: _onSubmitted),
                widget.stock != null
                    ? RoundButton(
                        text: 'Cancelar',
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: MainTheme.red,
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onSubmitted() async {
    if (_formKey.currentState!.validate()) {
      UserDatabaseController databaseController =
          UserDatabaseController(user: FirebaseAuth.instance.currentUser);

      await databaseController.insertStock(Stock(
          name: stockName.text,
          address: stockAddress.text,
          capacity: int.parse(stockCapacity.text),
          id: stockCode.text,
          productsAmount: amount ?? {}));
      stockRepository.allStocks = await databaseController.getStocks();
      stockRepository.stocks = stockRepository.allStocks;
      _cleanTextControllers();
      Fluttertoast.showToast(
          msg: widget.stock != null
              ? 'Armazém editado'
              : 'Armazém cadastrado');
      if (mounted && widget.stock != null) Navigator.pop(context);
    }
  }

  _cleanTextControllers() {
    stockName.clear();
    stockAddress.clear();
    stockCapacity.clear();
    stockCode.text = const UuidV4().generate().substring(0, 7);
  }

  String? _validator(value) {
    if (value!.isEmpty) return "Este campo não pode ser vazio";
  }
}
