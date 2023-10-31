import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tails_app/data/repository.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';

class BreedsListWidget extends StatefulWidget {
  const BreedsListWidget({super.key, required this.countRemovedBreeds});

  final void Function(int) countRemovedBreeds;

  @override
  State<BreedsListWidget> createState() => _BreedsListState();
}

class _BreedsListState extends State<BreedsListWidget> {
  @override
  void didChangeDependencies() {
    context.read<BreedsListBloc>().add(RequestBreedsListEvent());
    super.didChangeDependencies();
  }

  Future<void> _dismissBreed(String dismissedBreedId) async {
    context.read<BreedsListBloc>().add(DeleteBreedEvent(dismissedBreedId));
    int deletedBreedsCount =
        await RepositoryProvider.of<MockRepository>(context)
            .computeDeletedBreedsCount();
    widget.countRemovedBreeds(deletedBreedsCount);
  }

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
                        onDismissed: (direction) async {
                          await _dismissBreed(breed.id);
                          // breeds.removeAt(index);
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
