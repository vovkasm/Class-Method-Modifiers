#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 2;

my $storage = "0";

my $child = Child->new();
is($child->orig($storage), "110");
$storage = "0";
is($child->orig($storage), "110");

BEGIN {
    package Parent;
    sub new { bless {}, shift }
    sub orig {
        my $self = shift;
        $_ = "some value";
        $_[0];
    }
}

BEGIN {
    package Child;
    our @ISA = 'Parent';
    use Class::Method::Modifiers;

    before 'orig' => sub {
        my $self = shift;
        $_[0] = '1'.$_[0];
        $_='babah';
    };
    before 'orig' => sub {
        my $self = shift;
        $_[0] = '1'.$_[0];
    };
}
