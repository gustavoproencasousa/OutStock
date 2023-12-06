import 'package:flutter/material.dart';
import 'package:outstock/Widgets/balance_card.dart';
import 'package:outstock/repositories/stock_repository.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  late StockRepository stockRepository;

  @override
  Widget build(BuildContext context) {
    stockRepository = Provider.of<StockRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: stockRepository.allProducts.length,
          itemBuilder: (context, index) {
            return BalanceCard(
                product: stockRepository.allProducts[index],
                stocks: stockRepository.allStocks);
          }),
    );
  }
}
