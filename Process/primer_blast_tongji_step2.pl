#!/usr/bin/perl
use strict;
use warnings;

my @blast = glob("*.tongji_1");
foreach  (@blast) {
	if (/(\d*[a-zA-Z]+\d+)/) {
		my $name = $1;
		my $out = $name . ".tongji_2";
		open IN , "$_" or die "Open IN Failed\n";
		open OUT ,">>$out" or die "Can't open OUT file\n";
		while (<IN>) {
			chomp;
			if (/(p\d+_(?:F|R))\S+?(\d+)\S+\s+(\d+)/) {
                #my $id = $1;
				#my $leng1 = $2;
				#my $leng2 = $3;
				if ($2 == $3) {
				print OUT $1 . "\n";

				}
			}

	    }
	}
}
close IN;
close OUT;
