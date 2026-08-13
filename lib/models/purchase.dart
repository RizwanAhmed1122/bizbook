class Purchase {
  Purchase({
    required this.id,
    required this.supplierId,
    required this.supplierName,
    required this.createdAt,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });

  final String id;
  final String supplierId;
  final String supplierName;
  final DateTime createdAt;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double total;

  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'] as String,
      supplierId: map['supplierId'] as String,
      supplierName: map['supplierName'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      productName: map['productName'] as String,
      quantity: (map['quantity'] as num).toInt(),
      unitPrice: (map['unitPrice'] as num).toDouble(),
      total: (map['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'supplierId': supplierId,
      'supplierName': supplierName,
      'createdAt': createdAt.toIso8601String(),
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'total': total,
    };
  }
}
