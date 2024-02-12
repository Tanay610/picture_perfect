part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();
  
  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteAdded extends FavoriteState {
  final List<MovieDetails> movieList;
  final int moviId;
  final MovieDetails listItem;

  FavoriteAdded(this.listItem, this.moviId, {required this.movieList});
}

final class FavoriteRemoved extends FavoriteState {
  final List<MovieDetails> movieList;
  final int movieId;

  FavoriteRemoved({required this.movieList, required this.movieId,});

  
}
