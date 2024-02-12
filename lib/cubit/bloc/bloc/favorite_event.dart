part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  
  const FavoriteEvent();

  @override
  List<Object> get props => [];

}

class FavoriteEventStarted extends FavoriteEvent{

  final int moviId;
  FavoriteEventStarted( this.moviId);

  @override
  List<Object> get props => [moviId];
}


class RemoveFromFavoriteEvent extends FavoriteEvent {
  final int movieId;
  RemoveFromFavoriteEvent(this.movieId);
}
