import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:tails_app/utils/environment.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';

/// This is search screen page/view content
class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<BreedsListBloc, BreedsListState>(
        builder: (context, state) {
          return switch (state) {
            BreedsListLoading() => const Center(
                child: CircularProgressIndicator(
                  color: Environment.textColor,
                ),
              ),
            BreedsListLoaded() => CustomScrollView(
                slivers: [
                  SliverGrid.builder(
                    itemCount: state.breeds.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth < 700 ? 2 : 4),
                    itemBuilder: (context, idx) => GestureDetector(
                      onTap: () => context.goNamed('breed',
                          pathParameters: {'breedId': state.breeds[idx].id}),
                      child: Card(
                        margin: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: state.breeds[idx].image?.url == null ||
                                    kIsWeb
                                ? const DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage('images/placeholder.jpg'))
                                : DecorationImage(
                                    fit: BoxFit.contain,
                                    image: CachedNetworkImageProvider(
                                      state.breeds[idx].image!.url!,
                                    ),
                                  ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  state.breeds[idx].name,
                                  style: const TextStyle(
                                    color: Environment.textColor,
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
              ),
            BreedsListError() => Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                    color: Environment.errorColor,
                  ),
                ),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      );
    });
  }
}
