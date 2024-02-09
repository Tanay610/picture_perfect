
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/data/repository/picture_repository.dart';
import 'package:picture_perfect/models/picture_model.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final PictureDataProvider? pictureRepository;
  MovieCubit(this.pictureRepository) : super(MovieInitial());

   List<PictureModel> allMovies = [];
  List<PictureModel> filteredMovies = [];

  Future<void> getPictureDetails()async{
    emit(MovieLoading());
    try {
      final movie = await pictureRepository!.getPicturePlayingDetails();
       allMovies = movie;
      // filteredMovies = movie; 
      emit(MovieSuccess(pictureModel: movie,));

    } catch (e) {
      emit(MovieFailure(e.toString()));
      
    }
  } 

  // Future<void> getclassifyDetails(int movieId, String query)async{
  //   emit(MovieLoading());
  //   try {
  //     emit(MovieSuccess(pictureModel: movie2, sorting: true));
  //   } catch (e) {
  //     emit(MovieFailure(e.toString()));
      
  //   }
  // }
  

   

//   List<PictureModel> filterMoviesByGenre(List<PictureModel> allMovies, int selectedGenreId) {
//     emit(MovieSortedOut(pictureModel: []));
//   return allMovies.where((movie) => movie.genre_ids.contains(selectedGenreId)).toList();

// }
}
