import 'package:estegatha/utils/common/widgets/custom_app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class SosScreen extends StatelessWidget {
  SosScreen({super.key, required this.message});
  RemoteMessage message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Sos Screen'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(message.notification?.title ?? ''),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
