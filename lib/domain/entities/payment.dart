import 'package:isar/isar.dart';

part 'payment.g.dart';

@collection
class Payment {
  Id id = Isar.autoIncrement;

  late String uuid; // Supabase UUID
  late int orderCode;
  late int amount;
  late String status;
  late String userId; // Foreign key to User (UUID)
  late DateTime createdAt;

  Payment({
    this.id = Isar.autoIncrement,
    required this.uuid,
    required this.orderCode,
    required this.amount,
    required this.status,
    required this.userId,
    required DateTime createdAt,
  }) : createdAt = createdAt;

  Payment copyWith({
    Id? id,
    String? uuid,
    int? orderCode,
    int? amount,
    String? status,
    String? userId,
    DateTime? createdAt,
  }) {
    return Payment(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      orderCode: orderCode ?? this.orderCode,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: Isar.autoIncrement,
      uuid: json['id'],
      orderCode: json['orderCode'],
      amount: json['amount'],
      status: json['status'],
      userId: json['userId'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'orderCode': orderCode,
      'amount': amount,
      'status': status,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
