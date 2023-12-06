import 'package:outstock/models/historic.dart';

class Stock {
  String id;
  String name;
  String address;
  int capacity;
  Map<String, int> productsAmount;

  Stock(
      {required this.name,
      required this.address,
      required this.capacity,
      required this.id,
      required this.productsAmount
    });

  Stock.empty({
    this.name = '',
    this.address = '',
    this.capacity = 0,
    this.id = '',
    this.productsAmount = const {},
  });
}
