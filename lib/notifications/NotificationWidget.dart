import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class Notification{
  final RemoteMessage remoteMessage;
  final bool isApplicationOpen;

  Notification(this.remoteMessage, this.isApplicationOpen);
}

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  Widget row(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title: '),
          Expanded(child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Notification args =
    ModalRoute.of(context)!.settings.arguments! as Notification;
    RemoteMessage message = args.remoteMessage;
    RemoteNotification? notification = message.notification;
    return Scaffold(
      appBar: AppBar(

      ),
    );
  }
}
