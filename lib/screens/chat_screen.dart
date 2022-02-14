import 'package:Fighton/widgets/messages.dart';
import 'package:Fighton/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();

    final fbm = FirebaseMessaging.onMessageOpenedApp;

    // fbm.first.asStream(
    //   onMessage: (msg) {
    //     print('onMessage...');
    //     print(msg);
    //     return;
    //   },
    //   onResume: (msg) {
    //     print('onResume...');
    //     print(msg);
    //     return;
    //   },
    //   onLaunch: (msg) {
    //     print('onResume...');
    //     print(msg);
    //     return;
    //   },
    // );
    // fbm.subscribeToTopic('chat');
    // fbm.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('CHAT'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
        ),
      ),
    );
  }
}
