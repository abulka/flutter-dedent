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
