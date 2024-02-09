// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Person {
  final String id;
  final String gen;
  final String name;
  final String profile_path;
  final String knownForDepartment;
  final String popularity;
  Person({
    required this.id,
    required this.gen,
    required this.name,
    required this.profile_path,
    required this.knownForDepartment,
    required this.popularity,
  });
  

  Person copyWith({
    String? id,
    String? gen,
    String? name,
    String? profilePhoto,
    String? knownForDepartment,
    String? popularity,
  }) {
    return Person(
      id: id ?? this.id,
      gen: gen ?? this.gen,
      name: name ?? this.name,
      profile_path: profilePhoto ?? this.profile_path,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      popularity: popularity ?? this.popularity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'gender': gen,
      'name': name,
      'profile_path': profile_path,
      'known_fo_department': knownForDepartment,
      'popularity': popularity,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'].toString(),
      gen: map['gender'].toString(),
      name: map['name'] as String,
      profile_path: map['profile_path'].toString(),
      knownForDepartment: map['known_for_department'] as String,
      popularity: map['popularity'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Person(id: $id, gen: $gen, name: $name, profile_path: $profile_path, knownForDepartment: $knownForDepartment, popularity: $popularity)';
  }

  @override
  bool operator ==(covariant Person other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.gen == gen &&
      other.name == name &&
      other.profile_path == profile_path &&
      other.knownForDepartment == knownForDepartment &&
      other.popularity == popularity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      gen.hashCode ^
      name.hashCode ^
      profile_path.hashCode ^
      knownForDepartment.hashCode ^
      popularity.hashCode;
  }
}
