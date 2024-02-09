part of 'now_play_bloc.dart';

sealed class NowPlayState extends Equatable {
  const NowPlayState();
  
  @override
  List<Object> get props => [];
}

final class NowPlayInitial extends NowPlayState {}

final class NowPlayLoading extends NowPlayState{
  final List<PictureModel> tobeSorted;

  NowPlayLoading({required this.tobeSorted});
}

final class NowPLaySuccess extends NowPlayState{
  final List<PictureModel> pictures;

  const NowPLaySuccess({required this.pictures});
}


final class NowPlayError extends NowPlayState{
  final String? message;

  NowPlayError({required this.message});
  
}
