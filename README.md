# dedent

Dedent - Remove any common leading whitespace from every line in text. Ported from Python.

## Install

Add

```yaml
dependencies:
  dedent: any
```

to your `pubspec.yaml`
then run the usual `flutter pub get` or just `dart pub get` for a pure dart project.

> Actually now that `dedent` has been update to support null safety in version `1.0.0` 
you should make the dependency `dedent: ^1.0.0`.  If you want the older version without null safety, you can use `dedent: ^0.0.2`.

## Usage

```dart
import 'package:dedent/dedent.dart';
```

It's quite handy to strip leading spaces from multi-line text. 
Flutter code often involves deeply nested indented code, so any multiline text
will end up containing leading spaces or tabs - which may affect your layout!

```dart
FittedBox(
  child: Text(dedent('''
    Not really possible to access another widget, or rather, another
    widget's state in order to change it. You really need to create
    a model and have the model change cause the change.
  ''')),
)
```

`dedent()` removes any common leading whitespace from every line in `text`.
This can be used to make triple-quoted strings line up with the left
edge of the display, while still presenting them in the source code
in indented form.

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

> Note that `dedent()` is ported from the long standing and reliable 
Python `textwrap.dedent` algorithm, complete with
the *original unit tests*, so you know its good. 👍

## Tests

This project is a direct translation of the 
Python [textwrap.dedent](https://docs.python.org/3/library/textwrap.html) algorithm.

Tests are also ported from Python.

```
dart test
```

## Contributing

*This section is only applicable if you want to fiddle with the dedent source code*

When checking out from https://github.com/abulka/flutter-dedent ensure you specify `dedent` as a 
target so that the package directory is named `dedent` not `flutter-dedent`. Viz. 

```bash
git clone git@github.com:abulka/flutter-dedent.git dedent
```

If you have checked out the `dedent` project locally and prefer your other 
Dart/Flutter projects to refer to 
this local copy instead of to the official version of `dedent` on
[pub.dev](https://pub.dev/packages/dedent), simply adjust your `pubspec.yaml`:

```yaml
dependencies:
  dedent:
    path: ../dedent
```

which assumes a directory structure where you are referring to the local `dedent` project from 
a sibling project e.g. called `flutter_proj1` like this:

```
┌─────────────────────┐
│Development Directory│
├─────────────────────┘
│                      
│  ┌──────────────────┐
├─▶│  flutter_proj1   │
│  └──────────────────┘
│                      
│  ┌──────────────────┐
└─▶│      dedent      │
   └──────────────────┘
```

## Links

  - Official [dedent](https://pub.dev/packages/dedent) pub.dev page.
  - Source code repository https://github.com/abulka/flutter-dedent.
  - Official [Python documentation](https://docs.python.org/3/library/textwrap.html) 
  (note, only the `Textwrap.dedent` documentation is relevant since the whole Textwrap package
  has not been ported.)
  - Original [Python dedent source code](https://github.com/python/cpython/blob/eb97b9211e7c99841d6cae8c63893b3525d5a401/Lib/textwrap.py)

Thanks to the Python community for this algorithm.
