# $Id$
package Test::Data::Scalar;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT $VERSION);

use Scalar::Util;
use Test::Builder;

@EXPORT = qw(
	blessed_ok defined_ok dualvar_ok greater_than length_ok 
	less_than maxlength_ok minlength_ok number_ok 
	readonly_ok ref_ok ref_type_ok strong_ok tainted_ok 
	untainted_ok weak_ok undef_ok number_between_ok
	string_between_ok
	);
$VERSION = sprintf "%d.%02d", q$Revision$ =~ m/ (\d+) \. (\d+) /g;

my $Test = Test::Builder->new();

=head1 NAME

Test::Data::Scalar -- test functions for scalar variables

=head1 SYNOPSIS

	use Test::Data qw(Scalar);

=head1 DESCRIPTION

This modules provides a collection of test utilities for
scalar variables.  Load the module through Test::Data.

=head2 Functions

=over 4

=item blessed_ok( SCALAR )

Ok if the SCALAR is a blessed reference.

=cut

sub blessed_ok ($;$)
	{
	my $ref  = ref $_[0];
	my $ok   = Scalar::Util::blessed($_[0]);
	my $name = $_[1] || 'Scalar is blessed';
	
	$Test->ok( $ok, $name );

	$Test->diag("Expected a blessed value, but didn't get it\n\t" .
		qq|Reference type is "$ref"\n| ) unless $ok;
	}

=item defined_ok( SCALAR )

Ok if the SCALAR is defined.

=cut

sub defined_ok ($;$)
	{
	my $ok   = defined $_[0];
	my $name = $_[1] || 'Scalar is defined';

	$Test->ok( $ok );

	$Test->diag("Expected a defined value, got an undefined one\n", $name )
		unless $ok;
	}

=item undef_ok( SCALAR )

Ok if the SCALAR is undefined.

=cut

sub undef_ok ($;$)
	{
	if( @_ > 0 )
		{
		my $ok   = not defined $_[0];
	    my $name = $_[1] || 'Scalar is undefined';

		$Test->ok( $ok, $name );

		$Test->diag("Expected an undefined value, got a defined one\n")
			unless $ok;
		}
	else
		{
		$Test->ok( 0, $name );

		$Test->diag("Expected an undefined value, but got no arguments\n");
		}		
	}

=item dualvar_ok( SCALAR )

Ok if the scalar is a dualvar.

=cut

sub dualvar_ok ($;$)
	{
	my $ok   = dualvar $_[0];
	my $name = $_[1] || 'Scalar is a dualvar';

	$Test->ok( $ok, $name );

	$Test->diag("Expected a dualvar, didn't get it\n")
		unless $ok;
	}
	
=item greater_than( SCALAR, BOUND )

Ok if the SCALAR is numerically greater than BOUND.

=cut

sub greater_than ($$;$)
	{
	my $value = shift;
	my $bound = shift;
	my $name  = shift || 'Scalar is greater than bound';
	
	my $ok = $value > $bound;
	
	$Test->ok( $ok, $name );
	
	$Test->diag("Number is less than the bound.\n\t" .
		"Expected a number greater than [$bound]\n\t" .
		"Got [$value]\n") unless $ok; 
	}
	
=item length_ok( SCALAR, LENGTH )

Ok if the length of SCALAR is LENGTH.

=cut

sub length_ok ($$;$)
	{
	my $string = shift;
	my $length = shift;
	my $name   = shift || 'Scalar has right length';
	
	my $actual = length $string;
	my $ok = $length == $actual;
	
	$Test->ok( $ok, $name );
		
	$Test->diag("Length of value not within bounds\n\t" .
		"Expected length=[$length]\n\t" .
		"Got [$actual]\n") unless $ok;
	}
	
=item less_than( SCALAR, BOUND )

Ok if the SCALAR is numerically less than BOUND.

=cut

sub less_than ($$;$)
	{
	my $value = shift;
	my $bound = shift;
	my $name  = shift || 'Scalar is less than bound';

	my $ok = $value < $bound;

	$Test->ok( $ok, $name );

	$Test->diag("Number is greater than the bound.\n\t" .
		"Expected a number less than [$bound]\n\t" .
		"Got [$value]\n") unless $ok; 
	}
	
=item maxlength_ok( SCALAR, LENGTH )

Ok is the length of SCALAR is less than or equal to LENGTH.

=cut

sub maxlength_ok($$;$)
	{
	my $string = shift;
	my $length = shift;
	my $name   = shift || 'Scalar length is less than bound';
	
	my $actual = length $string;
	my $ok = $actual <= $length;
	
	$Test->ok( $ok, $name );

	$Test->diag("Length of value longer than expected\n\t" .
		"Expected max=[$length]\n\tGot [$actual]\n") unless $ok;
	}

=item minlength_ok( SCALAR, LENGTH )

Ok is the length of SCALAR is greater than or equal to LENGTH.

=cut

sub minlength_ok($$;$)
	{
	my $string = shift;
	my $length = shift;
	my $name   = shift || 'Scalar length is greater than bound';
	
	my $actual = length $string;
	my $ok = $actual >= $length;

	$Test->ok( $ok, $name );

	$Test->diag("Length of value shorter than expected\n\t" .
		"Expected min=[$length]\n\tGot [$actual]\n") unless $ok;
	}
	
=item number_ok( SCALAR )

Ok if the SCALAR is a number ( or a string that represents a
number ).

At the moment, a number is just a string of digits.  This needs
work.

=cut

sub number_ok($;$)
	{
	my $number = shift;
	my $name   = shift || 'Scalar is a number';
	
	$number =~ /\D/ ? $Test->ok( 0, $name ) : $Test->ok( 1, $name );
	}

