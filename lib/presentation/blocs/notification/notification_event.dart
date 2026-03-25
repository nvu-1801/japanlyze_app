import 'package:equatable/equatable.dart';
import '../../../domain/entities/app_notification.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationLoadRequested extends NotificationEvent {}

class NotificationAddRequested extends NotificationEvent {
  final AppNotification notification;
  const NotificationAddRequested(this.notification);

  @override
  List<Object?> get props => [notification];
}

class NotificationMarkAsReadRequested extends NotificationEvent {
  final int notificationId;
  const NotificationMarkAsReadRequested(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

class NotificationMarkAllAsReadRequested extends NotificationEvent {}

class NotificationDeleteRequested extends NotificationEvent {
  final int notificationId;
  const NotificationDeleteRequested(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}
