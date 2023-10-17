part of 'imc_list_bloc.dart';

enum IMCListStatus {
  initial,
  loading,
  success,
  failure;
}

class IMCListState {
  final IMCListStatus status;
  final List<Person> people;

  const IMCListState({required this.status, required this.people});

  const IMCListState.initial()
      : status = IMCListStatus.initial,
        people = const [];

  IMCListState copyWith({
    IMCListStatus? status,
    List<Person>? people,
  }) {
    return IMCListState(
      status: status ?? this.status,
      people: people ?? this.people,
    );
  }

  @override
  String toString() => 'IMCListState(status: $status, people: $people)';

  @override
  bool operator ==(covariant IMCListState other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.people, people);
  }

  @override
  int get hashCode => status.hashCode ^ people.hashCode;
}
