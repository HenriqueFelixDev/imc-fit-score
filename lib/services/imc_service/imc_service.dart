import '../../core/models/models.dart';

abstract interface class IMCService {
  IMCResult getIMC(double height, double weight);
}