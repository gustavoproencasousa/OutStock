import 'package:flutter/material.dart';
import 'package:outstock/models/stock.dart';
import 'package:outstock/utils/theme_colors.dart';

class StockCard extends StatelessWidget {
  final void Function()? onDelete;
  final void Function()? onEdit;
  final void Function()? onTap;
  final Stock stock;
  const StockCard({super.key, this.onDelete, required this.stock, this.onEdit, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: MainTheme.white,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Icon(Icons.arrow_right_alt)],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.description),
                        Expanded(child: Text('Nome: ${stock.name}')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on),
                        Expanded(child: Text('Endereço: ${stock.address}')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.account_tree),
                        Expanded(child: Text('Capacidade: ${stock.capacity} m²')),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: onDelete, icon: const Icon(Icons.delete))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
