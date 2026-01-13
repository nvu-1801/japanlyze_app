import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;

  late String name;
  late String email;
  String? avatarUrl;
  late String role; // 'user', 'admin'
  bool isPremium = false;
  DateTime? premiumUntil;
  int streakCount = 0;
  int exp = 0;
  int level = 1;
  late DateTime createdAt;
  DateTime? updatedAt;

  User({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.role = 'user',
    this.isPremium = false,
    this.premiumUntil,
    this.streakCount = 0,
    this.exp = 0,
    this.level = 1,
    required DateTime createdAt,
    this.updatedAt,
  }) : createdAt = createdAt;

  User copyWith({
    Id? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? role,
    bool? isPremium,
    DateTime? premiumUntil,
    int? streakCount,
    int? exp,
    int? level,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      isPremium: isPremium ?? this.isPremium,
      premiumUntil: premiumUntil ?? this.premiumUntil,
      streakCount: streakCount ?? this.streakCount,
      exp: exp ?? this.exp,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? Isar.autoIncrement,
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      role: json['role'] ?? 'user',
      isPremium: json['isPremium'] ?? false,
      premiumUntil: json['premiumUntil'] != null
          ? DateTime.parse(json['premiumUntil'])
          : null,
      streakCount: json['streakCount'] ?? 0,
      exp: json['exp'] ?? 0,
      level: json['level'] ?? 1,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'role': role,
      'isPremium': isPremium,
      'premiumUntil': premiumUntil?.toIso8601String(),
      'streakCount': streakCount,
      'exp': exp,
      'level': level,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
