# $Id$

use Test::More tests => 11;

require Test::Data;

Test::Data->import( qw(Scalar Array Hash Function) );

# Scalar
ok( defined &number_ok,      "Scalar package exported number_ok"      );

# Array
ok( defined &is_any_ok,      "Array package exported is_any_ok"       );
ok( defined &is_none_ok,     "Array package exported is_none_ok"      );
ok( defined &is_once_ok,     "Array package exported is_once_ok"      );
ok( defined &is_multiple_ok, "Array package exported is_multiple_ok"  );
ok( defined &is_maximum_ok,  "Array package exported is_maximum_ok"   );
ok( defined &is_minimum_ok,  "Array package exported is_minimum_ok"   );

# Hashes
ok( defined &exists_ok,      "Hash package exported exists_ok"        );
ok( defined &defined_ok,     "Hash package exported defined_ok"       );
ok( defined &hash_value_true_ok,     "Hash package exported defined_ok"       );

# Functions
ok( defined &prototype_ok,   "Function package exported prototype_ok" );

