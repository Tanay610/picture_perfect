import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_perfect/bloc/genres%20bloc/genre_event.dart';
import 'package:picture_perfect/bloc/genres%20bloc/genre_state.dart';
import 'package:picture_perfect/bloc/movie%20bloc/movie_bloc_state.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/models/genre_model.dart';
import 'package:picture_perfect/models/picture_model.dart';


class GenreBloc extends Bloc<GenreEvent, GenreState>{
  GenreBloc(): super(GenreLoading());

  @override
  Stream<GenreState> mapEventState(GenreEvent event)async*{
    if (event is GenreEventStarted) {
      yield* _mapGenreEventToState();
    }
  }

  Stream<GenreState> _mapGenreEventToState()async*{
      final dat_provider = PictureDataProvider();
      yield GenreLoading();

      try {
        List<Genre> genreList = await dat_provider.getGenreList();

        yield GenreLoaded(genreList);
      } on Exception catch (e) {
        yield GenreError();
        
      }
  }
}