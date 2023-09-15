import '../../core/models/models.dart';

abstract interface class IMCService {
  IMCResult getIMC(Person person);
}