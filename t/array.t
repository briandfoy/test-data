# $Id$

use Test::Builder::Tester tests => 1;
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
