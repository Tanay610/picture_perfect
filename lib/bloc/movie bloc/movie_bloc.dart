import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_perfect/bloc/movie%20bloc/movie_bloc_state.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/models/picture_model.dart';

import 'movie_bloc_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState>{
  MovieBloc(): super(MovieLoading());

  @override
  Stream<MovieState> mapEventState(MovieEvent event)async*{
    if (event is MovieEventStarted) {
      yield* _mapMovieEventToState(event.movieId, event.query);
    }
  }

  Stream<MovieState> _mapMovieEventToState(
    int movieID, String query)async*{
      final dat_provider = PictureDataProvider();
      yield MovieLoading();

      try {
        List<PictureModel> movieList;
        if (movieID == 0) {
          movieList = await dat_provider.getPicturePlayingDetails();
        }

        yield MovieLoading();
      } on Exception catch (e) {
        yield MovieError();
        
      }
  }
}