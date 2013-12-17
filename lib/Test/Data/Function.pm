package Test::Data::Function;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT $VERSION);

@EXPORT  = qw(prototype_ok);
$VERSION = '1.24';

use Test::Builder;
my $Test = Test::Builder->new();

=encoding utf8

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
		$Test->diag( "Subroutine has prototype [$actual]; expected [$prototype]" );
		$Test->ok(0, $name);
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

This source is in Github:

	https://github.com/briandfoy/test-data

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2002-2012 brian d foy.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

"red leather yellow leather";
