package Test::Data::Function;
# $Id$
use strict;

use base qw(Exporter);
use vars qw(@EXPORT);

@EXPORT = qw(prototype_ok);

my $Test = Test::Builder->new();
	
=head1 NAME

Test::Data::Function -- test functions for functions

=head1 SYNOPSIS

use Test::Data::Function;


=head1 DESCRIPTION


=head2 FUNCTIONS


=over 4

=item prototype_ok( PROTOTYPE, SUB )


=cut

sub prototype_ok(\&$;$)
	{
	my $sub        = shift;
	my $prototype  = shift;
	my $name       = shift;
	
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
L<Test::Data::Scalar>, 
L<Test::Builder>

=head1 AUTHOR

brian d foy, E<lt>bdfoy@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2002, brian d foy, All Rights Reserved

You may use, modify, and distribute this under the same terms
as Perl itself.

=cut

"red leather yellow leather";
