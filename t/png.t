
use strict;
use Image::Timeline;
use Test::More;
use lib qw(t);
require "common.pl";

if ('GD::Image'->can('png')) {
  plan tests => 6;
} else {
  print "1..0\n";
  exit 0;
}

ok 1;

######################### End of black magic.

my $t = &new_with_data('t/testdata.txt');
ok 1;  # Just say we got this far.
ok $t;

my $i = $t->draw();
ok $i;

write_and_compare($t, 't/testimage', 't/truth', 'png');
