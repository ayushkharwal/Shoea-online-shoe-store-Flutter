import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = 'notifications';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
    );
  }
}
