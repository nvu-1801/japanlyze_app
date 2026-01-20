import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;

  late String uuid; // Supabase UUID
  late String name;
  late String email;
  String? avatarUrl;
  late String role; // 'user', 'admin'
  late String provider; // 'email', 'google', etc.
  bool isPremium = false;
  DateTime? premiumUntil;
  int streakCount = 0;
  int exp = 0;
  int level = 1;
  late DateTime createdAt;
  DateTime? updatedAt;

  User({
    this.id = Isar.autoIncrement,
    required this.uuid,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.role = 'user',
    this.provider = 'email',
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
    String? uuid,
    String? name,
    String? email,
    String? avatarUrl,
    String? role,
    String? provider,
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
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      provider: provider ?? this.provider,
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
      id: Isar.autoIncrement,
      uuid: json['id'],
      name: json['name'] ?? '',
      email: json['email'],
      avatarUrl: json['avatar'],
      role: json['role'] ?? 'user',
      provider: json['provider'] ?? 'email',
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
      'id': uuid,
      'name': name,
      'email': email,
      'avatar': avatarUrl,
      'role': role,
      'provider': provider,
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
