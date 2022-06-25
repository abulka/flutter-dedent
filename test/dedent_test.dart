import 'package:test/test.dart';
import 'package:dedent/dedent.dart';

// EXTRACT FROM OFFICIAL PYTHON TEXTWRAP.DEDENT TEST SUITE
//
//
// Test suite for the textwrap.dedent module.
//
// Original tests written by Greg Ward <gward@python.net>.
// Converted to PyUnit by Peter Hansen <peter@engcorp.com>.
// Currently maintained by Greg Ward.
//
// $Id$
//

void main() {
  assertUnchanged(text) {
    // assert that dedent() has no effect on 'text'
    expect(text, equals(text));
  }

  test('test_dedent_nomargin - No lines indented.', () {
    var text = "Hello there.\nHow are you?\nOh good, I'm glad.";
    assertUnchanged(text);

    // Similar, with a blank line.
    text = "Hello there.\n\nBoo!";
    assertUnchanged(text);

    // Some lines indented, but overall margin is still zero.
    text = "Hello there.\n  This is indented.";
    assertUnchanged(text);

    // Again, add a blank line.
    text = "Hello there.\n\n  Boo!\n";
    assertUnchanged(text);
  });

  test('test_dedent_even - All lines indented by two spaces.', () {
    var text = "  Hello there.\n  How are ya?\n  Oh good.";
    var _expect = "Hello there.\nHow are ya?\nOh good.";
    expect(_expect, equals(dedent(text)));

    // Same, with blank lines.
    text = "  Hello there.\n\n  How are ya?\n  Oh good.\n";
    _expect = "Hello there.\n\nHow are ya?\nOh good.\n";
    expect(_expect, equals(dedent(text)));

    // Now indent one of the blank lines.
    text = "  Hello there.\n  \n  How are ya?\n  Oh good.\n";
    _expect = "Hello there.\n\nHow are ya?\nOh good.\n";
    expect(_expect, equals(dedent(text)));
  });

  test('test_dedent_uneven - Lines indented unevenly.', () {
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

    // Uneven indentation with a blank line.
    text = "  Foo\n    Bar\n\n   Baz\n";
    _expect = "Foo\n  Bar\n\n Baz\n";
    expect(_expect, equals(dedent(text)));

    // Uneven indentation with a whitespace-only line.
    text = "  Foo\n    Bar\n \n   Baz\n";
    _expect = "Foo\n  Bar\n\n Baz\n";
    expect(_expect, equals(dedent(text)));
  });

  test(
      'test_dedent_declining - Uneven indentation with declining indent level.',
      () {
    var text = "     Foo\n    Bar\n"; // 5 spaces, then 4
    var _expect = " Foo\nBar\n";
    expect(_expect, equals(dedent(text)));

    // Declining indent level with blank line.
    text = "     Foo\n\n    Bar\n"; // 5 spaces, blank, then 4
    _expect = " Foo\n\nBar\n";
    expect(_expect, equals(dedent(text)));

    // Declining indent level with whitespace only line.
    text = "     Foo\n    \n    Bar\n"; // 5 spaces, then 4, then 4
    _expect = " Foo\n\nBar\n";
    expect(_expect, equals(dedent(text)));
  });

  test(
      'test_dedent_preserve_internal_tabs - dedent() should not mangle internal tabs.',
      () {
    var text = "  hello\tthere\n  how are\tyou?";
    var _expect = "hello\tthere\nhow are\tyou?";
    expect(_expect, equals(dedent(text)));

    // make sure that it preserves tabs when it's not making any
    // changes at all
    expect(_expect, equals(dedent(_expect)));
  });

  test('test_dedent_preserve_margin_tabs', () {
    // dedent() should not mangle tabs in the margin (i.e.
    // tabs and spaces both count as margin, but are *not*
    // considered equivalent)
    var text = "  hello there\n\thow are you?";
    assertUnchanged(text);

    // same effect even if we have 8 spaces
    text = "        hello there\n\thow are you?";
    assertUnchanged(text);

    // dedent() only removes whitespace that can be uniformly removed!
    text = "\thello there\n\thow are you?";
    var _expect = "hello there\nhow are you?";
    expect(_expect, equals(dedent(text)));

    text = "  \thello there\n  \thow are you?";
    expect(_expect, equals(dedent(text)));

    text = "  \t  hello there\n  \t  how are you?";
    expect(_expect, equals(dedent(text)));

    text = "  \thello there\n  \t  how are you?";
    _expect = "hello there\n  how are you?";
    expect(_expect, equals(dedent(text)));

    // test margin is smaller than smallest indent
    text = "  \thello there\n   \thow are you?\n \tI'm fine, thanks";
    _expect = " \thello there\n  \thow are you?\n\tI'm fine, thanks";
    expect(_expect, equals(dedent(text)));
  });
}
