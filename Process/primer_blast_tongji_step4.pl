#! /usr/bin/perl
use strict;
#Date     : 2014.10.31  13:52
#Author   : liaochenlanruo
#Function : formation a table of the primer"
my %hash;
my %str;
my %gene;
my @tongji = glob("*.tongji");
foreach (@tongji){
     my $in = $_;
     if (/(\d*[a-zA-Z]+\d+)/){
        my $str = $1;
        $str{$1} = "1";
        open IN, "$in" or die "Can't open IN file\n";
        while (<IN>){
             chomp;
             if (/(\S+)_(\+)/){
                $hash{$str}{$1} = $2;
                $gene{$1} = "1";
              }
         } 
         close IN;
       }
}

my @str = keys %str;
my @gene = keys %gene;
open OUT, ">>primer_table.txt" or die "Can't open OUT file\n";
print OUT "-";
foreach (@gene){
    print OUT "\t" . $_;
}
print OUT "\n";
for (my $i = 0; $i<@str; $i++){
    print OUT $str[$i];
    for (my $j = 0; $j<@gene; $j++){
    if (exists $hash{$str[$i]}{$gene[$j]}){
      print OUT "\t" . $hash{$str[$i]}{$gene[$j]};
      } else{
         print OUT "\t" . "-";
         }
    }
    print OUT "\n";
}
close OUT;
