# $Id$

use Test::Builder::Tester tests => 1;
use Test::More;
use Test::Data qw(Array);

{
test_out( 
"ok 1 - Array contains item",
"ok 2 - Array contains item only once",
"ok 3 - Array does not contain item",
"ok 4 - Array sum is correct",
"ok 5 - Array maximum is okay",
"ok 6 - Array minimum is okay",
"ok 7 - Array is empty",
"ok 8 - Array length is correct",
 );
my @array = 4..6;
my @empty = ();
array_any_ok(  5, @array );
array_once_ok( 5, @array );
array_none_ok( 7, @array );
array_sum_ok( 15, @array );
array_max_ok(  6, @array );
array_min_ok(  3, @array );
array_empty_ok( @empty );
array_length_ok( @array, 3 );
test_test('Array functions work');
}
