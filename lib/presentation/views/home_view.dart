import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tails_app/presentation/widgets/breeds_list.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';

/// This is main screen page/view content
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocSelector<BreedsListBloc, BreedsListState, int>(
                selector: (state) =>
                    state is BreedsListLoaded ? state.removedBreedsCount : 0,
                builder: (context, removedBreedsCount) {
                  return Text(
                    AppLocalizations.of(context)!
                        .deletedBreedsCount(removedBreedsCount.toString()),
                    style: Theme.of(context).textTheme.bodyLarge!,
                  );
                },
              ),
            ),
            const BreedsListWidget(),
          ],
        );
      },
    );
  }
}
