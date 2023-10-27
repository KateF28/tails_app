import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tails_app/data/repository.dart';
import 'package:tails_app/data/api/mock_api.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';

int _countDeletedBreeds(int value) => ++value;

/// This is main screen page/view content
class HomeView extends StatefulWidget {
  final List<Breed> breeds;

  const HomeView({super.key, required this.breeds});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late MockRepository _repository;
  int _deletedBreedsCount = 0;

  Future<int> deletedBreedsCount(int value) async {
    return await compute(_countDeletedBreeds, value);
  }

  @override
  void initState() {
    _repository = MockRepository(MockAPI());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: FutureBuilder(
            future: _repository.fetchBreeds(),
            initialData: List<Breed>.empty(growable: true),
            builder: (_, AsyncSnapshot<List<Breed>> snapshot) {
              Widget breedsListSliver;

              if (snapshot.hasData) {
                breedsListSliver = SliverList.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String breedStatus = snapshot.data![index].status;
                      String breedId = snapshot.data![index].id;

                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          int breedsCount =
                              await deletedBreedsCount(_deletedBreedsCount);
                          setState(() {
                            _deletedBreedsCount = breedsCount;
                          });
                          await _repository.deleteBreed(breedId);
                          await _repository.fetchBreeds();
                        },
                        child: ListTile(
                          title: Text(
                            Localizations.localeOf(context).languageCode == "uk"
                                ? snapshot.data![index].ukTitle
                                : snapshot.data![index].title,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: textColor,
                                    ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                              snapshot.data?[index].imgUrl ?? '',
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
                                  await _repository.updateBreedStatus(breedId,
                                      value != true ? 'initial' : 'checked');
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
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                      child: Text(
                        AppLocalizations.of(context)!
                            .deletedBreedsCount(_deletedBreedsCount.toString()),
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                    ),
                  ),
                  breedsListSliver,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
