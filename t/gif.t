
######################### We start with some black magic to print on failure.

BEGIN { $numtests = 6 }
END {print "1..$numtests\nnot ok 1\n" unless $loaded;}

use Image::Timeline;
$loaded = 1;

if ('GD::Image'->can('gif')) {
  print "1..$numtests\n";
} else {
  print "1..0\n";
  exit 0;
}

&report_result(1);

######################### End of black magic.

my $t = new Image::Timeline(width => 600);
&report_result($t);

open DATA, 't/testdata.txt' or die "testdata.txt: $!";
while (<DATA>) {
  my @data = /(.*) \((\d+)-(\d+)\)/ or next;
  $t->add(@data);
}
&report_result(1);  # Just say we got this far.

my $i = $t->draw();
&report_result($i);

my $outfile = 't/testimage.gif';
$t->write_gif($outfile);
&report_result(-e $outfile);

# Compare files
{
  local $/;
  my $created = do {local *F; open F, $outfile;      <F>};
  my $truth   = do {local *F; open F, 't/truth.gif'; <F>};
  &report_result($created eq $truth);
}

sub report_result {
  my $bad = !shift;
  use vars qw($TEST_NUM);
  $TEST_NUM++;
  print "not "x$bad, "ok $TEST_NUM\n";
  
  print $_[0] if ($bad and $ENV{TEST_VERBOSE});
}
