#! /usr/bin/perl -w
use strict;

#Date     : 2014.10.29
#Author   : zhengjinshui&liaochenlanruo
#Function : blastn against 43 primers for reads of sequence to analysis how many strains are really different.
#System   £ºwindows
my @fq = glob("*.fastq");
foreach (@fq) {
    my $name = substr($_, 0, (length($_) - 6));
	my $fa = $name . ".fa";
	open IN, "$_" or die;
	open OUT, ">>$fa" or die;
	my $line = 1;
	while (<IN>) {
	    chomp;
	    my $num = $line % 4;
		if ($num == 1) {
		    print OUT ">" . $_ . "\n";
		} elsif ($num == 2) {
		    print OUT $_ . "\n";
		}
		$line++;
	}
}

my @fa = glob("*.fa");
foreach my $fa (@fa) {
    my $name = substr($fa, 0, (length($fa) - 3));
	my $out = $name . ".blast";
	system("makeblastdb -in $fa -out $name -dbtype nucl");
	system("blastn -query 44primers.txt -db $name -outfmt 6 -out $out -evalue 10 -word_size 7 -perc_identity 90.00 -max_target_seqs 2 -num_threads 2");
	system("del/f/s/q *.nhr *.nin *.nsq *.fastq");
}
