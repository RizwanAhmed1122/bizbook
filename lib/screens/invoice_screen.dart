import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/business_provider.dart';
import '../repositories/invoice_generator.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final _customerController = TextEditingController(text: 'Walk-in');
  final _discountController = TextEditingController(text: '0');
  final _quantityController = TextEditingController(text: '1');
  final _priceController = TextEditingController(text: '100');
  final _nameController = TextEditingController(text: 'Item');

  @override
  void dispose() {
    _customerController.dispose();
    _discountController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BusinessProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Create Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _customerController, decoration: const InputDecoration(labelText: 'Customer')),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Item')),
            TextField(controller: _quantityController, decoration: const InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            TextField(controller: _discountController, decoration: const InputDecoration(labelText: 'Discount %'), keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final items = [
                  {
                    'name': _nameController.text,
                    'quantity': int.tryParse(_quantityController.text) ?? 1,
                    'price': double.tryParse(_priceController.text) ?? 0,
                  }
                ];
                final discount = double.tryParse(_discountController.text) ?? 0;
                final total = (items.first['price'] as double) * (items.first['quantity'] as int) * (1 - discount / 100);
                final path = await InvoiceGenerator.generatePdf(
                  customerName: _customerController.text,
                  items: items.map((e) => Map<String, dynamic>.from(e)).toList(),
                  discount: discount,
                  total: total,
                );
                await InvoiceGenerator.shareInvoice(path);
              },
              child: const Text('Generate Invoice'),
            ),
            const SizedBox(height: 16),
            Text('Products: ${provider.products.length}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
