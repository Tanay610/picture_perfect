// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PictureModel {
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String release_date;
  final String posterPath;
  final String backdropPath;
  final bool video;
  final int votecount;
  final double popularity;

  PictureModel({
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.release_date,
    required this.posterPath,
    required this.backdropPath,
    required this.video,
    required this.votecount,
    required this.popularity,
  });

  PictureModel copyWith({
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    String? release_date,
    String? posterPath,
    String? backdropPath,
    bool? video,
    int? votecount,
    double? popularity,
  }) {
    return PictureModel(
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      release_date: release_date ?? this.release_date,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      video: video ?? this.video,
      votecount: votecount ?? this.votecount,
      popularity: popularity ?? this.popularity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'overview': overview,
      'release_date': release_date,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
      'video': video,
      'votecount': votecount,
      'popularity': popularity,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(
      id: map['id'] as int,
      originalLanguage: map['original_language'] as String,
      originalTitle: map['original_title'] as String,
      overview: map['overview'] as String,
      release_date: map['release_date'] as String,
      posterPath: map['poster_path'] as String,
      backdropPath: map['backdrop_path'] as String,
      video: map['video'] as bool,
      votecount: map['vote_count'] as int,
      popularity: map['popularity'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureModel.fromJson(String source) => PictureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PictureModel(id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, release_date: $release_date, posterPath: $posterPath, backdropPath: $backdropPath, video: $video, votecount: $votecount, popularity: $popularity)';
  }

  @override
  bool operator ==(covariant PictureModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.originalLanguage == originalLanguage &&
      other.originalTitle == originalTitle &&
      other.overview == overview &&
      other.release_date == release_date &&
      other.posterPath == posterPath &&
      other.backdropPath == backdropPath &&
      other.video == video &&
      other.votecount == votecount &&
      other.popularity == popularity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      overview.hashCode ^
      release_date.hashCode ^
      posterPath.hashCode ^
      backdropPath.hashCode ^
      video.hashCode ^
      votecount.hashCode ^
      popularity.hashCode;
  }
}
