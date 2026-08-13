import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sale.dart';
import '../providers/business_provider.dart';
import 'invoice_screen.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const InvoiceScreen())),
            icon: const Icon(Icons.receipt_long_rounded),
          ),
        ],
      ),
      body: Consumer<BusinessProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.sales.length,
            itemBuilder: (context, index) {
              final sale = provider.sales[index];
              return Card(
                child: ListTile(
                  title: Text(sale.customerName),
                  subtitle: Text('${sale.items.length} items • Discount ${sale.discount.toStringAsFixed(0)}%'),
                  trailing: Text('PKR ${sale.total.toStringAsFixed(0)}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
