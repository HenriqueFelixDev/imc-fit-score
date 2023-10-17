import '../../core/models/person_dimensions.dart';
import 'person_dimensions_repository.dart';

class PersonDimensionsRepositoryImpl implements PersonDimensionsRepository {
  final _dimensions = <PersonDimensions>[];

  @override
  Future<void> saveDimensions(PersonDimensions dimensions) async {
    await Future.delayed(const Duration(seconds: 2));
    dimensions = dimensions.copyWith(id: DateTime.now().millisecondsSinceEpoch);
    _dimensions.add(dimensions);
  }

  @override
  Future<void> delete(int id) async {
    await Future.delayed(const Duration(seconds: 2));
    _dimensions.removeWhere((element) => element.id == id);
  }

  @override
  Future<List<PersonDimensions>> getAllByPersonId(int personId) async {
    await Future.delayed(const Duration(seconds: 2));
    return _dimensions.where((element) => element.personId == personId).toList();
  }
}
