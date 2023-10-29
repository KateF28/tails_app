import 'package:flutter/material.dart';

import 'package:tails_app/data/repository.dart';
import 'package:tails_app/data/api/mock_api.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';

class BreedsList extends StatefulWidget {
  const BreedsList({super.key, required this.removedBreedsCount});

  final Future<void> Function() removedBreedsCount;

  @override
  State<BreedsList> createState() => _BreedsListState();
}

class _BreedsListState extends State<BreedsList> {
  late MockRepository _repository;

  @override
  void initState() {
    _repository = MockRepository(MockAPI());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repository.fetchBreeds(),
      initialData: List<Breed>.empty(growable: true),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Breed>> snapshot,
      ) {
        Widget breedsListSliver;
        List<Breed>? breedsSnapshot = snapshot.requireData;

        if (snapshot.hasData) {
          breedsListSliver = SliverList.builder(
              itemCount: breedsSnapshot.length,
              itemBuilder: (context, index) {
                String breedStatus = breedsSnapshot[index].status;
                String breedId = breedsSnapshot[index].id;

                return Dismissible(
                  key: Key(breedId),
                  onDismissed: (direction) async {
                    await widget.removedBreedsCount();
                    breedsSnapshot.removeAt(index);
                    await _repository.deleteBreed(breedId);
                  },
                  child: ListTile(
                    title: Text(
                      Localizations.localeOf(context).languageCode == "uk"
                          ? breedsSnapshot[index].ukTitle
                          : breedsSnapshot[index].title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: textColor,
                          ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        breedsSnapshot[index].imgUrl,
                      ),
                    ),
                    trailing: StatefulBuilder(
                      builder: (context, setState) => AnimatedContainer(
                        width: breedStatus != 'initial' ? 30.0 : 20.0,
                        height: breedStatus != 'initial' ? 30.0 : 20.0,
                        color: breedStatus != 'initial'
                            ? textColor
                            : Colors.transparent,
                        duration: const Duration(seconds: 1),
                        margin: EdgeInsets.only(
                            right: breedStatus != 'initial' ? 5.0 : 10.0),
                        curve: Curves.fastOutSlowIn,
                        child: Checkbox(
                          semanticLabel:
                              'Toggle initial and checked breed statuses',
                          value: breedStatus != 'initial',
                          onChanged: (bool? value) async {
                            setState(() => breedStatus =
                                value != true ? 'initial' : 'checked');
                            await _repository.updateBreedStatus(
                                breedId, value != true ? 'initial' : 'checked');
                            await _repository.fetchBreeds();
                          },
                        ),
                      ),
                    ),
                  ),
                );
              });
        } else {
          breedsListSliver = const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                color: textColor,
              ),
            ),
          );
        }

        return CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: [
            breedsListSliver,
          ],
        );
      },
    );
  }
}
