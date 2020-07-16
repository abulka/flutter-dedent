# dedent

Dedent - Remove any common leading whitespace from every line in text. Ported from Python.

## Install

```
flutter pub get dedent
```

or add to your `pubspec.yaml`

```yaml
dependencies:
  dedent: ^1.0.0
```

## Usage

```dart
import 'package:dedent/dedent.dart';
```

```dart
FittedBox(
  child: Text(dedent('''
    Not really possible to access another widget, or rather, another
    widget's state in order to change it. You really need to create
    a model and have the model change cause the change - see my 
    'learn2' project.
  ''')),
)
```

more specifically

```dart
    var text = '''
        def foo():
            while 1:
                return foo
        ''';
    var _expect = '''
def foo():
    while 1:
        return foo
''';
    expect(_expect, equals(dedent(text)));
```

## Tests

```
flutter test
```

Tests are also ported from Python.

If you have checked out dedent locally and prefer to refer to the local project then your
dependencies will be something like:

```yaml
dependencies:
  dedent:
    path: ../dedent
```

## Source Code

Source code and tests at https://github.com/abulka/flutter-dedent

## Background

Translation of Python textwrap.dedent algorithm
https://github.com/python/cpython/blob/eb97b9211e7c99841d6cae8c63893b3525d5a401/Lib/textwrap.py
