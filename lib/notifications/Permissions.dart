import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

  class Permissions extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _Permissions();
  }

  class _Permissions extends State<Permissions> {

    bool _isRequested = false;
    bool _isFetching = false;
    late NotificationSettings _settings;

    // ASk users' permissions to receive notifications
    Future<void> requestPermissions() async {
      setState(() {
        // Set fetching state to true
        _isFetching = true;
      });

      NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
          announcement: true,
          carPlay: false,
          criticalAlert: true
      );

      setState(() {
        _isRequested = true;
        _isFetching = false;
        _settings = settings;
      });
    }

      Future<void> checkPermissions() async {
        setState(() {
          _isFetching = true;
        });

        NotificationSettings settings =
        await FirebaseMessaging.instance.getNotificationSettings();

        setState(() {
          _isRequested = true;
          _isFetching = false;
          _settings = settings;
        });
      }

      /// Maps a [AuthorizationStatus] to a string value.
      static const statusMap = {
        AuthorizationStatus.authorized: 'Authorized',
        AuthorizationStatus.denied: 'Denied',
        AuthorizationStatus.notDetermined: 'Not Determined',
        AuthorizationStatus.provisional: 'Provisional',
      };

      /// Maps a [AppleNotificationSetting] to a string value.
      static const settingsMap = {
        AppleNotificationSetting.disabled: 'Disabled',
        AppleNotificationSetting.enabled: 'Enabled',
        AppleNotificationSetting.notSupported: 'Not Supported',
      };

      /// Maps a [AppleShowPreviewSetting] to a string value.
      static const previewMap = {
        AppleShowPreviewSetting.always: 'Always',
        AppleShowPreviewSetting.never: 'Never',
        AppleShowPreviewSetting.notSupported: 'Not Supported',
        AppleShowPreviewSetting.whenAuthenticated: 'Only When Authenticated',
      };

      Widget row(String title, String value) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$title:',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(value),
            ],
          ),
        );
      }

      @override
      Widget build(BuildContext context) {
        if (_isFetching) {
          return const CircularProgressIndicator();
        }

        if (!_isRequested) {
          return ElevatedButton(
              onPressed: requestPermissions,
              child: const Text('Request Permissions'));
        }

        return Column(children: [
          row('Authorization Status',
              statusMap[_settings.authorizationStatus]!),
          if(defaultTargetPlatform == TargetPlatform.iOS) ...[
            row('Alert', settingsMap[_settings.alert]!),
            row('Announcement', settingsMap[_settings.announcement]!),
            row('Badge', settingsMap[_settings.badge]!),
            row('Lock Screen', settingsMap[_settings.lockScreen]!),
            row('Notification Center', settingsMap[_settings.notificationCenter]!),
            row('Show Previews', previewMap[_settings.showPreviews]!),
            row('Sound', settingsMap[_settings.sound]!),
          ],
          ElevatedButton(
              onPressed: checkPermissions,
              child: const Text('Reload Permissions'))
        ]);
    }
  }