import 'dart:convert';

import 'gender.dart';

class Person {
  final int? id;
  final String? name;
  final Gender? gender;

  Person({
    this.id,
    required this.name,
    required this.gender,
  });

  Person copyWith({
    int? id,
    String? name,
    Gender? gender,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'gender': gender?.name,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      gender: map['gender'] != null
          ? Gender.values
              .firstWhere((gender) => gender.name == map['gender'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) =>
      Person.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Person(id: $id, name: $name, gender: $gender)';

  @override
  bool operator ==(covariant Person other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.gender == gender;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ gender.hashCode;
}
