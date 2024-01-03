import 'package:equatable/equatable.dart';

/// A Mexican CURP.
///
/// It can be constructed via [Curp.parse] or [Curp.tryParse]. Then its value
/// can be retrieved via [toString].
///
/// Provides a [isValidString] static method to check whether a string is a
/// valid representation of a Mexican CURP.
final class Curp with EquatableMixin {
  const Curp._({required String value}) : _value = value;

  /// {@template curp.parse}
  /// Constructs a new [Curp] instance based on [input].
  /// {@endtemplate}
  ///
  /// Throws a [FormatException] if the input is not a valid CURP.
  factory Curp.parse(String input) => switch (Curp.isValidString(input)) {
        true => Curp._(value: input),
        false => throw FormatException('Invalid CURP', input),
      };

  /// The inner value of this CURP.
  final String _value;

  /// Checks whether a string is a valid representation of a CURP.
  static bool isValidString(String string) {
    /// Generates the last digit of a CURP from the other part of the given
    /// CURP.
    int generateCheckDigitFrom(String restOfCurp) {
      assert(restOfCurp.length == 17, '`input` length must be 17');

      const dictionary = '0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';
      var accumulator = 0;
      var checkDigit = 0;
      for (var index = 0; index < restOfCurp.length; index++) {
        accumulator += dictionary.indexOf(restOfCurp[index]) * (18 - index);
      }
      checkDigit = 10 - accumulator % 10;
      if (checkDigit == 10) return 0;
      return checkDigit;
    }

    // The first part to validate is the general format of 18 characters and
    // groups of numbers and letters against a regular expression.
    final regex = RegExp(
      '''
[A-Z]{1}[AEIOU]{1}[A-Z]{2}[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])[HM]{1}(AS|BC|BS|CC|CS|CH|CL|CM|DF|DG|GT|GR|HG|JC|MC|MN|MS|NT|NL|OC|PL|QT|QR|SP|SL|SR|TC|TS|TL|VZ|YN|ZS|NE)[B-DF-HJ-NP-TV-Z]{3}[0-9A-Z]{1}[0-9]{1}''',
    );
    final hasMatch = regex.hasMatch(string);
    if (!hasMatch) {
      return false;
    }

    // The second part to validate is the match between the check digit (last
    // digit) of the CURP given by the input and a generated one.
    final curpWithoutCheckDigit = string.substring(0, string.length - 1);
    final generatedCheckDigit =
        generateCheckDigitFrom(curpWithoutCheckDigit).toString();
    return string.endsWith(generatedCheckDigit);
  }

  /// {@macro curp.parse}
  ///
  /// Returns `null` if the input is not a valid CURP.
  static Curp? tryParse(String input) {
    try {
      return Curp.parse(input);
    } catch (_) {
      return null;
    }
  }

  @override
  String toString() => _value;

  @override
  List<Object?> get props => [_value];
}
