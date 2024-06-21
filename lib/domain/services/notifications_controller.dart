import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';

class NotificationsController {
  final AwesomeNotifications _notifications = AwesomeNotifications();

  final GlobalKey<NavigatorState> _navigatorKey;

  NotificationsController(this._navigatorKey);

  initialize() {
    _notifications.initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: ColorManager.primary,
          ledColor: ColorManager.white,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group',
        )
      ],
      debug: true,
    );
    _notifications.setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
      onNotificationCreatedMethod: _onNotificationCreatedMethod,
      onNotificationDisplayedMethod: _onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: _onDismissActionReceivedMethod,
    );
    _checkNotificationPermission();
  }

  @pragma("vm:entry-point")
  Future<void> _onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  Future<void> _onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  Future<void> _onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  @pragma("vm:entry-point")
  Future<void> _onActionReceivedMethod(ReceivedAction receivedAction) async {
    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.offersRoute,
      (route) => (route.settings.name != Routes.offersRoute) || route.isFirst,
      arguments: receivedAction,
    );
  }

  _checkNotificationPermission() async {
    if (!(await _notifications.isNotificationAllowed())) {
      _notifications.requestPermissionToSendNotifications();
    }
  }

  sendNotification({
    required String title,
    required String body,
    String? imageUrl,
  }) {
    _notifications.createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        actionType: ActionType.Default,
        title: title,
        body: body,
        bigPicture: imageUrl,
      ),
    );
  }
}
