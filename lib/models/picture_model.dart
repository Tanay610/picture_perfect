// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PictureModel {
  final int id;
  final String posterPath;
  final String release_date;
  final int runtime;
  final String status;
  final String title;
  final String tagline;
  final String backdrop_path;
  final int budget;

  PictureModel({
    required this.id,
    required this.posterPath,
    required this.release_date,
    required this.runtime,
    required this.status,
    required this.title,
    required this.tagline,
    required this.backdrop_path,
    required this.budget,
  });
  


  PictureModel copyWith({
    int? id,
    String? posterPath,
    String? release_date,
    int? runtime,
    String? status,
    String? title,
    String? tagline,
    String? backdrop_path,
    int? budget,
  }) {
    return PictureModel(
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      release_date: release_date ?? this.release_date,
      runtime: runtime ?? this.runtime,
      status: status ?? this.status,
      title: title ?? this.title,
      tagline: tagline ?? this.tagline,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      budget: budget ?? this.budget,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'posterPath': posterPath,
      'release_date': release_date,
      'runtime': runtime,
      'status': status,
      'title': title,
      'tagline': tagline,
      'backdrop_path': backdrop_path,
      'budget': budget,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(
      id: map['id'],
      posterPath: map['poster_path'],
      release_date: map['release_date'],
      runtime: map['runtime'],
      status: map['status'],
      title: map['title'],
      tagline: map['tagline'],
      backdrop_path: map['backdrop_path'],
      budget: map['budget'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureModel.fromJson(String source) => PictureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PictureModel(id: $id, posterPath: $posterPath, release_date: $release_date, runtime: $runtime, status: $status, title: $title, tagline: $tagline, backdrop_path: $backdrop_path, budget: $budget)';
  }

  @override
  bool operator ==(covariant PictureModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.posterPath == posterPath &&
      other.release_date == release_date &&
      other.runtime == runtime &&
      other.status == status &&
      other.title == title &&
      other.tagline == tagline &&
      other.backdrop_path == backdrop_path &&
      other.budget == budget;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      posterPath.hashCode ^
      release_date.hashCode ^
      runtime.hashCode ^
      status.hashCode ^
      title.hashCode ^
      tagline.hashCode ^
      backdrop_path.hashCode ^
      budget.hashCode;
  }
}
