part of 'movie_cubit.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState{}

final class MovieSuccess extends MovieState{
  final List<PictureModel> pictureModel;

  MovieSuccess({required this.pictureModel});
}

final class MovieFailure extends MovieState{
  final String error;

  MovieFailure(this.error);
  
}
