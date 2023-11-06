import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tails_app/presentation/views/login.dart';

/// Login screen with appBar
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              context.go('/menu/settings');
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: const LoginView(),
    );
  }
}
