local $^W = 0;
use Test::More;
eval "use Test::Prereq 0.51";
plan skip_all => "Test::Prereq required to test dependencies" if $@;
prereq_ok();
