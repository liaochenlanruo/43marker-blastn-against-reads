#!/usr/bin/perl
use strict;
use warnings;


my @blast = glob("*.blast");
foreach  (@blast) {
	if (/(\d*[a-zA-Z]+\d+)/) {
		my $name = $1;
		my $out = $name . ".tongji_1";
		open IN , "$_" or die "Open IN Failed\n";
		open OUT ,">>$out" or die "Can't open OUT file\n";
        while (<IN>) {
            print OUT join "\t",(split)[0,7],"\n";
        }
    }
}
close IN;
close OUT;