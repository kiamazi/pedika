#!/usr/bin/perl

use warnings;
use strict;
use PostScript::Convert;
use Imager;
use PDF::API2::Lite;
use File::Path qw(make_path);
use Getopt::Long;


my %opts = (
	    direction => 'rtl'
	   );

GetOptions(
   \%opts,
	 "pdfsource|pdf=s",
	 "pdftarget|save=s",
	 "direction|dir=s",
	 "resolution|dpi=s",
	 "help|h",
  );

die if (!defined $opts{pdfsource} or ! $opts{pdfsource} =~ /.*(.pdf)$/);

if (!defined $opts{pdftarget})
{
	$opts{pdftarget} = $opts{pdfsource};
	$opts{pdftarget} =~ s:(.*/)?(.*)(.pdf)$:$2-pdima.pdf:;
}

$opts{resolution} = '150' if (!defined $opts{resolution})

my $unicpath = time();
make_path "/tmp/pdima/$unicpath/images/pages/";
my $filename = "$opts{pdfsource}";
my $output = "/tmp/pdima/$unicpath/images/pdima-%04d.png";

print "preparing pages...\n";
psconvert($filename, $output, format => 'png', resolution => "$opts{resolution}");#, resolution => '300'); sort { $a cmp $b }

my @fd=glob("/tmp/pdima/$unicpath/images/*.png");

print "crop pages...\n";

foreach my $x (@fd)
{
	if ($x =~ /(.*)(.png)$/)
	{
		my $z1 = $1;
		my $z2 = $2;
		my $name = $x;
		imagecrop ($name, $z1);
	}
}

my @fl=glob("/tmp/pdima/$unicpath/images/pages/*");
print "merge...\n";
creatpdf (@fl);
print "done...\n";



#-------------------------------------------------------#
#                       Functions                       #
#-------------------------------------------------------#

sub imagecrop
{
	my $fullname = shift;
	my $name = shift;
	$name =~ s:.*/(.*)$:$1:;
	my $image = Imager->new;
	$image->read(file => $fullname) or die $image->errstr;
	my $lefthalf = $image->crop(right=>$image->getwidth() / 2);
	my $righthalf = $image->crop(left=>$image->getwidth() / 2, right=>$image->getwidth() );


		my $rn;
		my $ln;
	if ($opts{direction} eq 'rtl')
	{
		$rn='1';
		$ln='2';
	} else
	{
		$rn='2';
		$ln='1';
	}

	my $leftname = "/tmp/pdima/$unicpath/images/pages/$name-$ln.png";
	my $rightname = "/tmp/pdima/$unicpath/images/pages/$name-$rn.png";
	$lefthalf->write(file=>$leftname) or die $lefthalf->errstr;
	$righthalf->write(file=>$rightname) or die $righthalf->errstr;
}

sub creatpdf
{
	my $pdf = PDF::API2::Lite->new;
	my @pic = @_;
	foreach my $pic (sort {$a cmp $b} @pic)
	{
		my $image = $pdf->image_png( $pic );
    		$pdf->page( $image->width, $image->height );
    		$pdf->image( $image, 0, 0 );
	}
	$pdf->saveas( $opts{pdftarget} );
}
