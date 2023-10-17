
import 'package:rxdart/rxdart.dart';

import '../../core/models/person.dart';
import 'person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final _peopleSubject = BehaviorSubject<List<Person>>.seeded([]);

  @override
  Future<int> createPerson(Person person) async {
    final people = List<Person>.from(_peopleSubject.value);

    person = person.copyWith(id: DateTime.now().millisecondsSinceEpoch);
    people.add(person);

    _peopleSubject.sink.add(people);

    return person.id!;
  }

  @override
  Future<void> updatePerson(Person person) async {
    final people = List<Person>.from(_peopleSubject.value);

    final personIndex = people.indexWhere((item) => item.id == person.id);
    people[personIndex] = person;

    _peopleSubject.sink.add(people);
  }

  @override
  Future<void> deletePerson(int id) async {
    final people = List<Person>.from(_peopleSubject.value);
    final personIndex = people.indexWhere((item) => item.id == id);

    people.removeAt(personIndex);
    
    _peopleSubject.sink.add(people);
  }

  @override
  Stream<List<Person>> getAllThePeople() => _peopleSubject.asBroadcastStream();
}