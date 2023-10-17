import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/models.dart';
import '../../../repositories/person/person_repository.dart';
import '../../../repositories/person_dimensions/person_dimensions_repository.dart';
import '../../../services/imc_service/imc_service.dart';

part 'imc_form_state.dart';

class IMCFormBloc extends Cubit<IMCFormState> {
  final IMCService _imcService;
  final PersonRepository _personRepository;
  final PersonDimensionsRepository _personDimensionsRepository;

  IMCFormBloc({
    required IMCService imcService,
    required PersonRepository personRepository,
    required PersonDimensionsRepository personDimensionsRepository,
    Person? initialPerson,
  })  : _imcService = imcService,
        _personRepository = personRepository,
        _personDimensionsRepository = personDimensionsRepository,
        super(IMCFormState.initial(initialPerson: initialPerson));

  Future<void> calculateIMC() async {
    try {
      emit(state.copyWith(status: IMCFormStatus.loading));

      final person = state.person;

      if (state.id == null) {
        final generatedId = await _personRepository.createPerson(person);
        emit(state.copyWith(id: generatedId));
      } else if (person != state.initialValue) {
        await _personRepository.updatePerson(person);
      }

      await _personDimensionsRepository.saveDimensions(state.personDimensions);

      final result = _imcService.getIMC(state.height, state.weight);

      emit(state.copyWith(imcResult: result, status: IMCFormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: IMCFormStatus.failure));
    }
  }

  String? get name => state.name;
  set name(String? name) => emit(state.copyWith(name: name));

  Gender? get gender => state.gender;
  set gender(Gender? gender) => emit(state.copyWith(gender: gender));

  double get height => state.height;
  set height(double height) => emit(state.copyWith(height: height));

  double get weight => state.weight;
  set weight(double weight) => emit(state.copyWith(weight: weight));
}
