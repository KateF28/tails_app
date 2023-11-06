import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tails_app/presentation/views/signup.dart';

/// Signup screen with appBar
class SignupScreen extends StatelessWidget {
  const SignupScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/menu/settings');
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: const SignupView(),
    );
  }
}
