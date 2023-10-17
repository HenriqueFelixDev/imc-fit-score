import '../../core/models/models.dart';

abstract interface class PersonRepository {
  Future<int> createPerson(Person person);
  Future<void> updatePerson(Person person);
  Future<void> deletePerson(int id);
  Stream<List<Person>> getAllThePeople();
}