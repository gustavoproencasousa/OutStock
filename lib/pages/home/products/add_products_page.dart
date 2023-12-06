import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outstock/Widgets/product_card.dart';
import 'package:outstock/Widgets/round_button.dart';
import 'package:outstock/controllers/user_database_controller.dart';
import 'package:outstock/models/product.dart';
import 'package:outstock/repositories/stock_repository.dart';
import 'package:outstock/utils/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:uuid/v4.dart';

import '../../../Widgets/text_input.dart';

class AddProductPage extends StatefulWidget {
  Product? product;
  AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final productName = TextEditingController();
  final productCategory = TextEditingController();
  final productDescription = TextEditingController();
  final productWeight = TextEditingController();
  final productPrice = TextEditingController();
  final productCode = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late StockRepository stockRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productCode.text = const UuidV4().generate().substring(0, 7);

    if (widget.product != null) {
      productName.text = widget.product!.name;
      productCategory.text = widget.product!.category;
      productDescription.text = widget.product!.description;
      productPrice.text = widget.product!.price.toString();
      productWeight.text = widget.product!.weight.toString();
      productCode.text = widget.product!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    stockRepository = Provider.of<StockRepository>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.product!=null?'Editar Produto':'Cadastrar Produto'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormInput(
                      enable: false,
                      validator: _validator,
                      controller: productCode,
                      icon: Icons.code,
                      hint: 'Código x',
                      label: 'Código do Produto',
                    ),
                    TextFormInput(
                      validator: _validator,
                      controller: productName,
                      icon: Icons.sell,
                      hint: 'Produto X',
                      label: 'Nome do Produto',
                    ),
                    TextFormInput(
                      validator: _validator,
                      controller: productCategory,
                      icon: Icons.category,
                      hint: 'Categoria X',
                      label: 'Categoria',
                    ),
                    TextFormInput(
                      validator: _validator,
                      controller: productDescription,
                      icon: Icons.description,
                      hint: 'Descrição do produto',
                      label: 'Descrição',
                    ),
                    TextFormInput(
                      validator: _validator,
                      controller: productWeight,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*$'))
                      ],
                      icon: Icons.scale,
                      hint: '1 Kg',
                      label: 'Peso',
                    ),
                    TextFormInput(
                      validator: _validator,
                      controller: productPrice,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*$'))
                      ],
                      icon: Icons.paid,
                      hint: '10,00',
                      label: 'Preço',
                    ),
                    RoundButton(text: widget.product==null?'Cadastrar produto':'Salvar alterações', onPressed: _onSubmitted),
                    widget.product != null
                        ? RoundButton(
                            text: 'Cancelar',
                            onPressed: _cancelEdit,
                            backgroundColor: MainTheme.red,
                          )
                        : const SizedBox()
                  ],
                )),
          ),
        ));
  }

  _onSubmitted() async {
    if (_formKey.currentState!.validate()) {
      FirebaseAuth auth = FirebaseAuth.instance;
      try {
        UserDatabaseController databaseController =
            UserDatabaseController(user: auth.currentUser);
        await databaseController.insertProduct(Product(
          code: productCode.text,
          name: productName.text,
          category: productCategory.text,
          description: productDescription.text,
          weight: double.parse(productWeight.text),
          price: double.parse(productPrice.text),
        ));
        _clearAllTextControllers();
        stockRepository.allProducts = await databaseController.getProducts();
        stockRepository.products = stockRepository.allProducts;
        Fluttertoast.showToast(msg: widget.product == null?'Produto cadastrado com sucesso':'Produto editado com sucesso');
        setState(() => widget.product = null);
      } catch (e) {
        debugPrint('Error: $e');
      } finally {}
    }
  }

  String? _validator(value) {
    if (value!.isEmpty) return "Este campo não pode ser vazio";
  }

  _clearAllTextControllers() {
    productName.clear();
    productCategory.clear();
    productDescription.clear();
    productPrice.clear();
    productWeight.clear();
    productCode.text = const UuidV4().generate().substring(0, 7);
  }

  _cancelEdit() {
    Navigator.pop(context);
  }
}
