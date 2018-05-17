#!perl -w
use strict;

my %ids;
open ID, "new_unique_strain.list" or die;
while (<ID>) {
    chomp;
	$ids{$_} = "1";
}
close ID;

open OUT, ">>add_database.table" or die;
open IN, "Bt_table_20130609_new.table" or die;
while (<IN>) {
    chomp;
	my $line = $_;
    if (/^\-/)  {
	    print OUT $_ . "\n";
	} else {
	    my @tmps = split /\t/, $_;
		if ($ids{$tmps[0]}) {
		    print OUT $line . "\n";
		}
	}
}
close IN;
close OUT;