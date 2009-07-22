#!/usr/bin/perl
use strict;
use warnings;
use Test::More qw/no_plan/;

use Algorithm::BIT;

my $bit = Algorithm::BIT->new(16);

is $bit->freq(0), 0;
is $bit->freq(1), 0;
is $bit->freq(2), 0;
is $bit->freq(15), 0;
is $bit->freq(16), undef;
is $bit->sum, 0;

$bit->update(1, 10);

is $bit->freq(0),  0;
is $bit->freq(1), 10;
is $bit->freq(2),  0;
is $bit->freq(3),  0;
is $bit->freq(15), 0;
is $bit->freq(16), undef;
is $bit->cumul(1), 0;
is $bit->cumul(2),10;
is $bit->sum, 10;

$bit->update(2, 1);

is $bit->freq(1),  10;
is $bit->freq(2),   1;
is $bit->cumul(1),  0;
is $bit->cumul(2), 10;
is $bit->cumul(3), 11;
is $bit->sum, 11;

$bit->update(5, 1);
$bit->update(8, 2);
$bit->update(12, 5);
$bit->update(16, 1);

is_deeply [ $bit->search_index(5)  ], [ 1, 0 ];
is_deeply [ $bit->search_index(11) ], [ 5, 11 ];
is_deeply [ $bit->search_index(15) ], [ 12, 14 ];
is_deeply [ $bit->search_index(20) ], [ 16, 19 ];

is $bit->cumul(1), 0;
is $bit->cumul(2), 10;
is $bit->cumul(3), 11;
is $bit->cumul(4), 11;
is $bit->cumul(5), 11;
is $bit->cumul(6), 12;
is $bit->cumul(7), 12;
is $bit->cumul(8), 12;
is $bit->cumul(9), 14;
is $bit->cumul(13), 19;
is $bit->cumul(14), 19;
is $bit->cumul(15), 19;
is $bit->cumul(16), 19;
is $bit->sum, 19;
