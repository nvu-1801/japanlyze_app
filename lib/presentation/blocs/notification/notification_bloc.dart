import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../../data/services/isar_service.dart';
import '../../../domain/entities/app_notification.dart';
import '../../../data/services/local_notification_service.dart';
import 'notification_event.dart';
import 'notification_state.dart';
import 'dart:math';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final IsarService _isarService;

  NotificationBloc({IsarService? isarService})
    : _isarService = isarService ?? IsarService.instance,
      super(NotificationInitial()) {
    on<NotificationLoadRequested>(_onLoadRequested);
    on<NotificationAddRequested>(_onAddRequested);
    on<NotificationMarkAsReadRequested>(_onMarkAsReadRequested);
    on<NotificationMarkAllAsReadRequested>(_onMarkAllAsReadRequested);
    on<NotificationDeleteRequested>(_onDeleteRequested);
  }

  Future<void> _onLoadRequested(
    NotificationLoadRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      final notifications = await _getAllNotifications();
      final unreadCount = await _getUnreadCount();
      emit(
        NotificationLoaded(
          notifications: notifications,
          unreadCount: unreadCount,
        ),
      );
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onAddRequested(
    NotificationAddRequested event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _isarService.isar.writeTxn(() async {
        await _isarService.isar.appNotifications.put(event.notification);
      });

      // Trigger system-level local notification
      LocalNotificationService.instance.showNotification(
        id: Random().nextInt(100000),
        title: event.notification.title,
        body: event.notification.message,
      );

      emit(NotificationCreated(event.notification));
      add(NotificationLoadRequested());
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onMarkAsReadRequested(
    NotificationMarkAsReadRequested event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      final notification = await _isarService.isar.appNotifications.get(
        event.notificationId,
      );
      if (notification != null) {
        notification.isRead = true;
        await _isarService.isar.writeTxn(() async {
          await _isarService.isar.appNotifications.put(notification);
        });
        add(NotificationLoadRequested());
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onMarkAllAsReadRequested(
    NotificationMarkAllAsReadRequested event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _isarService.isar.writeTxn(() async {
        final unread = await _isarService.isar.appNotifications
            .filter()
            .isReadEqualTo(false)
            .findAll();
        for (var n in unread) {
          n.isRead = true;
          await _isarService.isar.appNotifications.put(n);
        }
      });
      add(NotificationLoadRequested());
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onDeleteRequested(
    NotificationDeleteRequested event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _isarService.isar.writeTxn(() async {
        await _isarService.isar.appNotifications.delete(event.notificationId);
      });
      add(NotificationLoadRequested());
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<List<AppNotification>> _getAllNotifications() async {
    return await _isarService.isar.appNotifications
        .where()
        .sortByTimestampDesc()
        .findAll();
  }

  Future<int> _getUnreadCount() async {
    return await _isarService.isar.appNotifications
        .filter()
        .isReadEqualTo(false)
        .count();
  }
}
