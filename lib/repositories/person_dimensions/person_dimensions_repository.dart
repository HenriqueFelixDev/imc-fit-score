import '../../core/models/models.dart';

abstract interface class PersonDimensionsRepository {
  Future<void> saveDimensions(PersonDimensions dimensions);
  Future<void> delete(int id);
  Future<List<PersonDimensions>> getAllByPersonId(int personId);
}