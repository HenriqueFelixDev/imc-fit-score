class PersonDimensions {
  final int id;
  final double height;
  final double weight;

  const PersonDimensions({
    required this.id,
    required this.height,
    required this.weight,
  });

  @override
  String toString() =>
      'PersonDimensions(id: $id, height: $height, weight: $weight)';

  @override
  bool operator ==(covariant PersonDimensions other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.height == height &&
      other.weight == weight;
  }

  @override
  int get hashCode => id.hashCode ^ height.hashCode ^ weight.hashCode;
}
