use ExtUtils::MakeMaker;

WriteMakefile(
	      'NAME'		=> 'Image::Timeline',
	      'VERSION_FROM'	=> 'Timeline.pm', # finds $VERSION
	      'PREREQ_PM'	=> {GD => 0},
	      'clean'           => {FILES => "t/testimage*"},
);
