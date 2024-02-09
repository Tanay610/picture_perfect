// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ScreenShot extends Equatable {
  final double aspect;
  final String imagePath;
  final int height;
  final int width;
  // final String? countryCode;
  final double vote_average;
  final int vote_count;
  const ScreenShot({
    required this.aspect,
    required this.imagePath,
    required this.height,
    required this.width,
    // required this.countryCode,
    required this.vote_average,
    required this.vote_count,
  });


  ScreenShot copyWith({
    double? aspect,
    String? imagePath,
    int? height,
    int? width,
    // String? countryCode,
    double? vote_average,
    int? vote_count,
  }) {
    return ScreenShot(
      aspect: aspect ?? this.aspect,
      imagePath: imagePath ?? this.imagePath,
      height: height ?? this.height,
      width: width ?? this.width,
      // countryCode: countryCode ?? this.countryCode,
      vote_average: vote_average ?? this.vote_average,
      vote_count: vote_count ?? this.vote_count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aspect': aspect,
      'imagePath': imagePath,
      'height': height,
      'width': width,
      // 'countryCode': countryCode,
      'vote_average': vote_average,
      'vote_count': vote_count,
    };
  }

  factory ScreenShot.fromMap(Map<String, dynamic> map) {
    return ScreenShot(
      aspect: map['aspect_ratio'],
      imagePath: map['file_path'] as String,
      height: map['height'] as int,
      width: map['width'] as int,
      // countryCode: map['iso_639_1']! as String,
      vote_average: map['vote_average'] as double,
      vote_count: map['vote_count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScreenShot.fromJson(String source) => ScreenShot.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      aspect,
      imagePath,
      height,
      width,
      // countryCode!,
      vote_average,
      vote_count,
    ];
  }
}
