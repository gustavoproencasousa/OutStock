import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:outstock/Widgets/round_button.dart';
import 'package:outstock/Widgets/text_input.dart';
import 'package:outstock/controllers/user_database_controller.dart';
import 'package:outstock/models/product.dart';
import 'package:outstock/models/stock.dart';
import 'package:outstock/repositories/stock_repository.dart';
import 'package:outstock/utils/theme_colors.dart';

class ProductStockCard extends StatefulWidget {
  final Product product;
  final int amount;
  final Stock stock;
  final void Function()? onDelete;
  final void Function(Product product, int amount)? editFunction;
  const ProductStockCard(
      {super.key,
      required this.product,
      required this.amount,
      required this.stock,
      this.onDelete,
      this.editFunction});

  @override
  State<ProductStockCard> createState() => _ProductStockCardState();
}

class _ProductStockCardState extends State<ProductStockCard> {
  final amountProduct = TextEditingController();
  final description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amountProduct.text = widget.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: MainTheme.white,
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Text('Código: ${widget.product.code}'))
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const SizedBox(height: 8),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text('Nome:\n${widget.product.name}',
                            textAlign: TextAlign.center)),
                    Flexible(
                        child: Text('Categoria:\n${widget.product.category}',
                            textAlign: TextAlign.center)),
                    Flexible(
                        child: Text('Peso:\n${widget.product.weight} Kg',
                            textAlign: TextAlign.center)),
                    Flexible(
                        child: Text(
                            'Preço:\nR\$ ${widget.product.price.toStringAsFixed(2)}',
                            textAlign: TextAlign.center))
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                Row(
                  children: [
                    Flexible(
                        child: Text('Descrição: ${widget.product.description}'))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            'Quantidade em Estoque: ${amountProduct.text}')),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            amountProduct.text =
                                (int.parse(amountProduct.text) + 1).toString();
                          });
                        },
                        icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: () {
                          if (int.parse(amountProduct.text) > 0) {
                            setState(() {
                              amountProduct.text =
                                  (int.parse(amountProduct.text) - 1)
                                      .toString();
                            });
                          }
                        },
                        icon: const Icon(Icons.remove))
                  ],
                ),
                widget.amount == int.parse(amountProduct.text)
                    ? const SizedBox()
                    : RoundButton(text: 'Salvar Alterações', onPressed: () =>widget.editFunction!(widget.product,int.parse(amountProduct.text))),
              ],
            ),
            IconButton(
                onPressed: widget.onDelete, icon: const Icon(Icons.delete))
          ],
        ));
  }
}
