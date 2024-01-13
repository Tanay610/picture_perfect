import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/models/genre_model.dart';

part 'genre_state.dart';

class GenreCubit extends Cubit<GenreState> {
  final PictureDataProvider _pictureDataProvider;
  
  GenreCubit(this._pictureDataProvider) : super(GenreInitial());

  Future <void> getGenreList()async{
    emit(GenreLoading());

    try {
      final genre = await _pictureDataProvider.getGenreList();
      emit(GenreSuccess(genreModel: genre));
    } catch (e) {
      emit(GenreFailure(e.toString()));
      
    }
    
  }


}
