#!/usr/bin/perl
use strict;
use warnings;
#Date     : 2014.10.31 14:03  Modificationed 2014.11.01 08:38
#Author   : liaochenlanruo
#Function : statistics 43 primers for reads of sequence to the table.

#------------extract two columns(ids and primer_blast length)-------------------------
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

#-------------extract the equal length primers(primer length  with primer_blast length)-------------------
my @tongji_1 = glob("*.tongji_1");
foreach  (@tongji_1) {
	if (/(\d*[a-zA-Z]+\d+)/) {
		my $name = $1;
		my $out = $name . ".tongji_2";
		open IN , "$_" or die "Open IN Failed\n";
		open OUT ,">>$out" or die "Can't open OUT file\n";
		while (<IN>) {
			chomp;
			if (/(p\d+_(?:F|R))\S+?(\d+)\S+\s+(\d+)/) {
				if ($2 == $3) {
				print OUT $1 . "\n";
				}
			}

	    }
	}
}
close IN;
close OUT;
system("del/f/s/q *.tongji_1");


#--------------extract the final primer with both F and R-----------------------------
#my %h;
my @tongji_2 = glob("*.tongji_2");
foreach  (@tongji_2) {
	if (/(\d*[a-zA-Z]+\d+)/) {
		my $name = $1;
		my $out = $name . ".tongji";
		open IN , "$_" or die "Open IN Failed\n";
		my %h;
		open OUT ,">>$out" or die "Can't open OUT file\n";
        while (<IN>){
             if (/(\w+)_([RF])/){
                if ($2 eq 'R'){$h{$1} |= 1;}#“|=”表示或者
                if ($2 eq 'F'){$h{$1} |= 2;}
                if ($h{$1} == 3){
             print OUT $1 ."_+\n";
             $h{$1} = 5;#随便写的避免重复写入
                }
             }
       }
	}
}
close IN;
close OUT;
system("del/f/s/q *.tongji_2");


#---------------------primer to table---------------------------
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

#--------------------statistics primer p30 and p31-----------------------------------
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