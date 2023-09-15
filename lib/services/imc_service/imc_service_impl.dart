
import 'dart:math';

import '../../core/exceptions/exceptions.dart';
import '../../core/models/models.dart';

import 'imc_service.dart';

class IMCServiceImpl implements IMCService {
  @override
  IMCResult getIMC(Person person) {
    final Person(:height, :weight) = person;

    assert(height > 0.0 && weight > 0.0);

    final imc = weight / pow(height, 2);

    for (final status in IMCStatus.values) {
      if (imc >= status.minIMC && imc < status.maxIMC) {
        return IMCResult(imc: imc, status: status);
      }
    }

    throw InvalidIMCException('IMC inválido');
  }
}