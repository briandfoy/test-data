# $Id$

use Test::Builder::Tester tests => 1;
use Test::More;
use Test::Data qw(Array);

{
test_out( map "ok $_", 1 .. 8 );
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
test_test();
}
