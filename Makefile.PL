require 5.008;
use strict;
use warnings;

my $github    = 'https://github.com/briandfoy/';
my $main_file = 'lib/Test/Data.pm';

my %WriteMakefile = (
	'NAME'          => 'Test::Data',
	'ABSTRACT_FROM' => $main_file,
	'VERSION_FROM'  => $main_file,
	'LICENSE'		=> 'perl',
	'AUTHOR'		=> 'brian d foy <bdfoy@cpan.org>',
        
	'PREREQ_PM' => {
		'List::Util'            => '0',
		'Scalar::Util'          => '0',
		'Test::Builder'         => '0',
		'Test::Builder::Tester' => '0',
		'Test::More'            => '0.95',
		},

	META_MERGE => {
		resources => {
			repository => 'https://github.com/briandfoy/test-data',
			}
		},
	
	clean  => { FILES => 'Test-Data-*' },
	);


sub arguments { \%WriteMakefile }

do_it() unless caller;
sub do_it {
	require File::Spec;
	my $MM ='ExtUtils::MakeMaker';
	my $MM_version =
		eval{ "$MM " . $WriteMakefile{'CONFIGURE_REQUIRES'}{'ExtUtils::MakeMaker'} }
			//
		"$MM 6.64";
	eval "use $MM_version" || die "Could not load $MM_version: $@";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
