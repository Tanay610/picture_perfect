part of 'person_bloc.dart';

sealed class PersonState extends Equatable {
  const PersonState();
  
  @override
  List<Object> get props => [];
}

final class PersonInitial extends PersonState {}

final class PersonLaoding extends PersonState{}


final class PersonSuccess extends PersonState{
  final List<Person> personModel;

  PersonSuccess({required this.personModel});
}

final class PersonFailure extends PersonState{
  final String error;

  PersonFailure(this.error);
  
}
