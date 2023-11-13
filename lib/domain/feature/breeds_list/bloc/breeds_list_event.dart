part of 'breeds_list_bloc.dart';

@immutable
sealed class BreedsListEvent {}

final class RequestBreedsListEvent extends BreedsListEvent {}

final class DeleteBreedEvent extends BreedsListEvent {
  final String breedId;

  DeleteBreedEvent(this.breedId);
}

final class UpdateBreedStatusEvent extends BreedsListEvent {
  final String breedId;
  final String status;

  UpdateBreedStatusEvent(this.breedId, this.status);
}
