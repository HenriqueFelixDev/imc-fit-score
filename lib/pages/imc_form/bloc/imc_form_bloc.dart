import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/models.dart';
import '../../../repositories/person/person_repository.dart';
import '../../../services/imc_service/imc_service.dart';

part 'imc_form_state.dart';

class IMCFormBloc extends Cubit<IMCFormState> {
  final IMCService _imcService;
  final PersonRepository _personRepository;

  IMCFormBloc({
    required IMCService imcService,
    required PersonRepository personRepository,
    Person? initialPerson,
  })  : _imcService = imcService,
        _personRepository = personRepository,
        super(IMCFormState.initial(initialPerson: initialPerson));

  Future<void> calculateIMC() async {
    try {
      emit(state.copyWith(status: IMCFormStatus.loading));

      var person = state.person;

      if (person.id == null) {
        final generatedId = await _personRepository.createPerson(person);
        person = person.copyWith(id: generatedId);
      } else if (person != state.initialValue) {
        await _personRepository.updatePerson(person);
      }

      final result = _imcService.getIMC(state.height, state.weight);

      emit(state.copyWith(imcResult: result, status: IMCFormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: IMCFormStatus.failure));
    }
  }

  String? get name => state.name;
  set name (String? name) => emit(state.copyWith(name: name));

  Gender? get gender => state.gender;
  set gender (Gender? gender) => emit(state.copyWith(gender: gender));

  double get height => state.height;
  set height (double height) => emit(state.copyWith(height: height));

  double get weight => state.weight;
  set weight (double weight) => emit(state.copyWith(weight: weight));
}
