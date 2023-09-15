import 'gender.dart';

class Person {
  final String? name;
  final Gender? gender;
  final double height;
  final double weight;

  Person({
    required this.name,
    required this.gender,
    required this.height,
    required this.weight,
  });

  @override
  String toString() {
    return 'Person(name: $name, gender: $gender, height: $height, weight: $weight)';
  }
}
