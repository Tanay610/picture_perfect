part of 'movie_preview_bloc.dart';

sealed class MoviePreviewEvent extends Equatable {
  const MoviePreviewEvent();

  @override
  List<Object> get props => [];
}

class MoviePreviewEventStarted extends MoviePreviewEvent{
  final int id;

  MoviePreviewEventStarted({required this.id});

  @override
  List<Object> get props => [];
  
}

// class MovieImageEventStarted extends MoviePreviewEvent{
//   final int id;

//   MovieImageEventStarted({required this.id});

//   @override
//   List<Object> get props => [];
// }
