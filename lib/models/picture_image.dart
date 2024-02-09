import 'package:equatable/equatable.dart';
import 'package:picture_perfect/models/screen_shot.dart';

class PictureImage extends Equatable{
  final List<ScreenShot>? backdrops;
  final List<ScreenShot>? posters;

  PictureImage({ this.backdrops, this.posters});
  
  factory PictureImage.fromMap(Map<String, dynamic> result){
    if (result == null) {
      return PictureImage();
    }

    return PictureImage(
      backdrops: (result['backdrops'] as List).map((e) => ScreenShot.fromMap(e)).toList(),
      posters: (result['posters'] as List).map((e) => ScreenShot.fromMap(e)).toList(),
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [backdrops, posters];

}