# $Id$
use ExtUtils::MakeMaker;

my $tests = do {
	local @ARGV = qw(t/test_manifest);
	my $data = join " ", map {chomp; "t/$_" } <>;
	};

WriteMakefile
        (
        'NAME'           => 'Test::Data',
        'ABSTRACT'       => 'Check data type properties and values',
        'VERSION_FROM'   => 'lib/Data.pm',
        
 		'PREREQ_PM' => {
 			'File::Find::Rule'      => '0',
 			'List::Util'            => '0',
 			'Scalar::Util'          => '0',
 			'Test::Builder'         => '0',
 			'Test::Builder::Tester' => '0',
  			'Test::More'            => '0',
			'Test::Pod'             => '0',
 			'Test::Prereq'          => '0',
 			},
 			
        'PM'        => 
        	{
            'lib/Data.pm'     => '$(INST_LIBDIR)/Data.pm',
            'lib/Scalar.pm'   => '$(INST_LIBDIR)/Data/Scalar.pm',
            'lib/Array.pm'    => '$(INST_LIBDIR)/Data/Array.pm',
            'lib/Hash.pm'     => '$(INST_LIBDIR)/Data/Hash.pm',
            'lib/Function.pm' => '$(INST_LIBDIR)/Data/Function.pm',
          },
 
		test   => { TESTS      => $tests },
		depend => { 'Makefile' => 't/test_manifest' },
        );

