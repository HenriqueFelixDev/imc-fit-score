import 'imc_status.dart';

class IMCResult {
  final double imc;
  final double height;
  final double weight;
  final IMCStatus status;

  const IMCResult({
    required this.imc,
    required this.height,
    required this.weight,
    required this.status,
  });

  @override
  String toString() =>
      'IMCResult(imc: $imc, height: $height, weight: $weight, status: $status)';
}
