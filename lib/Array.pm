package Test::Data::Array;
use strict;

use base qw(Exporter);
use vars qw(@EXPORT);

@EXPORT = qw(is_any_ok is_none_ok is_once_ok is_multiple_ok 
	is_maximum_ok is_minimum_ok);

use Test::Builder;
my $Test = Test::Builder->new();

=head1 NAME

Test::Data::Array -- test functions for array variables

=head1 SYNOPSIS

use Test::Data::Array;


=head1 DESCRIPTION


=head2 FUNCTIONS


=over 4

=item is_any_ok( ITEM, ARRAY )


=cut

sub is_any_ok($\@)
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
	
=item is_none_ok( ITEM, ARRAY )


=cut

sub is_none_ok($\@)
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

=item is_once_ok( ITEM, ARRAY )


=cut

sub is_once_ok($\@)
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
	
=item is_multiple_ok( ITEM, ARRAY )


=cut

sub is_multiple_ok($\@)
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

=item is_maximum_ok( ITEM, ARRAY )


=cut

sub is_maximum_ok($\@)
	{
	my $element = shift;
	my $array   = shift;
	
	my $max = $array->[0];
	foreach my $item ( @$array[1..$#$array] )
		{
		$max = $item if $item > $max;
		}
		
	$max == $element ? $Test->ok(1) : $Test->ok(0);
	}

=item is_minimum_ok( ITEM, ARRAY )


=cut

sub is_minimum_ok($\@)
	{
	my $element = shift;
	my $array   = shift;
	
	my $min = $array->[0];
	foreach my $item ( @$array[1..$#$array] )
		{
		$min = $item if $item < $min;
		}
		
	$min == $element ? $Test->ok(1) : $Test->ok(0);
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
