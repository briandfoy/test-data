# $Id$
use ExtUtils::MakeMaker;

use Test::Manifest qw(get_t_files);

WriteMakefile
        (
        'NAME'      => 'Test::Data',
        'ABSTRACT'  => 'Check data type properties and values',
        'VERSION'   => '0.5_04',
 		'PREREQ_PM' => {
 			'Test::Pod'             => 0,
 			'Test::Manifest'        => 0,
 			'Test::Builder'         => 0,
 			'Test::More'            => 0,
 			'Test::Builder::Tester' => 0,
 			},
        'PM'        => 
        	{
            'lib/Data.pm'     => '$(INST_LIBDIR)/Data.pm',
            'lib/Scalar.pm'   => '$(INST_LIBDIR)/Data/Scalar.pm',
            'lib/Array.pm'    => '$(INST_LIBDIR)/Data/Array.pm',
            'lib/Hash.pm'     => '$(INST_LIBDIR)/Data/Hash.pm',
            'lib/Function.pm' => '$(INST_LIBDIR)/Data/Function.pm',
          },
 
 		depend => { Makefile => 't/test_manifest' },
        test   => { TESTS => scalar get_t_files() },
        );

