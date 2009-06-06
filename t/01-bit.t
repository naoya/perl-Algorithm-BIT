#!/usr/bin/perl
use strict;
use warnings;
use Test::More qw/no_plan/;

use Algorithm::BIT;

my $bit = Algorithm::BIT->new(16);

$bit->update(1, 10);

is $bit->read(1), 10;

$bit->update(2, 1);

is $bit->read(1), 10;
is $bit->read(2), 11;

$bit->update(5, 1);
$bit->update(8, 2);
$bit->update(12, 5);
$bit->update(16, 1);

is $bit->read(1), 10;
is $bit->read(2), 11;
is $bit->read(3), 11;
is $bit->read(4), 11;
is $bit->read(5), 12;
is $bit->read(6), 12;
is $bit->read(7), 12;
is $bit->read(8), 14;
is $bit->read(12), 19;
is $bit->read(13), 19;
is $bit->read(14), 19;
is $bit->read(15), 19;
is $bit->read(16), 20;


