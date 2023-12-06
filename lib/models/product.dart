class Product {
  String code;
  String name;
  String category;
  String description;
  double weight;
  double price;

  Product(
      {required this.code,
      required this.name,
      required this.category,
      required this.description,
      required this.weight,
      required this.price,
      });

  Product.empty(
      {this.code = '',
      this.name = '',
      this.category = '',
      this.description = '',
      this.weight = 0,
      this.price = 0,
      });
}
