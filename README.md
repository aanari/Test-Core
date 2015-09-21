# NAME

Test::Core - Modern Perl testing with a single import

# VERSION

version 0.0200

# SYNOPSIS

    use Test::Core;

    # Your tests here

    done_testing

# DESCRIPTION

Test::Core provides the best testing harness of Modern Perl in a single, user-friendly import. It builds off of [Test::Modern](https://metacpan.org/pod/Test::Modern) while also providing clean interfaces to dumping and mocking facilities from other libraries.

Test::Core also automatically imposes [strict](https://metacpan.org/pod/strict) and [warnings](https://metacpan.org/pod/warnings) on your script, and loads [IO::File](https://metacpan.org/pod/IO::File). Although Test::Modern is a modern testing framework, it should run fine on pre-modern versions of Perl.

# FUNCTIONS

## Test::More

Test::Core exports the following from [Test::More](https://metacpan.org/pod/Test::More):

- `ok($truth, $description)`
- `is($got, $expected, $description)`
- `isnt($got, $unexpected, $description)`
- `like($got, $regexp, $description)`
- `unlike($got, $regexp, $description)`
- `is_deeply($got, $expected, $description)`
- `cmp_ok($got, $operator, $expected, $description)`
- `new_ok($class, \@args, $name)`
- `isa_ok($object|$subclass, $class, $name)`
- `can_ok($object|$class, @methods)`
- `pass($description)`
- `fail($description)`
- `subtest($description, sub { ... })`
- `diag(@messages)`
- `note(@messages)`
- `explain(@messages)`
- `skip($why, $count) if $reason`
- `todo_skip($why, $count) if $reason`
- `$TODO`
- `plan(%plan)`
- `done_testing`
- `BAIL_OUT($reason)`

## Test::Fatal

Test::Core exports the following from [Test::Fatal](https://metacpan.org/pod/Test::Fatal):

- `exception { BLOCK }`

## Test::Warnings

Test::Core exports the following from [Test::Warnings](https://metacpan.org/pod/Test::Warnings):

- `warning { BLOCK }`
- `warnings { BLOCK }`

## Test::API

Test::Core exports the following from [Test::API](https://metacpan.org/pod/Test::API):

- `public_ok($package, @functions)`
- `import_ok($package, export => \@functions, export_ok => \@functions)`
- `class_api_ok($class, @methods)`

## Test::LongString

Test::Core exports the following from [Test::LongString](https://metacpan.org/pod/Test::LongString):

- `is_string($got, $expected, $description)`
- `is_string_nows($got, $expected, $description)`
- `like_string($got, $regexp, $description)`
- `unlike_string($got, $regexp, $description)`
- `contains_string($haystack, $needle, $description)`
- `lacks_string($haystack, $needle, $description)`

## Test::Deep

Test::Core exports the following from [Test::Deep](https://metacpan.org/pod/Test::Deep):

- `cmp_deeply($got, $expected, $description)`
- `ignore()`
- `methods(%hash)`
- `listmethods(%hash)`
- `shallow($thing)`
- `noclass($thing)`
- `useclass($thing)`
- `re($regexp, $capture_data, $flags)`
- `superhashof(\%hash)`
- `subhashof(\%hash)`
- `bag(@elements)`
- `set(@elements)`
- `superbagof(@elements)`
- `subbagof(@elements)`
- `supersetof(@elements)`
- `subsetof(@elements)`
- `all(@expecteds)`
- `any(@expecteds)`
- `obj_isa($class)`
- `array_each($thing)`
- `str($string)`
- `num($number, $tolerance)`
- `bool($value)`
- `code(\&subref)`

## Test::Modern

Test::Core exports the following from [Test::Modern](https://metacpan.org/pod/Test::Modern):

- `does_ok($object|$subclass, $class, $name)`
- `namespaces_clean(@namespaces)`
- `is_fastest($implementation, $times, \%implementations, $desc)`
- `object_ok($object, $name, %tests)`

## Data::Dump

Test::Core exports the following from [Data::Dump](https://metacpan.org/pod/Data::Dump):

- `dd(@objects)`
- `ddx(@objects)`

## Test::Core

Test::Core implements the following mocking functions using [Test::MockModule](https://metacpan.org/pod/Test::MockModule), [Test::MockObject](https://metacpan.org/pod/Test::MockObject), and [Test::MockObject::Extends](https://metacpan.org/pod/Test::MockObject::Extends):

- `MM($class, %mocks)`

        # This module is mocked as long as $mock is in scope
        my $mock = MM('DateTime', year => 1776);

- `MO(%mocks)`

        # Takes an optional "extends" for extending existing objects
        my $mock = MO(
            extends => 'DateTime',
            now     => sub { DateTime->now->add(days => 3) },
        );

# BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/aanari/Test-Core/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# AUTHOR

Ali Anari <ali@anari.me>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Ali Anari.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
