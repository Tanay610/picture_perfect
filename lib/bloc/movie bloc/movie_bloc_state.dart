import 'package:equatable/equatable.dart';
import 'package:picture_perfect/models/picture_model.dart';

abstract class MovieState extends Equatable{
  const MovieState();

   @override
  List<Object?> get props => [];


}

class MovieLoading extends MovieState{}

class MovieLoaded extends MovieState{

  final List<PictureModel> movieList;
  const MovieLoaded({required this.movieList});

  @override
  List<Object> get props => [movieList];

}

class MovieError extends MovieState{

}

