# $Id$

use Test::Builder::Tester tests => 3;
use Test::More;
use Test::Data qw(Array);

#use Carp;
#$SIG{__WARN__} = \&confess;

TEST_ARRAY_FUNCS: {
my @array = 4..6;
my @empty = ();

test_err();

array_any_ok(  5, @array );
test_out( "ok 1 - Array contains item" );

array_any_ok(  9, @array );
test_out( "not ok 2 - Array contains item" );

array_once_ok( 5, @array );
array_none_ok( 7, @array );
array_sum_ok( 15, @array );
array_max_ok(  6, @array );
array_min_ok(  3, @array );
array_empty_ok( @empty );
array_length_ok( @array, 3 );
test_out( 
    "ok 3 - Array contains item only once",
    "ok 4 - Array does not contain item",
    "ok 5 - Array sum is correct",
    "ok 6 - Array maximum is okay",
    "ok 7 - Array minimum is okay",
    "ok 8 - Array is empty",
    "ok 9 - Array length is correct",
);

test_err( "#     Failed test ($0 at line 19)" );
test_test('Array functions work');
}

TEST_STR_SORTS: {
my @array   = 'a' .. 'f';
my @reverse = reverse @array;

test_err();

array_sortedstr_ascending_ok( @array );
array_sortedstr_descending_ok( @reverse );

test_out(
	"ok 1 - Array is in ascending order",
	"ok 2 - Array is in descending order",
	);

array_sortedstr_ascending_ok( @reverse );
array_sortedstr_descending_ok( @array );
test_out(
	'not ok 3 - Array is in ascending order',
	'not ok 4 - Array is in descending order',
	);
test_err(
	'#     Failed test (t/array.t at line 57)',
	'#     Failed test (t/array.t at line 58)',
	);

my @bad = ( 'a' .. 'f', 'b' );
my @bad_reverse = reverse @bad;

array_sortedstr_ascending_ok( @bad );
array_sortedstr_descending_ok( @bad_reverse );
test_out(
	'not ok 5 - Array is in ascending order',
	'not ok 6 - Array is in descending order',
	);
test_err(
	'#     Failed test (t/array.t at line 71)',
	'#     Failed test (t/array.t at line 72)',
	);

test_test('Sort comparisons work');
}

TEST_NUM_SORTS: {
my @array   = 1 .. 5;
my @reverse = reverse @array;

test_err();

array_sorted_ascending_ok( @array );
array_sorted_descending_ok( @reverse );

test_out(
	"ok 1 - Array is in ascending order",
	"ok 2 - Array is in descending order",
	);

array_sorted_ascending_ok( @reverse );
array_sorted_descending_ok( @array );
test_out(
	'not ok 3 - Array is in ascending order',
	'not ok 4 - Array is in descending order',
	);
test_err(
	'#     Failed test (t/array.t at line 99)',
	'#     Failed test (t/array.t at line 100)',
	);

my @bad = ( 1 .. 5, 3 );
my @bad_reverse = reverse @bad;

array_sorted_ascending_ok( @bad );
array_sorted_descending_ok( @bad_reverse );
test_out(
	'not ok 5 - Array is in ascending order',
	'not ok 6 - Array is in descending order',
	);
test_err(
	'#     Failed test (t/array.t at line 113)',
	'#     Failed test (t/array.t at line 114)',
	);

test_test('Sort comparisons work');
}