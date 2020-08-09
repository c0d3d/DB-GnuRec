# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl DB-GnuRec.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

# use strict;
use warnings;

use Test::More tests => 1;
use Data::Dumper;

BEGIN { use_ok('DB::GnuRec') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

print "?!?!?!?\n";
my $handle = DB::GnuRec->new();
Test::More::diag ($handle, "\n");
my $fname = "./example.db";
Test::More::diag(Dumper(\%{ref ($handle)."::"}));
open my $f, "<", $fname;
$handle->load_file($f, $fname);

close $f;
