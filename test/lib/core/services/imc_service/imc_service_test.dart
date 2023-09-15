import 'package:flutter_test/flutter_test.dart';
import 'package:imc_fitscore/core/exceptions/exceptions.dart';

import 'package:imc_fitscore/core/models/models.dart';
import 'package:imc_fitscore/services/imc_service/imc_service.dart';
import 'package:imc_fitscore/services/imc_service/imc_service_impl.dart';

void main() {
  group('getIMC Tests |', () {
    final IMCService imcService = IMCServiceImpl();

    test('should return right IMC status', () {
      final inputs = <Map<String, dynamic>>[
        {'weight': 49.12, 'height': 1.70, 'imc': 16.99, 'expected': IMCStatus.veryUnderweight},
        {'weight': 2.5, 'height': 0.45, 'imc': 12.34, 'expected': IMCStatus.veryUnderweight},
        {'weight': 49.13, 'height': 1.70, 'imc': 17.0, 'expected': IMCStatus.underweight},
        {'weight': 59.3, 'height': 1.82, 'imc': 17.9, 'expected': IMCStatus.underweight},
        {'weight': 45.0215, 'height': 1.56, 'imc': 18.49, 'expected': IMCStatus.underweight},
        {'weight': 67.49, 'height': 1.91, 'imc': 18.5, 'expected': IMCStatus.normal},
        {'weight': 63.2, 'height': 1.59, 'imc': 24.99, 'expected': IMCStatus.normal},
        {'weight': 68.07, 'height': 1.65, 'imc': 25.0, 'expected': IMCStatus.overweight},
        {'weight': 108.29, 'height': 1.90, 'imc': 29.99, 'expected': IMCStatus.overweight},
        {'weight': 84.68, 'height': 1.68, 'imc': 30.0, 'expected': IMCStatus.obeseClass1},
        {'weight': 122.38, 'height': 1.87, 'imc': 34.99, 'expected': IMCStatus.obeseClass1},
        {'weight': 87.38, 'height': 1.58, 'imc': 35.0, 'expected': IMCStatus.obeseClass2},
        {'weight': 96.09, 'height': 1.55, 'imc': 39.99, 'expected': IMCStatus.obeseClass2},
        {'weight': 110.23, 'height': 1.66, 'imc': 40.0, 'expected': IMCStatus.obeseClass3},
        {'weight': 177.97, 'height': 1.85, 'imc': 52.0, 'expected': IMCStatus.obeseClass3},
      ];

      for (final input in inputs) {
        final {
          'weight': double weight,
          'height': double height,
          'imc': double expectedIMC,
          'expected': IMCStatus expected,
        } = input;

        final person = Person(
          name: null,
          gender: null,
          height: height,
          weight: weight,
        );

        final IMCResult(:imc, :status) = imcService.getIMC(person);

        expect(imc, closeTo(expectedIMC, 0.1));
        expect(status, equals(expected));
        expect(status.minIMC, equals(expected.minIMC));
        expect(status.maxIMC, equals(expected.maxIMC));
      }
    });

    test('should return assertion error', () {
      final inputs = <Map<String, dynamic>>[
        {'weight': 0.0, 'height': 0.0},
        {'weight': 1.0, 'height': 0.0},
        {'weight': -1.0, 'height': 1.0},
        {'weight': -1.0, 'height': -1.0},
        {'weight': 1.0, 'height': -1.0},
      ];

      for (final input in inputs) {
        final {
          'weight': double weight,
          'height': double height,
        } = input;

        final person = Person(
          name: null,
          gender: null,
          height: height,
          weight: weight,
        );

        expect(() => imcService.getIMC(person), throwsAssertionError);
      }
    });

    test('should return InvalidIMCException', () {
      final inputs = <Map<String, dynamic>>[
        {'weight': double.infinity, 'height': 1.0},
      ];

      for (final input in inputs) {
        final {
          'weight': double weight,
          'height': double height,
        } = input;

        final person = Person(
          name: null,
          gender: null,
          height: height,
          weight: weight,
        );

        expect(() => imcService.getIMC(person), throwsA(isA<InvalidIMCException>()));
      }
    });
  });
}