import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tails_app/data/repository.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';
import 'package:tails_app/domain/breeds_list.dart';

class BreedsListWidget extends ConsumerStatefulWidget {
  const BreedsListWidget({super.key, required this.countRemovedBreeds});

  final void Function(int) countRemovedBreeds;

  @override
  ConsumerState<BreedsListWidget> createState() => _BreedsListState();
}

class _BreedsListState extends ConsumerState<BreedsListWidget> {
  @override
  void initState() {
    _getInitialBreeds();
    super.initState();
  }

  Future<void> _getInitialBreeds() async {
    await ref.read(breedsProvider.notifier).addInitialBreeds();
  }

  Future<void> _dismissBreed(String dismissedBreedId) async {
    ref.read(breedsProvider.notifier).deleteBreed(dismissedBreedId);
    int deletedBreedsCount =
        await ref.watch(repositoryProvider).computeDeletedBreedsCount();
    widget.countRemovedBreeds(deletedBreedsCount);
  }

  @override
  Widget build(BuildContext context) {
    final List<Breed> breeds = ref.watch(breedsProvider);

    return CustomScrollView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      slivers: [
        breeds.isEmpty
            ? const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(
                    color: textColor,
                  ),
                ),
              )
            : SliverList.builder(
                itemCount: breeds.length,
                itemBuilder: (context, index) {
                  String breedStatus = breeds[index].status;
                  String breedId = breeds[index].id;

                  return Dismissible(
                    key: Key(breedId),
                    onDismissed: (direction) async {
                      await _dismissBreed(breedId);
                    },
                    child: ListTile(
                      title: Text(
                        Localizations.localeOf(context).languageCode == "uk"
                            ? breeds[index].ukTitle
                            : breeds[index].title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: textColor,
                            ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          breeds[index].imgUrl,
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
                            onChanged: (bool? value) {
                              setState(() => breedStatus =
                                  value == false ? 'initial' : 'checked');
                              ref
                                  .read(breedsProvider.notifier)
                                  .updateBreedStatus(breedId,
                                      value == false ? 'initial' : 'checked');
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
