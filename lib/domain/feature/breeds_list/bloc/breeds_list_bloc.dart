import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:tails_app/data/repository.dart';
import 'package:tails_app/domain/models/breed.dart';

part 'breeds_list_event.dart';
part 'breeds_list_state.dart';

class BreedsListBloc extends Bloc<BreedsListEvent, BreedsListState> {
  final MockRepository repository;

  BreedsListBloc(this.repository)
      : super(BreedsListEmpty(List<Breed>.empty(growable: true))) {
    on<RequestBreedsListEvent>(_onBreedsRequested);
    on<AddBreedEvent>(_onBreedAdded);
    on<DeleteBreedEvent>(_onBreedDeleted);
    on<UpdateBreedStatusEvent>(_onBreedStatusUpdated);
  }

  Future<void> _onBreedsRequested(
      RequestBreedsListEvent event, Emitter<BreedsListState> emit) async {
    emit(BreedsListLoading());
    List<Breed> breeds = await repository.fetchBreeds();
    emit(BreedsListLoaded(breeds, 0));
  }

  void _onBreedAdded(AddBreedEvent event, Emitter<BreedsListState> emit) {
    if (state is BreedsListLoaded) {
      List<Breed> newBreeds = List.of((state as BreedsListLoaded).breeds);
      newBreeds.add(event.breed);
      emit(BreedsListLoaded(
          newBreeds, (state as BreedsListLoaded).removedBreedsCount));
    } else {
      emit(BreedsListLoaded(
          [event.breed], (state as BreedsListLoaded).removedBreedsCount));
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
