import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/business_provider.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Consumer<BusinessProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Products: ${provider.products.length}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Customers: ${provider.customers.length}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Sales: ${provider.sales.length}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Purchases: ${provider.purchases.length}', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          );
        },
      ),
    );
  }
}
