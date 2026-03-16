# Roadmap Progress Synchronization

## Overview

The Roadmap Progress Synchronization feature allows users to sync their learning progress across multiple devices. When a user completes quests on one device, the progress is automatically synchronized to the cloud and available on all other devices where the user is logged in.

## Architecture

### Components

1. **RoadmapSyncService** (`lib/data/services/roadmap_sync_service.dart`)
   - Singleton service that handles all synchronization operations
   - Integrates with Supabase for cloud storage
   - Works with UserProgressService for local storage

2. **UserProgressService** (`lib/data/services/user_progress_service.dart`)
   - Manages local progress using SharedPreferences
   - Stores completed quest IDs and progress values

3. **ProgressRemoteDataSource** (`lib/data/datasources/remote/progress_remote_datasource.dart`)
   - Handles communication with Supabase UserProgress table
   - Provides caching for performance

4. **AuthBloc** (`lib/presentation/blocs/auth/auth_bloc.dart`)
   - Triggers sync operations on user authentication events

5. **RoadmapTab** (`lib/presentation/pages/home/tabs/roadmap_tab.dart`)
   - Displays roadmap and handles user interactions
   - Triggers sync on refresh

## How It Works

### 1. User Login/Registration

When a user logs in or registers:
- AuthBloc triggers `RoadmapSyncService.syncFromCloud()`
- Cloud progress is fetched and merged with local progress
- User sees their latest progress from all devices

### 2. Quest Completion

When a user completes a quest:
- Progress is saved locally via UserProgressService
- If user is authenticated, progress is immediately synced to cloud
- Other devices will receive this progress on next sync

### 3. Manual Refresh

Users can manually trigger sync by:
- Pulling down to refresh on the Roadmap tab
- This performs bidirectional sync (both directions)

### 4. Automatic Sync

Sync is automatically triggered on:
- User login
- User registration
- Session restoration (app restart with active session)
- Google login

## Data Flow

```
┌─────────────────┐
│   User Action   │
│ (Complete Quest)│
└────────┬────────┘
         │
         ▼
┌─────────────────────────┐
│  UserProgressService    │
│  (Save Locally)         │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│  RoadmapSyncService     │
│  (Sync to Cloud)        │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│  Supabase (UserProgress)│
│  (Cloud Storage)        │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│  Other Devices          │
│  (Sync on Login)       │
└─────────────────────────┘
```

## API Integration

### Supabase Table: UserProgress

```sql
CREATE TABLE UserProgress (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  userId UUID NOT NULL REFERENCES User(id),
  questId TEXT NOT NULL,
  completedAt TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  UNIQUE(userId, questId)
);
```

### Key Operations

1. **Fetch User Progress**
   ```dart
   await _supabase.from('UserProgress').select().eq('userId', userId);
   ```

2. **Upsert Progress**
   ```dart
   await _supabase.from('UserProgress').upsert(progress.toJson());
   ```

3. **Insert New Progress**
   ```dart
   await _supabase.from('UserProgress').insert(progress.toJson());
   ```

## Usage Examples

### Manual Sync

```dart
final syncService = RoadmapSyncService();

// Sync from cloud to local
await syncService.syncFromCloud();

// Sync from local to cloud
await syncService.syncToCloud();

// Bidirectional sync
await syncService.bidirectionalSync();
```

### Mark Quest as Completed

```dart
final syncService = RoadmapSyncService();
await syncService.markQuestCompleted('quest_id');
```

## Error Handling

The sync service handles errors gracefully:
- Network errors are logged but don't crash the app
- Local storage always works even if cloud sync fails
- Sync failures don't block user interactions
- Detailed logging for debugging

## Performance Considerations

1. **Caching**: ProgressRemoteDataSource caches results to reduce API calls
2. **Incremental Sync**: Only new quests are uploaded to cloud
3. **Async Operations**: All sync operations are non-blocking
4. **Merge Strategy**: Local and cloud progress are merged to avoid data loss

## Testing

To test the synchronization:

1. **Single Device Test**
   - Complete a quest
   - Check that it's saved locally
   - Verify cloud sync (check Supabase dashboard)

2. **Multi-Device Test**
   - Complete a quest on Device A
   - Log in on Device B
   - Verify progress appears on Device B

3. **Offline Test**
   - Complete quests while offline
   - Go online
   - Verify progress syncs to cloud

## Future Enhancements

Potential improvements:
- Real-time sync using Supabase Realtime
- Conflict resolution for simultaneous edits
- Progress history and analytics
- Sync status indicators in UI
- Background sync with work manager

## Troubleshooting

### Progress not syncing

1. Check if user is authenticated
2. Verify network connectivity
3. Check Supabase logs for errors
4. Ensure UserProgress table exists and has correct permissions

### Progress lost on other device

1. Verify both devices use the same user account
2. Check if sync was triggered on the second device
3. Review sync logs for errors

### Sync errors in console

1. Check Supabase connection
2. Verify API keys are correct
3. Ensure user has proper permissions
4. Review error messages for specific issues
