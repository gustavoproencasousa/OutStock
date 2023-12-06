import 'package:flutter/material.dart';
import 'package:outstock/models/product.dart';
import 'package:outstock/utils/theme_colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function()? editFunction;
  final void Function()? deleteFunction;
  final int? amount;
  const ProductCard({super.key, required this.product, this.editFunction, this.deleteFunction,this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: MainTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Text('Código: ${product.code}'))
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text('Nome:\n${product.name}',
                            textAlign: TextAlign.center)),
                    Flexible(
                        child: Text('Categoria:\n${product.category}',
                            textAlign: TextAlign.center)),
                    Flexible(
                        child: Text('Peso:\n${product.weight} Kg',
                            textAlign: TextAlign.center)),
                    Flexible(
                        child: Text(
                            'Preço:\nR\$ ${product.price.toStringAsFixed(2)}',
                            textAlign: TextAlign.center))
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                Row(
                  children: [
                    Flexible(child: Text('Descrição: ${product.description}'))
                  ],
                ),
                amount!=null?Row(
                  children: [
                    Flexible(child: Text('Quantidade em Estoque: ${amount}'))
                  ],
                ):const SizedBox()
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: deleteFunction, icon: const Icon(Icons.delete)),
              IconButton(onPressed: editFunction, icon: const Icon(Icons.edit))
            ],
          )
        ],
      ),
    );
  }
}
