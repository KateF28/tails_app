import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tails_app/utils/constants.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';

/// This is search screen page/view content
class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<BreedsListBloc, BreedsListState>(
        builder: (context, state) {
          final breedsListState = state as BreedsListLoaded;

          return CustomScrollView(
            slivers: [
              SliverGrid.builder(
                itemCount: breedsListState.breeds.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth < 700 ? 2 : 4),
                itemBuilder: (context, idx) => GestureDetector(
                  onTap: () => context.goNamed('breed', pathParameters: {
                    'breedId': breedsListState.breeds[idx].id
                  }),
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(breedsListState.breeds[idx].imgUrl),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              Localizations.localeOf(context).languageCode ==
                                      "uk"
                                  ? breedsListState.breeds[idx].ukTitle
                                  : breedsListState.breeds[idx].title,
                              style: const TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
    });
  }
}