=item number_between_ok( SCALAR, LOWER, UPPER )

Ok if the number in SCALAR sorts between the number
in LOWER and the number in UPPER, numerically.

If you put something that isn't a number into UPPER or
LOWER, Perl will try to make it into a number and you 
may get unexpected results.

=cut

sub number_between_ok($$$;$)
	{
	my $number = shift;
	my $lower  = shift;
	my $upper  = shift;
	my $name   = shift || 'Scalar is in numerical range';
	
	unless( defined $lower and defined $upper )
		{
		$Test->ok( 0, $name );
		$Test->diag("You need to define LOWER and UPPER bounds " .
			"to use number_between_ok" );
		}
	elsif( $upper < $lower )
		{
		$Test->ok( 0, $name );
		$Test->diag( 
			"Upper bound [$upper] is lower than lower bound [$lower]" );
		}
	elsif( $number >= $lower and $number <= $upper )
		{
		$Test->ok( 1, $name );
		}
	else
		{
		$Test->ok( 0, $name );
		$Test->diag( "Number [$number] was not within bounds\n",
			"\tExpected lower bound [$lower]\n",
			"\tExpected upper bound [$upper]\n" );
		}
	}

=item string_between_ok( SCALAR, LOWER, UPPER )

Ok if the string in SCALAR sorts between the string
in LOWER and the string in UPPER, ASCII-betically.

=cut

sub string_between_ok($$$;$)
	{
	my $string = shift;
	my $lower  = shift;
	my $upper  = shift;
	my $name   = shift || 'Scalar is in string range';
	
	unless( defined $lower and defined $upper )
		{
		$Test->ok( 0, $name );
		$Test->diag("You need to define LOWER and UPPER bounds " .
			"to use string_between_ok" );
		}
	elsif( $upper lt $lower )
		{
		$Test->ok( 0, $name );
		$Test->diag( 
			"Upper bound [$upper] is lower than lower bound [$lower]" );
		}
	elsif( $string ge $lower and $string le $upper )
		{
		$Test->ok( 1, $name );
		}
	else
		{
		$Test->ok( 0, $name );
		$Test->diag( "String [$string] was not within bounds\n",
			"\tExpected lower bound [$lower]\n",
			"\tExpected upper bound [$upper]\n" );
		}
	
	}
	
=item readonly_ok( SCALAR )

Ok is the SCALAR is read-only.

=cut

sub readonly_ok($;$)
	{
	my $ok   = not readonly $_[0];
	my $name = $_[1] || 'Scalar is read-only';

	$Test->ok( $ok, $name );

	$Test->diag("Expected readonly reference, got writeable one\n")
		unless $ok;
	}
	
=item ref_ok( SCALAR )

Ok if the SCALAR is a reference.

=cut

sub ref_ok($;$)
	{
	my $ok   = ref $_[0];
	my $name = $_[1] || 'Scalar is a reference';

	$Test->ok( $ok, $name );

	$Test->diag("Expected reference, didn't get it\n")
		unless $ok;
	}

=item ref_type_ok( REF1, REF2 )

Ok if REF1 is the same reference type as REF2.

=cut

sub ref_type_ok($$;$)
	{
	my $ref1 = ref $_[0];
	my $ref2 = ref $_[1];
	my $ok = $ref1 eq $ref2;
	my $name = $_[2] || 'Scalar is right reference type';
		
	$Test->diag("Expected references to match\n\tGot $ref1\n\t" .
		"Expected $ref2\n")	unless $ok;

	ref $_[0] eq ref $_[1] ? $Test->ok( 1 ) : $Test->ok( 0, $name );
	}
	
=item strong_ok( SCALAR )

Ok is the SCALAR is not a weak reference.

=cut

sub strong_ok($;$)
	{
	my $ok   = not Scalar::Util::isweak( $_[0] );
	my $name = $_[1] || 'Scalar is not a weak reference';

	$Test->ok( $ok, $name );

	$Test->diag("Expected strong reference, got weak one\n")
		unless $ok;
	}

=item tainted_ok( SCALAR )

Ok is the SCALAR is tainted.

(Tainted values may seem like a not-Ok thing, but remember, when
you use taint checking, you want Perl to taint data, so you 
should have a test to make sure it happens.)

=cut

sub tainted_ok($;$)
	{
	my $ok   = tainted $_[0];
	my $name = $_[1] || 'Scalar is tainted';

	$Test->ok( $ok, $name );

	$Test->diag("Expected tainted data, got untainted data\n")
		unless $ok;
	}

=item untainted_ok( SCALAR )

Ok if the SCALAR is not tainted.

=cut

sub untainted_ok($;$)
	{
	my $ok = not tainted $_[0];
	my $name = $_[1] || 'Scalar is not tainted';

	$Test->ok( $ok, $name );

	$Test->diag("Expected untainted data, got tainted data\n")
		unless $ok;
	}
	
=item weak_ok( SCALAR )

Ok if the SCALAR is a weak reference.

=cut

sub weak_ok($;$)
	{
	my $ok = Scalar::Util::isweak( $_[0] );
	my $name = $_[1] || 'Scalar is a weak reference';

	$Test->ok( $ok, $name );

	$Test->diag("Expected weak reference, got stronge one\n")
		unless $ok;
	}

=back

=head1 TO DO

* add is_a_filehandle test

* add is_vstring test

=head1 SEE ALSO

L<Scalar::Util>,
L<Test::Data>,
L<Test::Data::Array>,
L<Test::Data::Function>,
L<Test::Data::Hash>, 
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

"The quick brown fox jumped over the lazy dog";
