import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tails_app/data/repository.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';
import 'package:tails_app/domain/breeds_list.dart';

class BreedsListWidget extends ConsumerWidget {
  const BreedsListWidget({super.key, required this.countRemovedBreeds});

  final void Function(int) countRemovedBreeds;

  Future<void> _dismissBreed(String dismissedBreedId, WidgetRef ref) async {
    ref.read(breedsProvider.notifier).deleteBreed(dismissedBreedId);
    int deletedBreedsCount =
        await ref.watch(repositoryProvider).computeDeletedBreedsCount();
    countRemovedBreeds(deletedBreedsCount);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Breed>> breeds = ref.watch(breedsProvider);

    return switch (breeds) {
      AsyncLoading() => const Center(
            child: CircularProgressIndicator(
          color: textColor,
        )),
      AsyncData(:final value) => CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: [
            SliverList.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  String breedStatus = value[index].status;
                  String breedId = value[index].id;

                  return Dismissible(
                    key: Key(breedId),
                    onDismissed: (direction) async {
                      await _dismissBreed(breedId, ref);
                    },
                    child: ListTile(
                      title: Text(
                        Localizations.localeOf(context).languageCode == "uk"
                            ? value[index].ukTitle
                            : value[index].title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: textColor,
                            ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          value[index].imgUrl,
                        ),
                      ),
                      trailing: StatefulBuilder(
                        builder: (context, setState) => AnimatedContainer(
                          width: breedStatus == 'initial' ? 20.0 : 30.0,
                          height: breedStatus == 'initial' ? 20.0 : 30.0,
                          color: breedStatus == 'initial'
                              ? Colors.transparent
                              : textColor,
                          duration: const Duration(seconds: 1),
                          margin: EdgeInsets.only(
                              right: breedStatus == 'initial' ? 10.0 : 5.0),
                          curve: Curves.fastOutSlowIn,
                          child: Checkbox(
                            semanticLabel:
                                'Toggle initial and checked breed statuses',
                            value: breedStatus != 'initial',
                            onChanged: (bool? isChecked) {
                              setState(() => breedStatus =
                                  isChecked == false ? 'initial' : 'checked');
                              ref
                                  .read(breedsProvider.notifier)
                                  .updateBreedStatus(
                                      breedId,
                                      isChecked == false
                                          ? 'initial'
                                          : 'checked');
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      AsyncError() => const SizedBox.shrink(),
      _ => const SizedBox.shrink(),
    };
    // ref.read(asyncTodosProvider.notifier).toggle(todo.id);
  }
}
