# $Id$
use ExtUtils::MakeMaker;

WriteMakefile (
        'NAME'           => 'Test::Data',
        'ABSTRACT'       => 'Check data type properties and values',
        'VERSION_FROM'   => 'lib/Data.pm',
        
	'PREREQ_PM' => {
		'List::Util'            => '0',
		'Scalar::Util'          => '0',
		'Test::Builder'         => '0',
		'Test::Builder::Tester' => '0',
		'Test::More'            => '0',
		'File::Spec'		=> '0',
		'File::Find'		=> '0',
		'base'			=> '0',
	},
 			
        'PM' => {
		'lib/Data.pm'     => '$(INST_LIBDIR)/Data.pm',
		'lib/Scalar.pm'   => '$(INST_LIBDIR)/Data/Scalar.pm',
		'lib/Array.pm'    => '$(INST_LIBDIR)/Data/Array.pm',
		'lib/Hash.pm'     => '$(INST_LIBDIR)/Data/Hash.pm',
		'lib/Function.pm' => '$(INST_LIBDIR)/Data/Function.pm',
        },
 
        'MAN3PODS' => {
        	'lib/Data.pm'    => '$(INST_MAN3DIR)/Test::Data.3',
        	'lib/Scalar.pm'  => '$(INST_MAN3DIR)/Test::Data::Scalar.3',
        	'lib/Array.pm'   => '$(INST_MAN3DIR)/Test::Data::Array.3',
        	'lib/Hash.pm'    => '$(INST_MAN3DIR)/Test::Data::Hash.3',
         	'lib/Function.pm' => '$(INST_MAN3DIR)/Test::Data::Function.3',
       	},

	clean  => { FILES => 'Test-Data-*' },
);

