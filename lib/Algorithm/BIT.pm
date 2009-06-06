package Algorithm::BIT;
use strict;
use warnings;
use integer;

use Carp qw/croak/;

sub new {
    my ($class, $n) = @_;
    my $self = bless [], $class;
    for (my $i = 0; $i < $n; $i++) {
        $self->[$i] = 0;
    }
    return $self;
}

sub read {
    my ($self, $idx) = @_;

    if ($idx > @$self) {
        croak 'assert: index overflow';
    }

    my $sum = 0;
    while ($idx > 0) {
        $sum += $self->[$idx];
        $idx = $idx & $idx - 1;
    }

    return $sum;
}

sub update {
    my ($self, $idx, $val) = @_;
    my $max = @$self;
    while ($idx <= $max) {
        $self->[$idx] += $val;
        $idx += ($idx & -$idx);
    }
}

1;

__END__

=head1 NAME

Algorithm::BIT - Binary Indexed Tree a.k.a Fenwick Tree

=head1 SYNOPSIS

  use Algorithm::BIT;

  my $bit = Algorithm::BIT->new(16); # 16 is a numbers of objects

  ## updating frequencies in O(lg n)
  $bit->update(1, 2); # object#1 occuring 2 times
  $bit->update(5, 1);
  $bit->update(8, 2);

  ## getting cumulative frequencies in O(lg n)
  say $bit->read(1);  # 2
  say $bit->read(2);  # 2
  say $bit->read(5);  # 3
  say $bit->read(10); # 5

=head1 DESCRIPTION

Binary Indexed Tree (BIT) is able to compute cumulative sum of any
range of consecutive elements in O(lg n) and also changing value of
any single element needs O(lg n) time as well.(quote from
http://www.algorithmist.com/index.php/Fenwick_tree)

=head1 SEE ALSO

http://www.topcoder.com/tc?module=Static&d1=tutorials&d2=binaryIndexedTrees

=head1 AUTHOR

Naoya Ito, E<lt>naoya at bloghackers.net<gt>

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
