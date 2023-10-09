import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';
import 'package:tails_app/presentation/widgets/selected_breed.dart';

/// This is main screen page/view content
class HomeView extends StatefulWidget {
  final bool isListView;

  const HomeView({super.key, required this.isListView});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const Uuid _uuid = Uuid();
  List<Breed> _breeds = [
    Breed('Maltipoo', 'images/maltipoo.jpg', _uuid.v4()),
    Breed('Chow-chow', 'images/chow-chow.jpg', _uuid.v4()),
    Breed('Shih Tzu', 'images/shih-tzu.jpg', _uuid.v4()),
    Breed('Border Collie', 'images/border-collie.jpg', _uuid.v4()),
    Breed('Pug', 'images/pug.jpg', _uuid.v4()),
  ];

  void _onListItemTaped(List<Breed> tapedList, int index) {
    setState(() {
      _breeds = tapedList.map((breed) {
        if (breed.id == tapedList[index].id) {
          breed.isSelected = true;
        } else {
          breed.isSelected = false;
        }
        return breed;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(slivers: [
        widget.isListView ? _getSliverList(_breeds) : _getSliverGrid(_breeds),
        ..._breeds.map((breed) => breed.isSelected
            ? SelectedBreedWidget(
                breed: breed,
              )
            : const SliverToBoxAdapter(child: SizedBox.shrink())),
      ]);

  Widget _getSliverList(List<Breed> breedsList) => SliverList.builder(
        itemCount: breedsList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey<String>(breedsList[index].id),
            onDismissed: (direction) {
              setState(() {
                _breeds = breedsList
                    .where((breed) => breed.id != breedsList[index].id)
                    .toList();
              });
            },
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child:
                    Image.asset(breedsList[index].imgUrl, fit: BoxFit.contain),
              ),
              title: Text(breedsList[index].title),
              onTap: () => _onListItemTaped(breedsList, index),
            ),
          );
        },
      );

  Widget _getSliverGrid(List<Breed> breedsForGrid) => SliverGrid.builder(
        itemCount: breedsForGrid.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, idx) => GestureDetector(
          onTap: () => _onListItemTaped(breedsForGrid, idx),
          child: Card(
            margin: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(breedsForGrid[idx].imgUrl),
                ),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    breedsForGrid[idx].title,
                    style: const TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
}
