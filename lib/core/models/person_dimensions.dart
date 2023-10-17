class PersonDimensions {
  final int? id;
  final int personId;
  final double height;
  final double weight;
  final DateTime date;

  const PersonDimensions({
    this.id,
    required this.personId,
    required this.height,
    required this.weight,
    required this.date,
  });

  PersonDimensions copyWith({
    int? id,
    int? personId,
    double? height,
    double? weight,
    DateTime? date,
  }) {
    return PersonDimensions(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'PersonDimensions(id: $id, personId: $personId, height: $height, weight: $weight, date: $date)';
  }

  @override
  bool operator ==(covariant PersonDimensions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.personId == personId &&
        other.height == height &&
        other.weight == weight &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        personId.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        date.hashCode;
  }
}
