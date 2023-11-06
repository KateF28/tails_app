import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'package:tails_app/presentation/views/settings.dart';

/// Settings screen with appBar
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.hiveBox,
  });

  final Box hiveBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.go('/menu');
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: SettingsView(hiveBox: hiveBox),
    );
  }
}
