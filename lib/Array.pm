package Test::Data::Array;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT);

@EXPORT = qw( array_any_ok array_none_ok array_once_ok array_multiple_ok 
array_max_ok array_min_ok array_maxstr_ok array_minstr_ok array_sum_ok );

use List::Util qw(sum min max minstr maxstr);

use Test::Builder;
my $Test = Test::Builder->new();

=head1 NAME

Test::Data::Array -- test functions for array variables

=head1 SYNOPSIS

use Test::Data::Array;


=head1 DESCRIPTION


=head2 FUNCTIONS

=over 4

=item array_any_ok( ITEM, ARRAY )

Ok is any element of ARRAY is ITEM.

=cut

sub array_any_ok($\@)
	{
	my $element = shift;
	my $array   = shift;
	
	foreach my $try ( @$array )
		{
		next unless $try eq $element;
		$Test->ok(1);
		return;
		}
		
	$Test->ok(0);
	}
	
=item array_none_ok( ITEM, ARRAY )

Ok is no element of ARRAY is ITEM.

=cut

sub array_none_ok($\@)
	{
	my $element = shift;
	my $array   = shift;

	foreach my $try ( @$array )
		{
		next unless $try eq $element;
		$Test->ok(0);
		return;
		}
	
	$Test->ok(1);
	}

=item array_once_ok( ITEM, ARRAY )

Ok is only one element of ARRAY is ITEM.

=cut

sub array_once_ok($\@)
	{
	my $element = shift;
	my $array   = shift;

	my %seen = ();
	foreach my $item ( @$array )
		{
		$seen{$_}++;
		}
		
	$seen{$_} = 1 ? $Test->ok(1) : $Test->ok(0);
	}
	
=item array_multiple_ok( ITEM, ARRAY )

Ok if more than one element of ARRAY is ITEM.

=cut

sub array_multiple_ok($\@)
	{
	my $element = shift;
	my $array   = shift;
	
	my %seen = ();
	foreach my $item ( @$array )
		{
		$seen{$_}++;
		}
		
	$seen{$_} > 1 ? $Test->ok(1) : $Test->ok(0);
	}

=item array_max_ok( NUMBER, ARRAY )

Ok is all elements of ARRAY are numerically less than
or equal to NUMBER.

=cut

sub array_max_ok($\@)
	{
	my $item   = shift;
	my $array  = shift;
	
	my $actual = max( @$array );
		
	$actual <= $item ? $Test->ok(1) : $Test->ok(0);
	}

=item array_min_ok( NUMBER, ARRAY )

Ok is all elements of ARRAY are numerically greater than
or equal to NUMBER.

=cut

sub array_min_ok($\@)
	{
	my $item   = shift;
	my $array  = shift;
	
	my $actual = min( @$array );
		
	$actual >= $item ? $Test->ok(1) : $Test->ok(0);
	}
	
=item array_maxstr_ok( ITEM, ARRAY )

Ok is all elements of ARRAY are asciibetically less than
or equal to MAX.

=cut

sub array_maxstr_ok($\@)
	{
	my $item   = shift;
	my $array  = shift;
	
	my $actual = maxstr( @$array );
		
	$actual ge $item ? $Test->ok(1) : $Test->ok(0);
	}

=item array_minstr_ok( ITEM, ARRAY )

Ok is all elements of ARRAY are asciibetically greater than
or equal to MAX.

=cut

sub array_minstr_ok($\@)
	{
	my $item   = shift;
	my $array  = shift;
	
	my $actual = minstr( @$array );
		
	$actual le $item ? $Test->ok(1) : $Test->ok(0);
	}

=item array_sum_ok( SUM, ARRAY )

Ok is the numerical sum of ARRAY is SUM.

=cut

sub array_sum_ok($\@)
	{
	my $sum    = shift;
	my $array  = shift;
	
	my $actual = sum( @$array );
	
	$sum == $actual ? $Test->ok(1) : $Test->ok(0);
	}
	
=back

=head1 SEE ALSO

L<Test::Data>,
L<Test::Data::Scalar>,
L<Test::Data::Hash>, 
L<Test::Builder>

=head1 AUTHOR

brian d foy, E<lt>bdfoy@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2002, brian d foy, All Rights Reserved

You may use, modify, and distribute this under the same terms
as Perl itself.

=cut

"bumble bee";
