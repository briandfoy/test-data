# $Id$
package Tie::Cycle;
use strict;

use vars qw( $VERSION );

$VERSION = sprintf "%d.%02d", q$Revision$ =~ m/ (\d+) \. (\d+) /xg;

sub TIESCALAR
	{
	my $class    = shift;
	my $list_ref = shift;

	my @shallow_copy = map { $_ } @$list_ref;

	return unless UNIVERSAL::isa( $list_ref, 'ARRAY' );
	return unless @$list_ref > 1;

	my $self = [ 0, scalar @shallow_copy, \@shallow_copy ];

	bless $self, $class;
	}

sub FETCH
	{
	my $self = shift;
	
	my $index = $$self[0]++;
	$$self[0] %= $self->[1];

	return $self->[2]->[ $index ];
	}

sub STORE
	{
	my $self = shift;
	my $list_ref = shift;

	return unless ref $list_ref eq ref [];
	return unless @$list_ref > 1;

	$self = [ 0, scalar @$list_ref, $list_ref ];
	}
	
sub reset
	{
	my $self = shift;
	
	$$self[0] = 0;
	}

sub previous
	{
	my $self = shift;
	
	my $index = $$self[0] - 1;
	$$self[0] %= $self->[1];

	return $self->[2]->[ $index ];
	}

sub next
	{
	my $self = shift;
	
	my $index = $$self[0] + 1;
	$$self[0] %= $self->[1];

	return $self->[2]->[ $index ];
	}

"Tie::Cycle";

__END__

=head1 NAME

Tie::Cycle - Cycle through a list of values via a scalar.

=head1 SYNOPSIS

    use Tie::Cycle;

    tie my $cycle, 'Tie::Cycle', [ qw( FFFFFF 000000 FFFF00 ) ];

	print $cycle; # FFFFFF
	print $cycle; # 000000
	print $cycle; # FFFF00
	print $cycle; # FFFFFF  back to the beginning    

	(tied $cycle)->reset;  # back to the beginning

=head1 DESCRIPTION

You use C<Tie::Cycle> to go through a list over and over again.
Once you get to the end of the list, you go back to the beginning.
You don't have to worry about any of this since the magic of
tie does that for you.

The tie takes an array reference as its third argument.  The tie
should succeed unless the argument is not an array reference or
the referenced array contains fewer than two elements.

During the tie, this module makes a shallow copy of the array
reference.  If the array reference contains references, and those
references are changed after the tie, the elements of the cycle
will change as well. See the included test.pl script for an
example of this effect.

=head1 OBJECT METHODS

You can call methods on the underlying object (which you access
with tied().).

=over 4

=item reset

Roll the iterator back to the starting position.  The next access
will give the first element in the list.

=item previous

Give the previous element.  This does not affect the current position.

=item next

Give the next element.  This does not affect the current position.
You can peek at the next element if you like.

=back

=head1 SOURCE AVAILABILITY

This source is part of a SourceForge project which always has the
latest sources in CVS, as well as all of the previous releases.

	https://sourceforge.net/projects/brian-d-foy/

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, E<lt>bdfoy@cpan.orgE<gt>

=head1 COPYRIGHT and LICENSE

Copyright 2000, brian d foy, All rights reserved.

This software is available under the same terms as perl.

=cut
