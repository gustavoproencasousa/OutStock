import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outstock/Widgets/product_card.dart';
import 'package:outstock/Widgets/round_button.dart';
import 'package:outstock/Widgets/text_input.dart';
import 'package:outstock/controllers/user_database_controller.dart';
import 'package:outstock/models/product.dart';
import 'package:outstock/pages/home/products/add_products_page.dart';
import 'package:outstock/repositories/stock_repository.dart';
import 'package:outstock/utils/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:uuid/data.dart';
import 'package:uuid/v4.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late StockRepository stockRepository;

  @override
  Widget build(BuildContext context) {
    stockRepository = Provider.of<StockRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos Cadastrados'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          stockRepository.allProducts.isEmpty?
          SliverList.list(children: const [Row(mainAxisAlignment: MainAxisAlignment.center,children: [Flexible(child: Text('Nenhum Produto Cadastrado.'))])])
          :
          SliverList.builder(
            itemCount: stockRepository.products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: stockRepository.products[index],
                editFunction: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage(product: stockRepository.products[index]))),
                deleteFunction: ()async{
                  UserDatabaseController databaseController = UserDatabaseController(user: FirebaseAuth.instance.currentUser);
                  if(stockRepository.productsInRepository.where((element) => element.code==stockRepository.products[index].code).isNotEmpty){
                    Fluttertoast.showToast(msg: 'Este produto não pode ser excluído pois está registrado em algum armazém.');
                    return;
                  };
                  try{
                    await databaseController.deleteProduct(stockRepository.products[index]);
                    stockRepository.allProducts = await databaseController.getProducts();
                    stockRepository.products = stockRepository.allProducts;
                  }catch(e){
                    debugPrint('Error: $e');
                  }
                },
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddProductPage())),
        child: const Icon(Icons.add),
      ),
    );
  }

  
}
