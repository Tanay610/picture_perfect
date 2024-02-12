import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/models/picture_model.dart';
import 'package:picture_perfect/models/preview_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final PictureDataProvider pictureDataProvider;
  final List<MovieDetails> mov = [];
  FavoriteBloc(this.pictureDataProvider) : super(FavoriteInitial()) {

    on<FavoriteEventStarted>((event, emit) async{
    try {
      final listItem = await pictureDataProvider.getMovieDetails(event.moviId);
      mov.add(listItem);
      print(mov);
      emit(FavoriteAdded(movieList: mov, listItem, event.moviId));

      // emit(FavoriteRemoved(movieList: mov));
      // mov.remove(list);
    } catch (e) {
      throw Exception(e);
    }
    });

    on<RemoveFromFavoriteEvent>((event, emit) {
        mov.removeWhere((movie) => movie.id == event.movieId);
    emit(FavoriteRemoved(movieId: event.movieId, movieList: List.from(mov)));
    });
  }
}
