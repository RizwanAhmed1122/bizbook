import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/purchase.dart';
import '../providers/business_provider.dart';
import 'supplier_screen.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchases'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SupplierScreen())),
            icon: const Icon(Icons.group_rounded),
          ),
        ],
      ),
      body: Consumer<BusinessProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.purchases.length,
            itemBuilder: (context, index) {
              final purchase = provider.purchases[index];
              return Card(
                child: ListTile(
                  title: Text(purchase.productName),
                  subtitle: Text('${purchase.supplierName} • Qty ${purchase.quantity}'),
                  trailing: Text('PKR ${purchase.total.toStringAsFixed(0)}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
