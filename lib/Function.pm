# $Id$
package Test::Data::Function;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT $VERSION);

@EXPORT  = qw(prototype_ok);
$VERSION = sprintf "%d.%02d", q$Revision$ =~ m/ (\d+) \. (\d+) /g;

use Test::Builder;
my $Test = Test::Builder->new();

=head1 NAME

Test::Data::Function -- test functions for functions

=head1 SYNOPSIS

	use Test::Data qw(Function);

=head1 DESCRIPTION

This module provides test functions for subroutine sorts of things.

=head2 Functions

=over 4

=item prototype_ok( PROTOTYPE, SUB [, NAME ] )

=cut

sub prototype_ok(\&$;$)
	{
	my $sub        = shift;
	my $prototype  = shift;
	my $name       = shift || 'function prototype is correct';

	my $actual     = prototype( $sub );
	my $test       = $actual eq $prototype;

	unless( $test )
		{
		$Test->ok(0, $name);
		$Test->diag( "Subroutine has prototype [$actual]; expected [$prototype]" );
		}
	else
		{
		$Test->ok( $test, $name );
		}
	}


=back

=head1 SEE ALSO

L<Test::Data>,
L<Test::Data::Array>,
L<Test::Data::Hash>,
L<Test::Data::Scalar>,
L<Test::Builder>

=head1 SOURCE AVAILABILITY

This source is part of a SourceForge project which always has the
latest sources in CVS, as well as all of the previous releases.

	https://sourceforge.net/projects/brian-d-foy/

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, E<lt>bdfoy@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2002, brian d foy, All Rights Reserved

You may use, modify, and distribute this under the same terms
as Perl itself.

=cut

"red leather yellow leather";
