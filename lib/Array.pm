# $Id$
package Test::Data::Array;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT $VERSION);

@EXPORT = qw( array_any_ok array_none_ok array_once_ok array_multiple_ok 
array_max_ok array_min_ok array_maxstr_ok array_minstr_ok array_sum_ok
array_length_ok array_empty_ok );
$VERSION = sprintf "%d.%02d", q$Revision$ =~ m/ (\d+) \. (\d+) /g;

use List::Util qw(sum min max minstr maxstr);

use Test::Builder;
my $Test = Test::Builder->new();

=head1 NAME

Test::Data::Array -- test functions for array variables

=head1 SYNOPSIS

use Test::Data qw(Array);

=head1 DESCRIPTION

=head2 Functions

=over 4

=item array_any_ok( ITEM, ARRAY [, NAME] )

Ok is any element of ARRAY is ITEM.

=cut

sub array_any_ok($\@;$)
	{
	my $element = shift;
	my $array   = shift;
	my $name    = shift || 'Array contains item';
	
	foreach my $try ( @$array )
		{
		next unless $try eq $element;
		$Test->ok( 1, $name );
		return;
		}
		
	$Test->ok( 0, $name );
	}
	
=item array_none_ok( ITEM, ARRAY [, NAME] )

Ok is no element of ARRAY is ITEM.

=cut

sub array_none_ok($\@;$)
	{
	my $element = shift;
	my $array   = shift;
	my $name    = shift || 'Array does not contain item';

	foreach my $try ( @$array )
		{
		next unless $try eq $element;
		$Test->ok( 0, $name );
		return;
		}
	
	$Test->ok( 1, $name );
	}

=item array_once_ok( ITEM, ARRAY [, NAME] )

Ok is only one element of ARRAY is ITEM.

=cut

sub array_once_ok($\@;$)
	{
	my $element = shift;
	my $array   = shift;
	my $name    = shift || 'Array contains item only once';

	my %seen = ();
	foreach my $item ( @$array )
		{
		$seen{$_}++;
		}
		
	$seen{$_} = 1 ? $Test->ok( 1, $name ) : $Test->ok( 0, $name );
	}
	
=item array_multiple_ok( ITEM, ARRAY [, NAME] )

Ok if more than one element of ARRAY is ITEM.

=cut

sub array_multiple_ok($\@;$)
	{
	my $element = shift;
	my $array   = shift;
	my $name    = shift || 'Array contains item at least once';
	
	my %seen = ();
	foreach my $item ( @$array )
		{
		$seen{$_}++;
		}
		
	$seen{$_} > 1 ? $Test->ok( 1, $name ) : $Test->ok( 0, $name );
	}

=item array_max_ok( NUMBER, ARRAY [, NAME] )

Ok is all elements of ARRAY are numerically less than
or equal to NUMBER.

=cut

sub array_max_ok($\@;$)
	{
	my $item   = shift;
	my $array  = shift;
	my $name   = shift || 'Array maximum is okay';
	
	my $actual = max( @$array );
		
	$actual <= $item ? $Test->ok( 1, $name ) : $Test->ok( 0, $name );
	}

=item array_min_ok( NUMBER, ARRAY [, NAME] )

Ok is all elements of ARRAY are numerically greater than
or equal to NUMBER.

=cut

sub array_min_ok($\@;$)
	{
	my $item   = shift;
	my $array  = shift;
	my $name   = shift || 'Array minimum is okay';
	
	my $actual = min( @$array );
		
	$actual >= $item ? $Test->ok( 1, $name ) : $Test->ok( 0, $name );
	}
	
=item array_maxstr_ok( ITEM, ARRAY [, NAME] )

Ok is all elements of ARRAY are asciibetically less than
or equal to MAX.

=cut

sub array_maxstr_ok($\@;$)
	{
	my $item   = shift;
	my $array  = shift;
	my $name   = shift || 'Array maximum string is okay';
	
	my $actual = maxstr( @$array );
		
	$actual ge $item ? $Test->ok( 1, $name ) : $Test->ok( 0, $name );
	}

=item array_minstr_ok( ITEM, ARRAY [, NAME] )

Ok is all elements of ARRAY are asciibetically greater than
or equal to MAX.

=cut

sub array_minstr_ok($\@;$)
	{
	my $item   = shift;
	my $array  = shift;
	my $name   = shift || 'Array minimum string is okay';
	
	my $actual = minstr( @$array );
		
	$actual le $item ? $Test->ok( 1, $name ) : $Test->ok( 0, $name );
	}

=item array_sum_ok( SUM, ARRAY [, NAME] )

Ok is the numerical sum of ARRAY is SUM.

=cut

sub array_sum_ok($\@;$)
	{
	my $sum    = shift;
	my $array  = shift;
	my $name   = shift || 'Array sum is correct';
	
	my $actual = sum( @$array );
	
	$sum == $actual ? $Test->ok( 1, $name ) : $Test->ok( 0, $name );
	}

=item array_empty_ok( ARRAY [, NAME] )

Ok if the array contains no elements.

=cut

sub array_empty_ok(\@;$)
	{
	my $array = shift;
	my $name  = shift || 'Array is empty';
	
	$#$array == -1 ?  $Test->ok( 1, $name ) : $Test->ok( 0, $name );
	}


=item array_empty_ok( ARRAY, LENGTH [, NAME] )

Ok if the array contains LENGTH number of elements.

=cut

sub array_length_ok(\@$;$)
	{
	my $array  = shift;
	my $length = shift;
	my $name   = shift || 'Array length is correct';
	
	$#$array == $length - 1 ?  $Test->ok( 1, $name ) : $Test->ok( 0, $name );
	}
	
=back

=head1 SEE ALSO

L<Test::Data>,
L<Test::Data::Scalar>,
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

"bumble bee";
