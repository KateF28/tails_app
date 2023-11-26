part of 'breeds_list_bloc.dart';

@immutable
abstract class BreedsListState {}

class BreedsListEmpty extends BreedsListState {
  final List<Breed> breeds;

  BreedsListEmpty(this.breeds);
}

class BreedsListLoading extends BreedsListState {}

class BreedsListLoaded extends BreedsListState {
  final List<Breed> breeds;

  BreedsListLoaded(this.breeds);
}

class BreedsListError extends BreedsListState {
  final String errorMessage;

  BreedsListError(this.errorMessage);
}
