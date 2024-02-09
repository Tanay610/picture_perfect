// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:picture_perfect/models/cast_list.dart';

class MovieDetails {
  final int id;
  final String title;
  final String backdroPath;
  final String budget;
  final String homePage;
  final String original_title;
  final String overview;
  final String release_date;
  final String runtime;
  final String vote_average;
  final String vote_count;
  final String video;
  
  String? trailerId;

  late List<Cast> castList;
  MovieDetails({
    required this.id,
    required this.title,
    required this.backdroPath,
    required this.budget,
    required this.homePage,
    required this.original_title,
    required this.overview,
    required this.release_date,
    required this.runtime,
    required this.vote_average,
    required this.vote_count,
    this.trailerId,
    required this.video,
  });



  MovieDetails copyWith({
    int? id,
    String? title,
    String? backdroPath,
    String? budget,
    String? homePage,
    String? original_title,
    String? overview,
    String? release_date,
    String? runtime,
    String? vote_average,
    String? vote_count,
    String? trailerId,
    String? video,
  }) {
    return MovieDetails(
      id: id ?? this.id,
      title: title ?? this.title,
      backdroPath: backdroPath ?? this.backdroPath,
      budget: budget ?? this.budget,
      homePage: homePage ?? this.homePage,
      original_title: original_title ?? this.original_title,
      overview: overview ?? this.overview,
      release_date: release_date ?? this.release_date,
      runtime: runtime ?? this.runtime,
      vote_average: vote_average ?? this.vote_average,
      vote_count: vote_count ?? this.vote_count,
      trailerId: trailerId ?? this.trailerId,
      video: video ?? this.video
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'backdrop_path': backdroPath,
      'budget': budget,
      'homepage': homePage,
      'original_title': original_title,
      'overview': overview,
      'release_date': release_date,
      'runtime': runtime,
      'vote_average': vote_average,
      'vote_count': vote_count,
      'trailerId': trailerId,
      'video': video,
    };
  }

  factory MovieDetails.fromMap(Map<String, dynamic> map) {
    return MovieDetails(
      id: map['id'],
      title: map['title'] as String,
      backdroPath: map['backdrop_path'] as String,
      budget: map['budget'].toString(),
      homePage: map['homepage'] as String,
      original_title: map['original_title'] as String,
      overview: map['overview'] as String,
      release_date: map['release_date'] as String,
      runtime: map['runtime'].toString(),
      vote_average: map['vote_average'].toString(),
      vote_count: map['vote_count'].toString(),
      video: map['videos']['results'][0]['key'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetails.fromJson(String source) => MovieDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MovieDetails(id: $id, title: $title, backdroPath: $backdroPath, budget: $budget, homePage: $homePage, original_title: $original_title, overview: $overview, release_date: $release_date, runtime: $runtime, vote_average: $vote_average, vote_count: $vote_count, trailerId: $trailerId)';
  }

  @override
  bool operator ==(covariant MovieDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.backdroPath == backdroPath &&
      other.budget == budget &&
      other.homePage == homePage &&
      other.original_title == original_title &&
      other.overview == overview &&
      other.release_date == release_date &&
      other.runtime == runtime &&
      other.vote_average == vote_average &&
      other.vote_count == vote_count &&
      other.trailerId == trailerId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      backdroPath.hashCode ^
      budget.hashCode ^
      homePage.hashCode ^
      original_title.hashCode ^
      overview.hashCode ^
      release_date.hashCode ^
      runtime.hashCode ^
      vote_average.hashCode ^
      vote_count.hashCode ^
      trailerId.hashCode;
  }
}


