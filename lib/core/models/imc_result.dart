import 'imc_status.dart';

class IMCResult {
  final double imc;
  final IMCStatus status;

  const IMCResult({
    required this.imc,
    required this.status,
  });

  @override
  String toString() => 'IMCResult(imc: $imc, status: $status)';
}
