import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/environment.dart';

class BreedsListWidget extends StatelessWidget {
  const BreedsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedsListBloc, BreedsListState>(
      builder: (context, BreedsListState state) {
        return switch (state) {
          BreedsListLoading() => const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(
                  color: Environment.textColor,
                ),
              ),
            ),
          BreedsListLoaded() => SliverList.builder(
              itemCount: state.breeds.length,
              itemBuilder: (context, index) {
                Breed breed = state.breeds[index];

                return ListTile(
                  key: Key(breed.id),
                  title: Text(
                    breed.name,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Environment.textColor,
                        ),
                  ),
                  leading: breed.image?.url == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage('images/placeholder.jpg'),
                        )
                      : CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(breed.image!.url!),
                        ),
                  trailing: StatefulBuilder(
                    builder: (context, setState) => AnimatedContainer(
                      width: breed.status == 'initial' ? 20.0 : 30.0,
                      height: breed.status == 'initial' ? 20.0 : 30.0,
                      color: breed.status == 'initial'
                          ? Colors.transparent
                          : Environment.textColor,
                      duration: const Duration(seconds: 1),
                      margin: EdgeInsets.only(
                          right: breed.status == 'initial' ? 10.0 : 5.0),
                      curve: Curves.fastOutSlowIn,
                      child: Checkbox(
                        semanticLabel:
                            'Toggle initial and checked breed statuses',
                        value: breed.status != 'initial',
                        onChanged: (bool? value) {
                          setState(() => breed.status =
                              value == false ? 'initial' : 'checked');
                          context.read<BreedsListBloc>().add(
                              UpdateBreedStatusEvent(breed.id,
                                  value == false ? 'initial' : 'checked'));
                        },
                      ),
                    ),
                  ),
                );
              }),
          BreedsListError() => SliverToBoxAdapter(
              child: Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                    color: Environment.errorColor,
                  ),
                ),
              ),
            ),
          _ => const SliverToBoxAdapter(
              child: SizedBox.shrink(),
            ),
        };
      },
    );
  }
}
