enum IMCStatus {
  veryUnderweight(minIMC: 0.0, maxIMC: 17.0),
  underweight(minIMC: 17.0, maxIMC: 18.5),
  normal(minIMC: 18.5, maxIMC: 25.0),
  overweight(minIMC: 25.0, maxIMC: 30.0),
  obeseClass1(minIMC: 30.0, maxIMC: 35.0),
  obeseClass2(minIMC: 35.0, maxIMC: 40.0),
  obeseClass3(minIMC: 40.0, maxIMC: double.infinity);

  const IMCStatus({required this.minIMC, required this.maxIMC});
  final double minIMC;
  final double maxIMC;
}
