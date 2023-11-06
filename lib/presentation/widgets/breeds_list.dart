import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';

class BreedsListWidget extends StatelessWidget {
  const BreedsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedsListBloc, BreedsListState>(
      builder: (context, BreedsListState state) {
        return switch (state) {
          BreedsListLoading() => const Center(
              child: CircularProgressIndicator(
                color: textColor,
              ),
            ),
          BreedsListLoaded() => CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: [
                SliverList.builder(
                    itemCount: state.breeds.length,
                    itemBuilder: (context, index) {
                      Breed breed = state.breeds[index];

                      return Dismissible(
                        key: Key(breed.id),
                        onDismissed: (direction) {
                          context
                              .read<BreedsListBloc>()
                              .add(DeleteBreedEvent(breed.id));
                        },
                        child: ListTile(
                          title: Text(
                            Localizations.localeOf(context).languageCode == "uk"
                                ? breed.ukTitle
                                : breed.title,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: textColor,
                                    ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                              breed.imgUrl,
                            ),
                          ),
                          trailing: StatefulBuilder(
                            builder: (context, setState) => AnimatedContainer(
                              width: breed.status == 'initial' ? 20.0 : 30.0,
                              height: breed.status == 'initial' ? 20.0 : 30.0,
                              color: breed.status == 'initial'
                                  ? Colors.transparent
                                  : textColor,
                              duration: const Duration(seconds: 1),
                              margin: EdgeInsets.only(
                                  right:
                                      breed.status == 'initial' ? 10.0 : 5.0),
                              curve: Curves.fastOutSlowIn,
                              child: Checkbox(
                                semanticLabel:
                                    'Toggle initial and checked breed statuses',
                                value: breed.status != 'initial',
                                onChanged: (bool? value) {
                                  setState(() => breed.status =
                                      value == false ? 'initial' : 'checked');
                                  context.read<BreedsListBloc>().add(
                                      UpdateBreedStatusEvent(
                                          breed.id,
                                          value == false
                                              ? 'initial'
                                              : 'checked'));
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
