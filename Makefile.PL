# $Id$
use ExtUtils::MakeMaker;

sub ExtUtils::MM_Any::test_via_harness
	   {
	   my($self, $perl, $tests) = @_;

	   return qq|\t$perl "-MTest::Manifest" | .
				  qq|"-e" "run_t_manifest(\$(TEST_VERBOSE), '\$(INST_LIB)', | .
				  qq|'\$(INST_ARCHLIB)')"\n|;
	   }

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
 			'Test::Manifest'        => '0.9',
  			'Test::More'            => '0',
			'Test::Pod'             => '0',
 			'Test::Prereq'          => '0.14',
 			},
 			
        'PM'        => 
        	{
            'lib/Data.pm'     => '$(INST_LIBDIR)/Data.pm',
            'lib/Scalar.pm'   => '$(INST_LIBDIR)/Data/Scalar.pm',
            'lib/Array.pm'    => '$(INST_LIBDIR)/Data/Array.pm',
            'lib/Hash.pm'     => '$(INST_LIBDIR)/Data/Hash.pm',
            'lib/Function.pm' => '$(INST_LIBDIR)/Data/Function.pm',
          },
 
         'MAN3PODS' =>
        	{
        	'lib/Data.pm'    => '$(INST_MAN3DIR)/Test::Data.3',
        	'lib/Scalar.pm'  => '$(INST_MAN3DIR)/Test::Data::Scalar.3',
        	'lib/Array.pm'   => '$(INST_MAN3DIR)/Test::Data::Array.3',
        	'lib/Hash.pm'    => '$(INST_MAN3DIR)/Test::Data::Hash.3',
         	'lib/Function.pm' => '$(INST_MAN3DIR)/Test::Data::Function.3',
       	},

		clean  => { FILES => 'Test-Data-*' },
        );

