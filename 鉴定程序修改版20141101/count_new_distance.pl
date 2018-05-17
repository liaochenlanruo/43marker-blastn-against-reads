#!/usr/bin/perl -w

#Read in database
my @ptype;
my %str;
open IN, "str_plasmid5.table" or die;
while (<IN>) {
    chomp;	
	if (/^\-\t(.+)/) {
	    #print $1 . "\n";
	    @ptype = split /\t/, $1; 
	} else {
	    my @tmps = split /\t/, $_;
		$str{$tmps[0]} = "1";
		for (my $a=1; $a<@tmps; $a++) {
		    if ($tmps[$a] eq "+") {
	            ${$tmps[0]}{$ptype[$a-1]} = "0";	            
			}
		}
	}
}
close IN;

my @str = keys %str;

open OUT, ">>compared_table.distance" or die;
open OUTF, ">>identity_file.txt" or die;
open OUTU, ">>new_unique_strain.list" or die;

#Read new table file
open TXT, "Bt_table_20130609_new.table" or die;
my %new_str;
my @intype;
while (<TXT>) {
    chomp;	
	if (/^\-\t(.+)/) {
	    #print $1 . "\n";
	    @intype = split /\t/, $1; 
	} else {
	    my @tmps = split /\t/, $_;
		$new_str{$tmps[0]} = "1";
		for (my $a=1; $a<@tmps; $a++) {
		    if ($tmps[$a] eq "+") {
	            ${$tmps[0]}{$intype[$a-1]} = "0";	            
			}
		}
		my @ntype = keys %{$tmps[0]};
		my $num = 0;
		for (my $i=0; $i<@str; $i++) {
	        my @a = keys %{$str[$i]};
	        my @b = @ntype;
	        my %a = map{$_=>1} @a;
	        my %b = map{$_=>1} @b;
	        my @inter = grep($a{$_}, @b);
	        my %merge = map {$_=>1} @a,@b;
	        my @merge = keys (%merge);
	        my $distance = 1 - @inter/@merge;
	        print OUT $tmps[0] . "\t" . $str[$i] . "\t" . $distance . "\n";
	        if ($distance == 0) {
	            print OUTF $tmps[0] . "\t" . $str[$i] . "\t" . $distance . "\n";
				$num++;
	        } 
       }
	   if ($num == 0) {
	       print OUTU $tmps[0] . "\n";
	   }
	}
}
close TXT;
close OUT;
close OUTF;

