// Core:
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
// Models:
import 'package:tails_app/domain/models/breed.dart';
// Utils:
import 'package:tails_app/utils/constants.dart';
// Widgets
import 'package:tails_app/presentation/widgets/selected_breed.dart';

var uuid = const Uuid();

/// This is main screen page/view content
class HomeView extends StatefulWidget {
  final bool isListView;

  const HomeView({super.key, required this.isListView});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Breed> _breeds = [
    Breed('Maltipoo', 'images/maltipoo.jpg', uuid.v4()),
    Breed('Chow-chow', 'images/chow-chow.jpg', uuid.v4()),
    Breed('Shih Tzu', 'images/shih-tzu.jpg', uuid.v4()),
    Breed('Border Collie', 'images/border-collie.jpg', uuid.v4()),
    Breed('Pug', 'images/pug.jpg', uuid.v4()),
  ];

  @override
  Widget build(BuildContext context) => CustomScrollView(slivers: [
        widget.isListView
            ? SliverList.builder(
                itemCount: _breeds.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey<String>(_breeds[index].id),
                    onDismissed: (direction) {
                      setState(() {
                        _breeds = _breeds
                            .where((breed) => breed.id != _breeds[index].id)
                            .toList();
                      });
                    },
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(_breeds[index].imgUrl,
                            fit: BoxFit.contain),
                      ),
                      title: Text(_breeds[index].title),
                      onTap: () {
                        setState(() {
                          _breeds = _breeds.map((breed) {
                            if (breed.id == _breeds[index].id) {
                              breed.isSelected = true;
                            } else {
                              breed.isSelected = false;
                            }
                            return breed;
                          }).toList();
                        });
                      },
                    ),
                  );
                },
              )
            : SliverGrid.builder(
                itemCount: _breeds.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, idx) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _breeds = _breeds.map((breed) {
                        if (breed.id == _breeds[idx].id) {
                          breed.isSelected = true;
                        } else {
                          breed.isSelected = false;
                        }
                        return breed;
                      }).toList();
                    });
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(_breeds[idx].imgUrl))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                _breeds[idx].title,
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
              ),
        ..._breeds.map((breed) => breed.isSelected
            ? SelectedBreedWidget(
                breed: breed,
              )
            : const SliverToBoxAdapter(child: SizedBox.shrink())),
      ]);
}
