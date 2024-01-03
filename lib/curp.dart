/// A Mexican CURP.
final class Curp {
  const Curp._({required String value}) : _value = value;

  /// {@template curp.parse}
  /// Constructs a new [Curp] instance based on [input].
  /// {@endtemplate}
  ///
  /// Throws a [FormatException] if [input] is not a valid CURP.
  factory Curp.parse(String input) {
    /// Generates the last digit of a CURP from the other part of the given
    /// CURP.
    int generateCheckDigit(String input) {
      assert(input.length == 17, '`input` length must be 17');

      const dictionary = '0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';
      var accumulator = 0;
      var checkDigit = 0;
      for (var index = 0; index < input.length; index++) {
        accumulator += dictionary.indexOf(input[index]) * (18 - index);
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
    final hasMatch = regex.hasMatch(input);
    if (!hasMatch) {
      throw FormatException('Invalid CURP', input);
    }

    // The second part to validate is the match between the check digit (last
    // digit) of the CURP given by the input and a generated one.
    final curpWithoutCheckDigit = input.substring(0, input.length - 1);
    final generatedCheckDigit = generateCheckDigit(curpWithoutCheckDigit);
    final isValid = input.endsWith(generatedCheckDigit.toString());
    if (!isValid) {
      throw FormatException('Invalid CURP', input);
    }
    return Curp._(value: input);
  }

  /// The inner value of this CURP.
  final String _value;

  /// {@macro curp.parse}
  ///
  /// Returns `null` if [input] is not a valid CURP.
  static Curp? tryParse(String input) {
    try {
      return Curp.parse(input);
    } catch (_) {
      return null;
    }
  }

  @override
  String toString() => _value;
}
