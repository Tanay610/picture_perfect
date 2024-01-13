part of 'genre_cubit.dart';

sealed class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

final class GenreInitial extends GenreState {}

final class GenreLoading extends GenreState{}

final class GenreSuccess extends GenreState{
  final List<Genre> genreModel;

  GenreSuccess({required this.genreModel});
}

final class GenreFailure extends GenreState{
  final String error;

  GenreFailure(this.error);
  
}
