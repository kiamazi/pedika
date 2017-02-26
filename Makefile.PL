use strict;
use warnings;
use utf8;

use 5.012;

use ExtUtils::MakeMaker;
use File::ShareDir::Install;

install_share dist => 'share';


WriteMakefile
(
  NAME             => 'pedika',
  AUTHOR           => 'Kiavash',
  VERSION_FROM     => 'script/pedika.pl',
  ABSTRACT         => 'pdf cutter',
  LICENSE          => 'gpl_3',
  EXE_FILES        => [
      "script/pedika"
  ],
  MIN_PERL_VERSION => 5.012,
  CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker'       => 0,
  },
  PREREQ_PM => {
	`PostScript::Convert` 	=> 0,
	`Imager` 		=> 0,
	`PDF::API2::Lite`	=> 0,
	`File::Path`		=> 0,
	`Getopt::Long` 		=> 0,
	`File::Temp` 		=> 0,
	`File::Spec` 		=> 0,
	`File::Spec::Functions` => 0,
},
  dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
  META_MERGE => {
    'meta-spec' => { version => 2 },
    resources => {
      repository => {
          type => 'git',
          url  => 'https://github.com/kiamazi/pedika.git',
          web  => 'https://github.com/kiamazi/pedika',
      },
    },
  },
);



1;
