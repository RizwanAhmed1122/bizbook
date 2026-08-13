class Sale {
  Sale({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.createdAt,
    required this.items,
    required this.discount,
    required this.total,
  });

  final String id;
  final String customerId;
  final String customerName;
  final DateTime createdAt;
  final List<Map<String, dynamic>> items;
  final double discount;
  final double total;

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'] as String,
      customerId: map['customerId'] as String,
      customerName: map['customerName'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      items: List<Map<String, dynamic>>.from(map['items'] as List),
      discount: (map['discount'] as num).toDouble(),
      total: (map['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'createdAt': createdAt.toIso8601String(),
      'items': items,
      'discount': discount,
      'total': total,
    };
  }
}
