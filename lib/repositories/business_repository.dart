import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/customer.dart';
import '../models/payment.dart';
import '../models/product.dart';
import '../models/purchase.dart';
import '../models/sale.dart';
import '../models/supplier.dart';

class BusinessRepository {
  BusinessRepository._();
  static final BusinessRepository instance = BusinessRepository._();

  late Box<String> _productsBox;
  late Box<String> _customersBox;
  late Box<String> _suppliersBox;
  late Box<String> _salesBox;
  late Box<String> _purchasesBox;
  late Box<String> _paymentsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _productsBox = await Hive.openBox<String>('products');
    _customersBox = await Hive.openBox<String>('customers');
    _suppliersBox = await Hive.openBox<String>('suppliers');
    _salesBox = await Hive.openBox<String>('sales');
    _purchasesBox = await Hive.openBox<String>('purchases');
    _paymentsBox = await Hive.openBox<String>('payments');
  }

  Future<void> addProduct(Product product) async {
    await _productsBox.put(product.id, jsonEncode(product.toMap()));
  }

  Future<List<Product>> getProducts() async {
    return _productsBox.values.map((value) => Product.fromMap(jsonDecode(value) as Map<String, dynamic>)).toList();
  }

  Future<void> addCustomer(Customer customer) async {
    await _customersBox.put(customer.id, jsonEncode(customer.toMap()));
  }

  Future<List<Customer>> getCustomers() async {
    return _customersBox.values.map((value) => Customer.fromMap(jsonDecode(value) as Map<String, dynamic>)).toList();
  }

  Future<void> addSupplier(Supplier supplier) async {
    await _suppliersBox.put(supplier.id, jsonEncode(supplier.toMap()));
  }

  Future<List<Supplier>> getSuppliers() async {
    return _suppliersBox.values.map((value) => Supplier.fromMap(jsonDecode(value) as Map<String, dynamic>)).toList();
  }

  Future<void> addSale(Sale sale) async {
    await _salesBox.put(sale.id, jsonEncode(sale.toMap()));
  }

  Future<List<Sale>> getSales() async {
    return _salesBox.values.map((value) => Sale.fromMap(jsonDecode(value) as Map<String, dynamic>)).toList();
  }

  Future<void> addPurchase(Purchase purchase) async {
    await _purchasesBox.put(purchase.id, jsonEncode(purchase.toMap()));
  }

  Future<List<Purchase>> getPurchases() async {
    return _purchasesBox.values.map((value) => Purchase.fromMap(jsonDecode(value) as Map<String, dynamic>)).toList();
  }

  Future<void> addPayment(Payment payment) async {
    await _paymentsBox.put(payment.id, jsonEncode(payment.toMap()));
  }

  Future<List<Payment>> getPayments() async {
    return _paymentsBox.values.map((value) => Payment.fromMap(jsonDecode(value) as Map<String, dynamic>)).toList();
  }
}
