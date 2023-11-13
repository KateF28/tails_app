import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:tails_app/data/datasources/remote/repository.dart';
import 'package:tails_app/domain/models/breed.dart';

part 'breeds_list_event.dart';
part 'breeds_list_state.dart';

class BreedsListBloc extends Bloc<BreedsListEvent, BreedsListState> {
  final Repository repository;

  BreedsListBloc(this.repository)
      : super(BreedsListEmpty(List<Breed>.empty(growable: true))) {
    on<RequestBreedsListEvent>(_onBreedsRequested);
    on<DeleteBreedEvent>(_onBreedDeleted);
    on<UpdateBreedStatusEvent>(_onBreedStatusUpdated);
  }

  Future<void> _onBreedsRequested(
      RequestBreedsListEvent event, Emitter<BreedsListState> emit) async {
    emit(BreedsListLoading());
    try {
      List<Breed> breeds = await repository.fetchBreeds();
      emit(BreedsListLoaded(breeds, 0));
    } on Exception catch (e) {
      emit(BreedsListError(e.toString()));
    }
  }

  Future<void> _onBreedDeleted(
      DeleteBreedEvent event, Emitter<BreedsListState> emit) async {
    List<Breed> newBreeds = List.of((state as BreedsListLoaded).breeds)
        .where((breed) => breed.id != event.breedId)
        .toList();
    int deletedBreedsCount = await repository.computeDeletedBreedsCount();
    emit(BreedsListLoaded(newBreeds, deletedBreedsCount));
  }

  void _onBreedStatusUpdated(
      UpdateBreedStatusEvent event, Emitter<BreedsListState> emit) {
    List<Breed> newBreeds =
        List.of((state as BreedsListLoaded).breeds).map((breed) {
      if (breed.id == event.breedId) breed.status = event.status;
      return breed;
    }).toList();
    emit(BreedsListLoaded(
        newBreeds, (state as BreedsListLoaded).removedBreedsCount));
  }
}
