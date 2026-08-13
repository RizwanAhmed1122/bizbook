import 'package:flutter/material.dart';

import '../models/customer.dart';
import '../models/payment.dart';
import '../models/product.dart';
import '../models/purchase.dart';
import '../models/sale.dart';
import '../models/supplier.dart';
import '../repositories/business_repository.dart';

class BusinessProvider extends ChangeNotifier {
  BusinessProvider() {
    init();
  }

  final BusinessRepository _repository = BusinessRepository.instance;

  List<Product> _products = [];
  List<Customer> _customers = [];
  List<Supplier> _suppliers = [];
  List<Sale> _sales = [];
  List<Purchase> _purchases = [];
  List<Payment> _payments = [];

  List<Product> get products => _products;
  List<Customer> get customers => _customers;
  List<Supplier> get suppliers => _suppliers;
  List<Sale> get sales => _sales;
  List<Purchase> get purchases => _purchases;
  List<Payment> get payments => _payments;

  Future<void> init() async {
    await _repository.init();
    await load();
  }

  Future<void> load() async {
    _products = await _repository.getProducts();
    _customers = await _repository.getCustomers();
    _suppliers = await _repository.getSuppliers();
    _sales = await _repository.getSales();
    _purchases = await _repository.getPurchases();
    _payments = await _repository.getPayments();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _repository.addProduct(product);
    _products.add(product);
    notifyListeners();
  }

  Future<void> addCustomer(Customer customer) async {
    await _repository.addCustomer(customer);
    _customers.add(customer);
    notifyListeners();
  }

  Future<void> addSupplier(Supplier supplier) async {
    await _repository.addSupplier(supplier);
    _suppliers.add(supplier);
    notifyListeners();
  }

  Future<void> addSale(Sale sale) async {
    await _repository.addSale(sale);
    _sales.add(sale);
    notifyListeners();
  }

  Future<void> addPurchase(Purchase purchase) async {
    await _repository.addPurchase(purchase);
    _purchases.add(purchase);
    notifyListeners();
  }

  Future<void> addPayment(Payment payment) async {
    await _repository.addPayment(payment);
    _payments.add(payment);
    notifyListeners();
  }
}
