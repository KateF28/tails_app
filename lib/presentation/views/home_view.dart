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
  int? _selectedChip;

  void _onListItemTaped(Breed tapedBreed) {
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
                    tapedBreed.title,
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
        _selectedChip = null;
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
                ? _getList(widget.breeds)
                : _getSliverGrid(widget.breeds, constraints),
          ],
        );
      },
    );
  }

  Widget _getList(List<Breed> breedsList) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 20.0,
            children: List<Widget>.generate(
              breedsList.length,
              (int index) {
                return ChoiceChip(
                  avatarBorder: const CircleBorder(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: Text(
                    breedsList[index].title,
                    style: const TextStyle(
                      color: textColor,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  side: const BorderSide(color: Colors.transparent),
                  avatar: CircleAvatar(
                    backgroundImage: AssetImage(breedsList[index].imgUrl),
                  ),
                  selected: _selectedChip == index,
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        _selectedChip = index;
                      });
                      _onListItemTaped(breedsList[index]);
                    }
                  },
                );
              },
            ).toList(),
          ),
        ),
      );

  Widget _getSliverGrid(
          List<Breed> breedsForGrid, BoxConstraints boxConstraints) =>
      SliverGrid.builder(
        itemCount: breedsForGrid.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: boxConstraints.maxWidth < 700 ? 2 : 4),
        itemBuilder: (context, idx) => GestureDetector(
          onTap: () => _onListItemTaped(breedsForGrid[idx]),
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
                      breedsForGrid[idx].title,
                      style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
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
