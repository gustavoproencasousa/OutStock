import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:outstock/models/historic.dart';
import 'package:outstock/models/stock.dart';
import '../models/product.dart';

class UserDatabaseController {
  final User? user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserDatabaseController({required this.user});

  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    final snapshot = await _firestore
        .collection('usersData')
        .doc(user!.uid)
        .collection('products')
        .get();

    for (var document in snapshot.docs) {
      final data = document.data();
      products.add(Product(
        code: document.id,
        name: data['name'],
        category: data['category'],
        description: data['description'],
        weight: data['weight'].toDouble(),
        price: data['price'].toDouble(),
      ));
    }
    return products;
  }

  Future<void> insertProduct(Product product) async {
    await _firestore
        .collection('usersData')
        .doc(user!.uid)
        .collection('products')
        .doc(product.code)
        .set({
      'name': product.name,
      'category': product.category,
      'description': product.description,
      'weight': product.weight,
      'price': product.price,
    });
  }

  Future<void> deleteProduct(Product product) async {
    await _firestore
        .collection('usersData')
        .doc(user!.uid)
        .collection('products')
        .doc(product.code)
        .delete();
    print('sdaf');
  }

  Future<List<Stock>> getStocks() async {
    List<Stock> stocks = [];
    final snapshot = await _firestore
        .collection('usersData')
        .doc(user!.uid)
        .collection('stocks')
        .get();
    for (var data in snapshot.docs) {
      stocks.add(Stock(
        id: data.id,
        name: data['name'],
        address: data['address'],
        capacity: data['capacity'],
        productsAmount: (data['productsAmount'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, int.parse(value.toString()))),
      ));
    }
    return stocks;
  }

  Future<void> insertStock(Stock stock) async {
    await _firestore
        .collection('usersData')
        .doc(user!.uid)
        .collection('stocks')
        .doc(stock.id)
        .set({
      'name': stock.name,
      'address': stock.address,
      'capacity': stock.capacity,
      'productsAmount': stock.productsAmount
    });
  }

  Future<void> deleteStock(Stock stock) async {
    await _firestore
        .collection('usersData')
        .doc(user!.uid)
        .collection('stocks')
        .doc(stock.id)
        .delete();
  }

  Future<void> deleteProductFromStock(Stock stock, Product product) async {
    stock.productsAmount.remove(product.code);

    await _firestore
        .collection('usersData')
        .doc(user!.uid)
        .collection('stocks')
        .doc(stock.id)
        .set({
      'name': stock.name,
      'address': stock.address,
      'capacity': stock.capacity,
      'productsAmount': stock.productsAmount
    });
  }
}
