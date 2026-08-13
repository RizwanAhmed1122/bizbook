import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/payment.dart';
import '../providers/business_provider.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _type = 'Customer';

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _showAddPaymentDialog(BuildContext context) async {
    final provider = context.read<BusinessProvider>();
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Record Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _type,
                items: const [
                  DropdownMenuItem(value: 'Customer', child: Text('Customer')),
                  DropdownMenuItem(value: 'Supplier', child: Text('Supplier')),
                ],
                onChanged: (value) => setState(() => _type = value ?? 'Customer'),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: _amountController, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: TextInputType.number),
              TextField(controller: _noteController, decoration: const InputDecoration(labelText: 'Note')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () async {
                final payment = Payment(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  type: _type,
                  name: _nameController.text.trim(),
                  amount: double.tryParse(_amountController.text) ?? 0,
                  note: _noteController.text.trim(),
                  createdAt: DateTime.now(),
                );
                await provider.addPayment(payment);
                if (!mounted) {
                  return;
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment recorded')));
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPaymentDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Payment'),
      ),
      body: Consumer<BusinessProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.payments.length,
            itemBuilder: (context, index) {
              final payment = provider.payments[index];
              return Card(
                child: ListTile(
                  title: Text(payment.name),
                  subtitle: Text('${payment.type} • ${payment.note}'),
                  trailing: Text('PKR ${payment.amount.toStringAsFixed(0)}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
