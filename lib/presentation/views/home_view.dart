import 'package:flutter/material.dart';

import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/utils/constants.dart';

/// This is main screen page/view content
class HomeView extends StatefulWidget {
  final List<Breed> breeds;

  const HomeView({super.key, required this.breeds});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int? _selectedBreed;

  void _onBreedSelected(Breed tapedBreed) {
    showGeneralDialog(
      context: context,
      barrierColor: dialogBgColor,
      barrierDismissible: true,
      barrierLabel: 'Breed photo dialog',
      transitionDuration: transitionDuration,
      pageBuilder: (_, __, ___) {
        return Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(tapedBreed.imgUrl),
                    fit: BoxFit.contain,
                  ),
                ),
                child: const SizedBox.shrink(),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    Localizations.localeOf(context).languageCode == "uk"
                        ? tapedBreed.ukTitle
                        : tapedBreed.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
                Text(
                  '${tapedBreed.date.year}-${tapedBreed.date.month}-${tapedBreed.date.day}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ).then((val) {
      setState(() {
        _selectedBreed = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          slivers: [
            queryWidth < 481
                ? _getBreedsList(widget.breeds, context)
                : _getBreedsSliverGrid(widget.breeds, constraints),
          ],
        );
      },
    );
  }

  Widget _getBreedsList(List<Breed> breedsList, context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 20.0,
            children: List<Widget>.generate(
              breedsList.length,
              (int index) {
                return _getBreedChip(breedsList, index, context);
              },
            ).toList(),
          ),
        ),
      );

  Widget _getBreedChip(
    List<Breed> breedsForChips,
    int breedIndex,
    BuildContext context,
  ) =>
      ChoiceChip(
        avatarBorder: const CircleBorder(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        label: Text(
          Localizations.localeOf(context).languageCode == "uk"
              ? breedsForChips[breedIndex].ukTitle
              : breedsForChips[breedIndex].title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: textColor,
              ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        side: const BorderSide(color: Colors.transparent),
        avatar: CircleAvatar(
          backgroundImage: AssetImage(breedsForChips[breedIndex].imgUrl),
        ),
        selected: _selectedBreed == breedIndex,
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _selectedBreed = breedIndex;
            });
            _onBreedSelected(breedsForChips[breedIndex]);
          }
        },
      );

  Widget _getBreedsSliverGrid(
    List<Breed> breedsForGrid,
    BoxConstraints boxConstraints,
  ) =>
      SliverGrid.builder(
        itemCount: breedsForGrid.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: boxConstraints.maxWidth < 700 ? 2 : 4),
        itemBuilder: (context, idx) => GestureDetector(
          onTap: () => _onBreedSelected(breedsForGrid[idx]),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      Localizations.localeOf(context).languageCode == "uk"
                          ? breedsForGrid[idx].ukTitle
                          : breedsForGrid[idx].title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: textColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
