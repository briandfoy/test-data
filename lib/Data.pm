# $Id$
package Test::Data;
use strict;

use vars qw($VERSION);

use Carp qw(carp);

use Test::Builder;

my $Test = Test::Builder->new();
$VERSION = 0.7;

=head1 NAME

Test::Data -- test functions for particular variable types

=head1 SYNOPSIS

use Test::Data qw(Scalar Array Hash Function);

=head1 DESCRIPTION

Test::Data provides utility functions to check properties 
and values of data and variables.

=cut

$Exporter::Verbose = 0;

sub import
	{
    my $self   = shift;
    my $caller = caller;

	foreach my $package ( @_ )
		{
		my $full_package = "Test::Data::$package";
		eval{ eval "require $full_package" };
		if( $@ )
			{
			carp "Could not require Test::Data::$package: $@";
			}
			
		$full_package->export($caller);
		}
		
	}
	
sub VERSION { return $VERSION }

=head2 FUNCTIONS

Plug-in modules define functions for each data type.  See the
appropriate module.

=head1 SEE ALSO

L<Test::Data::Scalar>,
L<Test::Data::Array>,
L<Test::Data::Hash>, 
L<Test::Data::Function>, 
L<Test::Builder>

=head1 AUTHOR

brian d foy, E<lt>bdfoy@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2002, brian d foy, All Rights Reserved

You may use, modify, and distribute this under the same terms
as Perl itself.

=cut

"Now is the time for all good men to come to the aid of their country";
