
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/models/picture_model.dart';

part 'now_play_event.dart';
part 'now_play_state.dart';

class NowPlayBloc extends Bloc<NowPlayEvent, NowPlayState> {
  final PictureDataProvider? picturepository;
  NowPlayBloc(this.picturepository,) : super(NowPlayInitial()) {

    on<GetPlayList>((event, emit) async{
   
      try {
        final list = await picturepository!.getPicturePlayingDetails();
        emit(NowPlayLoading(tobeSorted: list));
        final sortedList = await picturepository!.getMovieByGenres(event.genreId);
        emit(NowPLaySuccess(pictures: sortedList));
        
      } catch (e) {
        emit(NowPlayError(message: e.toString()));
      }

      
    });

    
  }
}
