// import 'package:equatable/equatable.dart';
//
// import '../../model/notificationModel.dart';
//
//  class NotificationState  {
// }
//
// class NotificationInitial extends NotificationState {}
//
// class NotificationLoading extends NotificationState {}
//
// class NotificationLoaded extends NotificationState {
//   final List<MyNotification> notificationsotifications;
//   NotificationLoaded(this.notifications);
// }
//
// class NotificationError extends NotificationState {
//   final String message;
//
//   NotificationError(this.message);
//
// }
import '../../model/notificationModel.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<MyNotification> notifications;
  NotificationLoaded(this.notifications);
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}