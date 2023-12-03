import 'package:flutter/material.dart';

import 'package:tails_app/presentation/widgets/breeds_list.dart';

/// This is main screen page/view content
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: [
            BreedsListWidget(),
          ],
        );
      },
    );
  }
}
