import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/models/person_model.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PictureDataProvider picturePerson;
  PersonBloc(this.picturePerson) : super(PersonInitial()) {
    on<PersonEventStarted>((event, emit)async {
      try {
        emit(PersonLaoding());
        final list = await picturePerson.getTrendingPerson();
        emit(PersonSuccess(personModel: list));
      } catch (e) {
        emit(PersonFailure(e.toString()));
      }
    });
  }
}
