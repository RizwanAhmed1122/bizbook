class Payment {
  Payment({
    required this.id,
    required this.type,
    required this.name,
    required this.amount,
    required this.note,
    required this.createdAt,
  });

  final String id;
  final String type;
  final String name;
  final double amount;
  final String note;
  final DateTime createdAt;

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] as String,
      type: map['type'] as String,
      name: map['name'] as String,
      amount: (map['amount'] as num).toDouble(),
      note: map['note'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'amount': amount,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
