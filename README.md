<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# CURP

Developed with `passion` by Pastel Code.

[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

---

A package to easily validate and parse a Mexican CURP.

## Features

- A `Curp` object can be constructed via `parse` or `tryParse`.
- Provides a `isValidString` static method to check whether a string is a valid representation of a CURP.

## Getting started

To start using the package is required to import it like following:

```dart
import 'package:curp/curp.dart';
```

## Usage

### Parse a string to a `Curp` object.

```dart
const curpString = '...';
Curp.parse(curpString); // It returns a Curp object or throws a FormatException.
Curp.tryParse(curpString); // It returns a Curp object or null.
```

### Retrieve CURP string

After parsing a `Curp` object its value can be retrieved with:

```dart
final curp = Curp.parse('...');
final curpString = curp.toString();
```

### Validate a CURP like string

Check whether a string is a valid CURP representation.

```dart
const curpString = '...';
final isValid = Curp.isValidString(curpString); // true or false
```

## Additional information

For more information about CURP, head to official Mexican government website: https://www.gob.mx/curp/.
