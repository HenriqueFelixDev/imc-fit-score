import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/models.dart';
import '../../../repositories/person/person_repository.dart';

part 'imc_list_event.dart';
part 'imc_list_state.dart';

class IMCListBloc extends Bloc<IMCListEvent, IMCListState> {
  final PersonRepository _personRepository;

  IMCListBloc({
    required PersonRepository personRepository,
  })  : _personRepository = personRepository,
        super(const IMCListState.initial()) {
    on<IMCListStarted>(_onStarted);

    add(const IMCListStarted());
  }

  Future<void> _onStarted(IMCListStarted event, Emitter emit) async {
    emit(state.copyWith(status: IMCListStatus.loading));

    await emit.forEach(
      _personRepository.getAllThePeople(),
      onData: (people) => state.copyWith(
        people: people,
        status: IMCListStatus.success,
      ),
      onError: (_, __) => state.copyWith(status: IMCListStatus.failure),
    );
  }
}
