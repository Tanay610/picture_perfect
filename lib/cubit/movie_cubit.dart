import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:picture_perfect/data/repository/picture_repository.dart';
import 'package:picture_perfect/models/picture_model.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final PictureRepository pictureRepository;
  MovieCubit(this.pictureRepository) : super(MovieInitial());

  Future<void> getPictureDetails()async{
    emit(MovieLoading());
    try {
      final movie = await pictureRepository.getPictureDetails();
      emit(MovieSuccess(pictureModel: movie));

    } catch (e) {
      emit(MovieFailure(e.toString()));
      
    }
  } 
}
