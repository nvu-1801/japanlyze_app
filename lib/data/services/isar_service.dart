import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/flashcard_models.dart';
import '../../domain/entities/test_result.dart';
import '../../domain/entities/app_notification.dart';

/// Service for managing Isar database instance
class IsarService {
  static IsarService? _instance;
  static Isar? _isar;

  IsarService._();

  static IsarService get instance {
    _instance ??= IsarService._();
    return _instance!;
  }

  /// Initialize Isar database
  Future<void> initialize() async {
    if (_isar != null) return;

    String? dirPath;
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      dirPath = dir.path;
    }

    _isar = await Isar.open(
      [
        FlashcardItemSchema,
        FlashcardDeckSchema,
        UserProgressHistorySchema,
        TestResultSchema,
        AppNotificationSchema,
      ],
      directory: dirPath ?? '',
      inspector: true, // Enable for debugging
    );
  }

  /// Get Isar instance
  Isar get isar {
    if (_isar == null) {
      throw Exception(
        'Isar database not initialized. Call initialize() first.',
      );
    }
    return _isar!;
  }

  /// Close database
  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  /// Clear all data (for testing/debugging)
  Future<void> clearAll() async {
    await _isar?.writeTxn(() async {
      await _isar!.clear();
    });
  }
}
