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
    map { *{$caller . "::$_"} = \&{$_} } qw/
        use_ok
    /;
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

sub use_ok {
    my ($class, @args) = @_;
    Module::Load::load $class, @args;
    Test::Modern::ok Module::Loaded::is_loaded($class),
        "... Loaded the module: $class";
}

1;

# ABSTRACT: Modern Perl testing with a single import

