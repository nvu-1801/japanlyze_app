import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/user_progress.dart';
import 'user_progress_service.dart';
import '../datasources/local/user_local_datasource.dart';

/// Service for synchronizing roadmap progress between local storage and cloud
class RoadmapSyncService {
  final SupabaseClient _supabase;
  final UserProgressService _localService;
  final UserLocalDataSource _userLocalDataSource;
  final Uuid _uuid = const Uuid();

  RoadmapSyncService({required UserLocalDataSource userLocalDataSource})
    : _supabase = Supabase.instance.client,
      _localService = UserProgressService(),
      _userLocalDataSource = userLocalDataSource;

  /// Check if user is authenticated using our custom auth system
  Future<bool> _isAuthenticated() async {
    return await _userLocalDataSource.isLoggedIn();
  }

  /// Get current user ID from cached user data
  Future<String?> _getCurrentUserId() async {
    final user = await _userLocalDataSource.getCachedUser();
    return user?.uuid;
  }

  /// Sync progress from cloud to local storage
  /// Returns true if sync was successful, false otherwise
  Future<bool> syncFromCloud() async {
    if (!await _isAuthenticated()) {
      print('RoadmapSyncService: User not authenticated, skipping cloud sync');
      return false;
    }

    try {
      final userId = await _getCurrentUserId();
      if (userId == null) {
        print('RoadmapSyncService: No user ID found, skipping cloud sync');
        return false;
      }
      print('RoadmapSyncService: Syncing progress from cloud for user $userId');

      final response = await _supabase
          .from('UserProgress')
          .select()
          .eq('userId', userId);

      final cloudProgress = (response as List)
          .map((json) => UserProgress.fromJson(json))
          .toList();

      // Extract quest IDs from cloud progress
      final cloudQuestIds = cloudProgress.map((p) => p.questId).toSet();

      // Get local completed lessons
      final localCompleted = await _localService.getCompletedLessons();
      final localQuestIds = localCompleted.toSet();

      // Merge: combine local and cloud quest IDs
      final mergedQuestIds = {...localQuestIds, ...cloudQuestIds};

      // Update local storage with merged data
      if (mergedQuestIds.length > localQuestIds.length) {
        await _localService.markMultipleAsCompleted(mergedQuestIds.toList());
        print(
          'RoadmapSyncService: Synced ${mergedQuestIds.length - localQuestIds.length} new quests from cloud',
        );
      } else {
        print('RoadmapSyncService: No new quests to sync from cloud');
      }

      return true;
    } on PostgrestException catch (e) {
      print('RoadmapSyncService: Cloud sync error - ${e.message}');
      return false;
    } catch (e) {
      print('RoadmapSyncService: Sync error - ${e.toString()}');
      return false;
    }
  }

  /// Sync progress from local storage to cloud
  /// Returns true if sync was successful, false otherwise
  Future<bool> syncToCloud() async {
    if (!await _isAuthenticated()) {
      print(
        'RoadmapSyncService: User not authenticated, skipping cloud upload',
      );
      return false;
    }

    try {
      final userId = await _getCurrentUserId();
      if (userId == null) {
        print('RoadmapSyncService: No user ID found, skipping cloud upload');
        return false;
      }
      print('RoadmapSyncService: Syncing progress to cloud for user $userId');

      // Get local completed lessons
      final localCompleted = await _localService.getCompletedLessons();

      // Get existing cloud progress to avoid duplicates
      final response = await _supabase
          .from('UserProgress')
          .select()
          .eq('userId', userId);

      final cloudProgress = (response as List)
          .map((json) => UserProgress.fromJson(json))
          .toList();
      final cloudQuestIds = cloudProgress.map((p) => p.questId).toSet();

      // Upload only new quests that aren't in cloud yet
      int uploadedCount = 0;
      for (final questId in localCompleted) {
        if (!cloudQuestIds.contains(questId)) {
          final progress = UserProgress(
            uuid: _uuid.v4(),
            userId: userId,
            questId: questId,
            completedAt: DateTime.now(),
          );

          await _supabase.from('UserProgress').insert(progress.toJson());
          uploadedCount++;
        }
      }

      print('RoadmapSyncService: Uploaded $uploadedCount new quests to cloud');
      return true;
    } on PostgrestException catch (e) {
      print('RoadmapSyncService: Cloud upload error - ${e.message}');
      return false;
    } catch (e) {
      print('RoadmapSyncService: Upload error - ${e.toString()}');
      return false;
    }
  }

  /// Mark a quest as completed and sync to cloud
  /// Returns true if successful, false otherwise
  Future<bool> markQuestCompleted(String questId) async {
    try {
      // First save locally
      await _localService.markLessonAsCompleted(questId);

      // Then sync to cloud if authenticated
      if (await _isAuthenticated()) {
        final userId = await _getCurrentUserId();
        if (userId != null) {
          final progress = UserProgress(
            uuid: _uuid.v4(),
            userId: userId,
            questId: questId,
            completedAt: DateTime.now(),
          );

          await _supabase.from('UserProgress').upsert(progress.toJson());
          print('RoadmapSyncService: Quest $questId synced to cloud');
        }
      }

      return true;
    } catch (e) {
      print(
        'RoadmapSyncService: Error marking quest completed - ${e.toString()}',
      );
      // Local save should have succeeded even if cloud sync failed
      return false;
    }
  }

  /// Perform bidirectional sync (both directions)
  /// Returns true if at least one direction succeeded
  Future<bool> bidirectionalSync() async {
    if (!await _isAuthenticated()) {
      return false;
    }

    print('RoadmapSyncService: Starting bidirectional sync');

    // Sync from cloud first (to get latest data)
    final fromCloudSuccess = await syncFromCloud();

    // Then sync to cloud (to upload local changes)
    final toCloudSuccess = await syncToCloud();

    final success = fromCloudSuccess || toCloudSuccess;
    print(
      'RoadmapSyncService: Bidirectional sync completed - Success: $success',
    );

    return success;
  }

  /// Clear all cloud progress for current user (for testing/debugging)
  Future<void> clearCloudProgress() async {
    if (!await _isAuthenticated()) return;

    try {
      final userId = await _getCurrentUserId();
      if (userId != null) {
        await _supabase.from('UserProgress').delete().eq('userId', userId);
        print('RoadmapSyncService: Cleared cloud progress for user $userId');
      }
    } catch (e) {
      print(
        'RoadmapSyncService: Error clearing cloud progress - ${e.toString()}',
      );
    }
  }
}
