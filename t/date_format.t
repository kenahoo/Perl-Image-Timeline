
######################### We start with some black magic to print on failure.

END {print "1..1\nnot ok 1\n" unless $loaded;}

$| = 1;
use Image::Timeline;
require "t/common.pl";
$loaded = 1;

print "1..5\n";

&report_result(1);

######################### End of black magic.

my $t = new Image::Timeline(width => 600,
			    date_format => '%Y-%m-%d',
			    bar_stepsize => '40%',
			   );
&report_result($t);

while (<DATA>) {
  my @data = /(.*) \((\d+)-(\d+)\)/ or next;
  $t->add(@data);
}
&report_result(1);  # Just say we got this far.

&report_result($t->draw());

&report_result( &write_and_compare($t, 't/testimage_format', 't/truth_format') );

__DATA__
PersonA (306764700-946684800)
PersonB (300000000-876954321)
PersonC (946684800-1262304000)
