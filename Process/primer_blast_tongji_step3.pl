#!/usr/bin/perl
use strict;
use warnings;

my %h;
my @tongji_2 = glob("*.tongji_2");
foreach  (@tongji_2) {
	if (/(\d*[a-zA-Z]+\d+)/) {
		my $name = $1;
		my $out = $name . ".tongji_3";
		open IN , "$_" or die "Open IN Failed\n";
		open OUT ,">>$out" or die "Can't open OUT file\n";
        while (<IN>){
             if (/(\w+)_([RF])/){
                if ($2 eq 'R'){$h{$1} |= 1;}
                if ($2 eq 'F'){$h{$1} |= 2;}
                if ($h{$1} == 3){
             print OUT $1 ."\n";
             $h{$1} = 5;
                }
             }
       }
	}
}
close IN;
close OUT;
