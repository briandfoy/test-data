# $Id$

use Test::Builder::Tester tests => noplan;
use Test::More;
use Test::Data qw(Scalar);


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
foreach my $value ( [], {} )
	{
	my $object = bless $value;
	test_out('ok 1');
	blessed_ok( $object );
	test_test('blessed_ok');
	}

foreach my $value ( [], {}, "Hello", undef, '', 1, 0 )
	{
	my $ref = ref $value;
	
	test_out('not ok 1');
	test_diag("    Failed test ($0 at line " . line_num(+3) . ")",
		"Expected a blessed value, but didn't get it",
		qq|\tReference type is "$ref"| );
	blessed_ok( $value );
	test_test('blessed_ok catches non-reference');
	}
	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
test_out('ok 1');
defined_ok( "defined" );
test_test('defined_ok');

test_out('not ok 1');
test_diag("    Failed test ($0 at line " . line_num(+2) . ")",
	"Expected a defined value, got an undefined one");
defined_ok( undef );
test_test('defined_ok catches undef');

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
foreach my $pair ( ( [2,1], [4,2], [0,-1], [-1,-2] ) )
	{
	test_out('ok 1');
	greater_than( @$pair );
	test_test('greater_than');
	
	test_out('not ok 1');
	test_diag(
		"    Failed test ($0 at line " . line_num(+5) . ")",
		"Number is greater than the bound.",
		"\tExpected a number less than [$$pair[1]]",
		"\tGot [$$pair[0]]"); 
	less_than( @$pair );
	test_test('less than catches out-of-bonds');
	
	test_out('ok 1');
	less_than( reverse @$pair );
	test_test('less_than');

	test_out('not ok 1');
	test_diag(
	    "    Failed test ($0 at line " . line_num(+5) . ")",
		"Number is less than the bound.",
		"\tExpected a number greater than [$$pair[0]]",
		"\tGot [$$pair[1]]"); 
	greater_than( reverse @$pair );
	test_test('greater_than catches out-of-bonds');
	}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
foreach my $string ( ( '', '123', ' ', 'Roscoe' ) )
	{
	my $length = length $string;
	test_out( map { "ok $_" } 1 .. 6 );
	length_ok( $string, $length );
	maxlength_ok( $string, $length );
	maxlength_ok( $string, $length + 1 );
	minlength_ok( $string, $length );
	minlength_ok( $string, $length - 1 );
	minlength_ok( $string, 0 );
	test_test('length_ok, maxlength_ok, minlength_ok');
	
	foreach my $bad ( $length - 1, $length + 1, -1, 0 )
		{
		next if $bad == $length;
		
		test_out('not ok 1');
		test_diag(
			"    Failed test ($0 at line " . line_num(+5) . ")",
			"Length of value not within bounds",
			"\tExpected length=[$bad]",
			"\tGot [$length]"); 
		length_ok( $string, $bad );
		test_test('length_ok catches errors');
		}

	}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
test_out( map { "ok $_" } 1 .. 4 );
foreach my $value ( ( {}, [] ) )
	{
	ref_ok( $value );
	strong_ok( $value );
	}
test_test('ref_ok, strong_ok');

