# Scenario

An important goal for SpareRoom is to write unit tests for all existing legacy
code, and to refactor the code where necessary.

The code in `ReplaceTags.pm` was once contained in the `replace_tags.pl`
script.  Because writing unit tests for Perl scripts is difficult, the code
has since been moved into `ReplaceTags.pm`.  Other than wrapping the code in
a module,  it has not been changed in any way.  Now imagine that the module
and script form an important part of a much larger application, and that there
are currently no unit tests for the module.

There are a number of things wrong with the design of the code, so part
of the refactoring plan is to fix these problems.  Before any refactoring work
can be done, it is vital that tests are written for the existing code.  This
will help the developer to determine if changes introduced during refactoring
have adversely affected the code.  The tests must therefore provide as much
coverage of the legacy code as reasonably possible.

Only when proper tests have been written may refactoring begin.  The tests
must pass at each stage of the refactoring process.  In a real scenario, the
module may be much larger, and may have many dependencies.

## lib/ReplaceTags.pm

This module searches a directory for `*.tpl` files.  For each file that it
finds, it searches the contents for a list of tags and replaces them with
strings supplied to its `run()` function.

## replace_tags.pl

This script calls `ReplaceTags`, and passes hashref which contains the tag
replacements.

# Tasks

For the sake of this task, the module has been designed to be small, whilst
also presenting a number of problems.  The module is awkward to use, as the
API is not well designed.  It is also hard (or perhaps impossible) to fully
test.  To make matters worse, there are a number of places where modern Perl
techniques and best practices have not been followed.

1. Write tests for the module, using your judgement to determine an appropriate
   level of coverage.  The tests should pass when run against the existing code
   and the refactored code from task two, below.

   Provide a description of:
   
   - what makes the module difficult to test
   - how you went about determining test coverage

2. Refactor `ReplaceTags.pm` so that it performs the same task.  The API may be
   enhanced, but it should maintain backwards compatibility.  Your answer
   must take into account the following:

   - Testability    (changes to make the code easier to test)
   - Usability      (code re-use, API design, etc.)
   - Best practices (robustness, modern Perl idioms, and so on)
