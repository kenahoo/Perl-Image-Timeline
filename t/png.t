
######################### We start with some black magic to print on failure.

END {print "1..1\nnot ok 1\n" unless $loaded;}

use Image::Timeline;
require "t/common.pl";
$loaded = 1;

if ('GD::Image'->can('png')) {
  print "1..6\n";
} else {
  print "1..0\n";
  exit 0;
}

&report_result(1);

######################### End of black magic.

my $t = &new_with_data('t/testdata.txt');
&report_result(1);  # Just say we got this far.
&report_result($t);

my $i = $t->draw();
&report_result($i);

my ($exists, $same) = &write_and_compare($t, 't/testimage', 't/truth');
&report_result($exists);
&report_result($same);
