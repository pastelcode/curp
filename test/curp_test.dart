import 'package:curp/curp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validCurpString = 'HEGG560427MVZRRL04';
  const wrongCurpString = 'CAHG431228HCLSRR05';

  group('parse constructor', () {
    test('parses a valid CURP', () {
      // Given

      // When
      final curp = Curp.parse(validCurpString);

      // Then
      expect(curp.toString(), validCurpString);
    });

    test('throws a FormatException when parsing an invalid CURP', () {
      // Given

      // When
      Curp curp() => Curp.parse(wrongCurpString);

      // Then
      expect(curp, throwsA(isA<FormatException>()));
    });
  });

  group('tryParse method', () {
    test('parses a valid CURP', () {
      // Given

      // When
      final curp = Curp.tryParse(validCurpString);

      // Then
      expect(curp.toString(), validCurpString);
    });

    test('returns null when trying to parse a wrong CURP string', () {
      // Given

      // When
      final curp = Curp.tryParse(wrongCurpString);

      // Then
      expect(curp, null);
    });
  });

  test('returns true for a valid CURP string representation', () {
    // Given

    // When
    final isValid = Curp.isValidString(validCurpString);

    // Then
    expect(isValid, true);
  });

  test('returns false for a not valid CURP string representation', () {
    // Given

    // When
    final isValid = Curp.isValidString(wrongCurpString);

    // Then
    expect(isValid, false);
  });
}
