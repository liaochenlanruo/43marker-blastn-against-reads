#! /usr/bin/perl
use strict;
#Date     : 2014.10.31 14:01
#Author   : liaochenlanruo
#Function : statistics primer p30 and p31

my @blast2 = glob("*.blast");
foreach  (@blast2) {
	if (/(\d*[a-zA-Z]+\d+)/) {
		my $name = $1;
		open IN , "$_" or die "Open IN Failed\n";
		open OUT ,">>p30_p31.txt" or die "Can't open OUT file\n";
        while (<IN>) {
			chomp;
			if (/(p30)|(p31)/) {
			   print OUT $name . "\t" . $_ . "\n";
			}
        }
    }
}
close IN;
close OUT;