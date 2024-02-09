part of 'movie_preview_bloc.dart';

sealed class MoviePreviewState extends Equatable {
  const MoviePreviewState();
  
  @override
  List<Object> get props => [];
}

final class MoviePreviewInitial extends MoviePreviewState {}

final class MoviePreviewLoading extends MoviePreviewState {}

final class MoviePreviewSucces extends MoviePreviewState {
  final MovieDetails previewdetails;
  final PictureImage pictureImage;

  MoviePreviewSucces({required this.pictureImage, required this.previewdetails});

  @override
  List<Object> get props => [previewdetails];
  
}

final class MoviewPreviewError extends MoviePreviewState {
  final String message;

  MoviewPreviewError({required this.message});
  
}

