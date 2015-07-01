package Test::Core;

use Data::Dump                  ();
use Import::Into;
use Module::Load                ();
use Sub::Override               ();
use Test::Modern                ();
use Test::MockObject            ();
use Test::MockObject::Extends   ();

sub import {
    my $caller = scalar caller();
    Test::Modern->import::into($caller, qw(-default -deeper !TD));
    Data::Dump->import::into($caller);

    no strict 'refs';
    *{$caller . '::MM'}  = \&mock_module;
    *{$caller . '::MO'}  = \&mock_object;
}

sub mock_module {
    my ($class, %mocks) = @_;
    my $mock_module = Sub::Override->new;
    while (my ($method, $override) = each(%mocks)) {
        $mock_module->replace(
            ($class . '::' . $method),
            ('CODE' eq ref $override ? $override : sub { $override })
        );
    }
    return $mock_module;
}

sub mock_object {
    my (%mocks) = @_;
    my $isa         = delete $mocks{isa};
    my $mock_object = $isa
        ? Test::MockObject::Extends->new($isa)
        : Test::MockObject->new;
    while (my ($method, $override) = each(%mocks)) {
        $mock_object->mock(
            $method,
            ('CODE' eq ref $override ? $override : sub { $override })
        );
    }
    return $mock_object;
}

1;

# ABSTRACT: Modern Perl testing with a single import

=head1 SYNOPSIS

    use Test::Core;

    # Your tests here

    done_testing

=head1 DESCRIPTION

Test::Core provides the best testing harness of Modern Perl in a single, user-friendly import. It builds off of L<Test::Modern> while also providing clean interfaces to dumping and mocking facilities from other libraries.

=back
