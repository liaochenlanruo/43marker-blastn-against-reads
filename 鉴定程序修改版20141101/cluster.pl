#!perl -w
use strict;

open DIS, "Bt_table_20130609_identity.distance" or die;
open OUT, ">>Bt_20130609_identity.table" or die;
my %hash;
while (<DIS>) {
    chomp;
    my @tmps = split /\t/, $_;
    $hash{$tmps[0]} = "1";
    $hash{$tmps[1]} = "1";	
}
close DIS;

open TOT, ">>Bt_total_unique.list" or die;
my %total;
my %name;
my @hash = keys %hash;
foreach (@hash) {
    my $hash = $_;
    unless (exists $name{$hash}) {
	    print TOT $hash . "\n";
		$total{$hash} = "1";
	    my %line;
		$line{$hash} = "1";
		$name{$hash} = "1";
	    open IN, "Bt_table_20130609_identity.distance" or die;
		while (<IN>) {
		    chomp;
		    my @tmps = split /\t/, $_;
			if (exists $line{$tmps[0]}) {
				$line {$tmps[1]} = "1";
				$name{$tmps[1]} = "1";
			} elsif (exists $line{$tmps[1]}) {
			    $line {$tmps[0]} = "1";
				$name{$tmps[0]} = "1";
			}	
		}
		close IN;
		my @out = sort keys %line;
		foreach (@out) {
		    print OUT $_ . "\t";
		}
		print OUT "\n";
	}	
}
close OUT;

open LIST, "Bt_table_20130609.list" or die;
open DIFF, ">>Bt_diff.list" or die;

while (<LIST>) {
    chomp;
	unless (exists $name{$_}) {
	    print DIFF $_ . "\n";
		print TOT $_ . "\n";
		$total{$_} = "1";
	}
}
close DIFF;
close LIST;
close TOT;

open TAB, "Bt_table_20130609.table" or die;
open NEW, ">>Bt_table_20130609_new.table" or die;
while (<TAB>) {
    chomp;
	my $line = $_;
	my @tmps = split /\t/, $_;
	if ($tmps[0] eq "-") {
	    print NEW $line . "\n";
	}
	if (exists $total{$tmps[0]}) {
	    print NEW $line . "\n";
	}
}
close TAB;
close NEW;