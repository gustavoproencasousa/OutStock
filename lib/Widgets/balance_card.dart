import 'package:flutter/material.dart';
import 'package:outstock/models/product.dart';
import 'package:outstock/models/stock.dart';
import 'package:outstock/utils/theme_colors.dart';

class BalanceCard extends StatelessWidget {
  final Product product;
  final List<Stock> stocks;
  final EdgeInsets? margin;
  const BalanceCard(
      {super.key,
      required this.stocks,
      required this.product,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MainTheme.white,
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
      child: Column(
        children: [
          Row(
            children: [Flexible(child: Text('Código: ${product.code}'))],
          ),
          Row(
            children: [Flexible(child: Text('Produto: ${product.name}'))],
          ),
          Row(
            children: [Flexible(child: Text('Quantidade: ${_getAmount()}'))],
          )
        ],
      ),
    );
  }
  int _getAmount(){
    int amount = 0;
    for (var stock in stocks) { 
      stock.productsAmount.forEach((key, value) {
        if(key==product.code){
          amount+=value;
        }
      });
    }
    return amount;
  }
}
