import 'package:isar/isar.dart';

part 'app_notification.g.dart';

@Collection()
class AppNotification {
  Id id = Isar.autoIncrement;

  @Index()
  late String title;

  late String message;

  @Index()
  late String type; // 'exam', 'roadmap', 'system'

  @Index()
  late DateTime timestamp;

  @Index()
  bool isRead = false;

  String? payload; // Optional JSON string for navigation or extra data

  AppNotification({
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.payload,
  });
}
