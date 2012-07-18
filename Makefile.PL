use ExtUtils::MakeMaker;

require 5.006;

eval "use Test::Manifest 1.14";

WriteMakefile (
	'NAME'          => 'Test::Data',
	'ABSTRACT'      => 'Check data type properties and values',
	'VERSION_FROM'  => 'lib/Test/Data.pm',
	'LICENSE'		=> 'perl',
	'AUTHOR'		=> 'brian d foy <bdfoy@cpan.org>',
        
	'PREREQ_PM' => {
		'List::Util'            => '0',
		'Scalar::Util'          => '0',
		'Test::Builder'         => '0',
		'Test::Builder::Tester' => '0',
		'Test::More'            => '0',
		},
	
	clean  => { FILES => 'Test-Data-*' },
	);

