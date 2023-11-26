import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:tails_app/data/datasources/remote/repository.dart';
import 'package:tails_app/domain/models/breed.dart';
import 'package:tails_app/data/datasources/local/breeds_dao.dart';

part 'breeds_list_event.dart';

part 'breeds_list_state.dart';

class BreedsListBloc extends Bloc<BreedsListEvent, BreedsListState> {
  final Repository repository;

  BreedsListBloc(this.repository)
      : super(BreedsListEmpty(List<Breed>.empty(growable: true))) {
    on<RequestBreedsListEvent>(_onBreedsRequested);
    on<UpdateBreedStatusEvent>(_onBreedStatusUpdated);
  }

  Future<void> _onBreedsRequested(
      RequestBreedsListEvent event, Emitter<BreedsListState> emit) async {
    emit(BreedsListLoading());
    try {
      List<Breed>? daoBreeds = await BreedsDao().reedBreeds();
      if (daoBreeds == null) {
        List<Breed> breeds = await repository.fetchBreeds();
        await BreedsDao().createBreeds(breeds);
        emit(BreedsListLoaded(breeds));
      } else {
        emit(BreedsListLoaded(daoBreeds));
      }
    } on Exception catch (e) {
      emit(BreedsListError(e.toString()));
    }
  }

  void _onBreedStatusUpdated(
      UpdateBreedStatusEvent event, Emitter<BreedsListState> emit) {
    List<Breed> newBreeds =
        List.of((state as BreedsListLoaded).breeds).map((breed) {
      if (breed.id == event.breedId) breed.status = event.status;
      return breed;
    }).toList();
    emit(BreedsListLoaded(newBreeds));
  }
}
