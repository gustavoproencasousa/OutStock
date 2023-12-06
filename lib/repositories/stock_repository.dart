import 'package:flutter/cupertino.dart';
import 'package:outstock/models/product.dart';
import 'package:outstock/models/stock.dart';

class StockRepository extends ChangeNotifier {
  List<Product> allProducts;
  late List<Product> _products;
  List<Product> _productsInRepository;

  List<Stock> allStocks;
  late List<Stock> _stocks;

  StockRepository(
      {required this.allProducts,
      required this.allStocks,
      required List<Product> productsInRepository})
      : _productsInRepository = productsInRepository {
    _products = allProducts;
    _stocks = allStocks;
  }

  List<Product> get productsInRepository => _productsInRepository;

  set productsInRepository(List<Product> value) {
    _productsInRepository = value;
    notifyListeners();
  }

  List<Stock> get stocks => _stocks;

  set stocks(List<Stock> value) {
    _stocks = value;

    notifyListeners();
  }

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
    notifyListeners();
  }

  updateProductsInStocks() {
    productsInRepository = [];
    for (var element in allStocks) {
      if (element.productsAmount.keys.isNotEmpty) {
        for (var key in element.productsAmount.keys) {
          for (var product in allProducts) {
            if (product.code == key) productsInRepository.add(product);
          }
        }
      }
    }
  }
}
