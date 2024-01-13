import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/data/repository/picture_repository.dart';
import 'package:picture_perfect/models/picture_model.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final PictureDataProvider? pictureRepository;
  MovieCubit(this.pictureRepository) : super(MovieInitial());

  Future<void> getPictureDetails(int movieId,String query )async{
    emit(MovieLoading());
    try {
      if(movieId==0){   
      final movie = await pictureRepository!.getPicturePlayingDetails();
      emit(MovieSuccess(pictureModel: movie));
      }else{
        final movie2 = await pictureRepository!.getMovieByGenres(movieId);
        emit(MovieSuccess(pictureModel: movie2));
      }

    } catch (e) {
      emit(MovieFailure(e.toString()));
      
    }
  } 
}
