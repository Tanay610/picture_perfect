part of 'now_play_bloc.dart';

sealed class NowPlayEvent extends Equatable {
  const NowPlayEvent();

  @override
  List<Object> get props => [];
}

class GetPlayList extends NowPlayEvent {
  final int genreId;
  List<PictureModel>? filteredMovies;

  GetPlayList({required this.genreId});

  List<PictureModel> filterMoviesByGenre(int genreId, List<PictureModel> list) {
    filteredMovies = list
        .where((movie) => movie.genre_ids.contains(genreId))
        .toList();
      return filteredMovies!;  
  }
}
