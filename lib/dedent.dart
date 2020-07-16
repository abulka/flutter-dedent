library dedent;

// Translation of Python textwrap.dedent algorithm
// https://github.com/python/cpython/blob/eb97b9211e7c99841d6cae8c63893b3525d5a401/Lib/textwrap.py

import 'package:quiver/iterables.dart';

/// Remove any common leading whitespace from every line in `text`.
/// This can be used to make triple-quoted strings line up with the left
/// edge of the display, while still presenting them in the source code
/// in indented form.
/// Note that tabs and spaces are both treated as whitespace, but they
/// are not equal: the lines "  hello" and "\\thello" are
/// considered to have no common leading whitespace.
/// Entirely blank lines are normalized to a newline character.
String dedent(String text) {

  var _whitespaceOnlyRe = new RegExp(r"^[ \t]+$", multiLine: true);
  var _leadingWhitespaceRe =
      new RegExp(r"(^[ \t]*)(?:[^ \t\n])", multiLine: true);

  // Look for the longest leading string of spaces and tabs common to
  // all lines.
  String margin;
  text = text.replaceAll(_whitespaceOnlyRe, '');
  var indents = _leadingWhitespaceRe.allMatches(text);
  indents.forEach((_indent) {
    String indent = text.substring(_indent.start, _indent.end - 1);
    if (margin == null)
      margin = indent;

    // Current line more deeply indented than previous winner:
    // no change (previous winner is still on top).
    else if (indent.startsWith(margin)) {
    }

    // Current line consistent with and no deeper than previous winner:
    // it's the new winner.
    else if (margin.startsWith(indent))
      margin = indent;

    // Find the largest common whitespace between current line and previous
    // winner.
    else {
      var it = zip([margin.split(''), indent.split('')]).toList();
      for (var i = 0; i < it.length; i++) {
        if (it[0] != it[1]) {
          var till = (i == 0) // compensate for lack of [:-1] Python syntax
              ? margin.length - 1
              : i - 1;
          margin = margin.substring(0, till);
          break;
        }
      }
    } // else
  }); // forEach

  // sanity check (testing/debugging only)
  var debug = false;
  if (debug && margin != '')
    text.split("\n").forEach((line) {
      assert(line == "" || line.startsWith(margin),
          "line = $line, margin = $margin");
    });

  if (margin != "") {
    var r = new RegExp(r"^" + margin,
        multiLine: true); // python r"(?m)^" illegal in js regex so leave it out
    text = text.replaceAll(r, '');
  }
  return text;
}
