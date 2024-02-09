import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/models/picture_image.dart';
import 'package:picture_perfect/models/preview_model.dart';

part 'movie_preview_event.dart';
part 'movie_preview_state.dart';

class MoviePreviewBloc extends Bloc<MoviePreviewEvent, MoviePreviewState> {
  final PictureDataProvider? pictureDetails;
  MoviePreviewBloc(this.pictureDetails) : super(MoviePreviewInitial()) {
    on<MoviePreviewEventStarted>((event, emit) async{
      try {
        emit(MoviePreviewLoading());
      final MovieDetails movieDetails = await pictureDetails!.getMovieDetails(event.id);
      final PictureImage pictureImage = await pictureDetails!.getMovieImages(event.id);
      emit(MoviePreviewSucces(previewdetails: movieDetails, pictureImage: pictureImage));
      } catch (e) {
        emit(MoviewPreviewError(message: e.toString()));
        
      }
    });

  }
}
