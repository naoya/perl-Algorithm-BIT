package Algorithm::BIT;
use strict;
use warnings;
use integer;

use Params::Validate qw/validate_pos/;

sub new {
    my ($class, $n) = validate_pos(@_, 1, 1);
    my $self = bless [], $class;
    for (my $i = 0; $i < $n; $i++) {
        $self->[$i] = 0;
    }
    return $self;
}

sub cumul {
    my ($self, $i) = @_;

    my $sum = 0;
    if ($i > 0) {
        $sum = $self->[0];
        $i--;
        while ($i > 0) {
            $sum += $self->[$i];
            $i = $i & $i - 1;
        }
    }

    return $sum;
}

sub freq {
    my ($self, $i) = @_;

    if ($i >= @$self) {
        return;
    }

    my $v = $self->[$i];
    if ($i > 0) {
        my $p = $i & $i - 1;
        $i--;
        while ($i != $p) {
            $v -= $self->[$i];
            $i = $i & ($i - 1);
        }
    }
    return $v;
}

sub update {
    my ($self, $i, $v) = @_;
    my $size = @$self;
    if ($i > 0) {
        while ($i < $size) {
            $self->[$i] += $v;
            $i += ($i & -$i);
        }
    } else {
        $self->[0] += $v;
    }
}

sub search_index {
    my ($self, $v) = @_;

    my $c = 0;
    my $n = 0;
    my $size = @$self;

    if ($self->[0] <= $v) {
        my $h = $size >> 1;
        $n = $self->[0];
        while ($h > 0) {
            if (($n + $self->[$c + $h]) <= $v) {
                $n += $self->[$c + $h];
                $c += $h;
            }
            $h >>= 1;
        }
        $c++;
    }

    return ($c, $n);
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
