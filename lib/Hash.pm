package Test::Data::Hash;
# $Id$
use strict;

use base qw(Exporter);
use vars qw(@EXPORT);

@EXPORT = qw(exists_ok hash_value_defined_ok hash_value_true_ok);

my $Test = Test::Builder->new();
	
=head1 NAME

Test::Data::Hash -- test functions for hash variables

=head1 SYNOPSIS

use Test::Data qw(Hash);


=head1 DESCRIPTION

This modules provides a collection of test utilities for
hash variables.  Load the module through Test::Data.

=head2 FUNCTIONS


=over 4

=item exists_ok( KEY, HASH )

Ok is the value for KEY in HASH is true.  The function
does not create KEY in HASH.

=cut

sub exists_ok($\%)
	{
	my $key  = shift;
	my $hash = shift;
	
	$Test->ok( exists $hash->{$key} );
	}

=item hash_value_defined_ok( KEY, HASH )

Ok is the value for KEY in HASH is true.  The function
does not create KEY in HASH.

=cut

sub hash_value_defined_ok($\%)
	{
	my $key  = shift;
	my $hash = shift;
	
	$Test->ok( defined $hash->{$key} );
	}


=item hash_value_true_ok( KEY, HASH )

Ok is the value for KEY in HASH is true.  The function
does not create KEY in HASH.

=cut

sub hash_value_true_ok($\%)
	{
	my $key  = shift;
	my $hash = shift;
	
	$Test->ok( $hash->{$key} );
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
