#!perl -w

my @ptype;
my %str;
open IN, "Bt_table_20130609.table" or die;
open NUL, ">>Bt_table_20130609_null.txt" or die;
while (<IN>) {
    chomp;	
	if (/^\-\s+(.+)/) {
	    #print $1 . "\n";
	    @ptype = split /\t/, $1; 
	} else {
	    my @tmps = split /\t/, $_;
		my $num = 0;
		for (my $a=1; $a<@tmps; $a++) {
		    if ($tmps[$a] eq "+") {
	            ${$tmps[0]}{$ptype[$a-1]} = "0";	
                print $ptype[$a-1]; 
                $num++;				
			}
		}
		if ($num > 0) {
		    $str{$tmps[0]} = "1";
		} else {
		    print NUL $tmps[0] . "\n"; 
		}
	}
	print "\n";
}
close IN;
close NUL;

my @str = keys %str;
open STR, ">>Bt_table_20130609.list" or die;
foreach (@str) {
    chomp;
    print STR $_ . "\n";
}
close STR;

open OUT, ">>Bt_table_20130609.distance" or die;
open OUTI, ">>Bt_table_20130609_identity.distance" or die;
for (my $i=0; $i<@str; $i++) {
    for (my $j=$i+1; $j<@str; $j++) {
	    my @a = keys %{$str[$i]};
		my @b = keys %{$str[$j]};
		my %a = map{$_=>1} @a;
		my %b = map{$_=>1} @b;
		my @inter = grep($a{$_}, @b);
		my %merge = map {$_=>1} @a,@b;
		my @merge = keys (%merge);
		unless (@merge == 0) {
		    my $distance = 1 - @inter/@merge;
		    print OUT $str[$i] . "\t" . $str[$j] . "\t" . $distance . "\n";
			if ($distance == 0) {
			    print OUTI $str[$i] . "\t" . $str[$j] . "\t" . $distance . "\n";
			}
		}
	}
}
close OUT;