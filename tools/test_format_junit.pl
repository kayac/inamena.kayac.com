#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::RealBin/../lib";
use lib "$FindBin::RealBin/../extlib";


use TAP::Harness::JUnit;
my $harness = TAP::Harness::JUnit->new(
    {   xmlfile => 'TEST-RESULT.xml',
        merge   => 1,
    }
);

$harness->runtests(@ARGV);

