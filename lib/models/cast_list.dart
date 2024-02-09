// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class CastList{
  final List<Cast> cast;

  CastList(this.cast); 
}

class Cast {
  final String name;
  final String? profilePath;
  final String character;
  Cast({
    required this.name,
    required this.profilePath,
    required this.character,
  });
  

  Cast copyWith({
    String? name,
    String? profilePath,
    String? character,
  }) {
    return Cast(
      name: name ?? this.name,
      profilePath: profilePath ?? "this.profilePath",
      character: character ?? this.character,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profile_path': profilePath,
      'character': character,
    };
  }

  factory Cast.fromMap(Map<String, dynamic> map) {
    // if (map['profile_path'] == null) {
    //   return Cast(name: 'baby i ', profilePath: '/rMh8qdexFKmc7mq7oLzsLLvCCjs.jpg', character: 'yo yo honey singha');
    // }
    return Cast(
      name: map['name'] as String,
      profilePath: map['profile_path'],
      character: map['character'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cast.fromJson(String source) => Cast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Cast(name: $name, profilePath: $profilePath, character: $character)';

  @override
  bool operator ==(covariant Cast other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.profilePath == profilePath &&
      other.character == character;
  }

  @override
  int get hashCode => name.hashCode ^ profilePath.hashCode ^ character.hashCode;
}
