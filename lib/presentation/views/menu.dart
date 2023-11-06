import 'package:flutter/material.dart';

/// This is menu screen page/view content
class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Text(
            'Menu screen',
            style: Theme.of(context).textTheme.bodyLarge!,
          ),
        );
      },
    );
  }
}
