part of 'imc_form_bloc.dart';

enum IMCFormStatus {
  initial,
  loading,
  success,
  failure;
}

class IMCFormState {
  final IMCFormStatus status;
  final IMCResult? imcResult;
  final Person? initialValue;
  final int? id;
  final String? name;
  final Gender? gender;
  final double height;
  final double weight;

  const IMCFormState({
    required this.status,
    this.imcResult,
    this.initialValue,
    this.id,
    this.name,
    this.gender,
    required this.height,
    required this.weight,
  });

  factory IMCFormState.initial({Person? initialPerson}) {
    return IMCFormState(
      status: IMCFormStatus.initial,
      imcResult: null,
      initialValue: initialPerson,
      id: initialPerson?.id,
      name: initialPerson?.name,
      gender: initialPerson?.gender,
      height: 1.5,
      weight: 30.0,
    );
  }

  Person get person => Person(id: id, name: name, gender: gender);

  IMCFormState copyWith({
    IMCFormStatus? status,
    IMCResult? imcResult,
    Person? initialValue,
    int? id,
    String? name,
    Gender? gender,
    double? height,
    double? weight,
  }) {
    return IMCFormState(
      status: status ?? this.status,
      imcResult: imcResult ?? this.imcResult,
      initialValue: initialValue ?? this.initialValue,
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  @override
  bool operator ==(covariant IMCFormState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.imcResult == imcResult &&
        other.initialValue == initialValue &&
        other.id == id &&
        other.name == name &&
        other.gender == gender &&
        other.height == height &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        imcResult.hashCode ^
        initialValue.hashCode ^
        id.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        height.hashCode ^
        weight.hashCode;
  }

  @override
  String toString() {
    return 'IMCFormState(status: $status, imcResult: $imcResult, initialValue: $initialValue, id: $id, name: $name, gender: $gender, height: $height, weight: $weight)';
  }
}
