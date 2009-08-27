#!/usr/bin/env perl

use strict;
use warnings;
use FindBin::libs;
use Getopt::Long;

GetOptions(
    \my %options,
    qw/nproc=i listen=s keep_stderr/,
);

use Inamena;

use HTTP::Engine;

my $app = Inamena->new;
$app->setup;

HTTP::Engine->new(
    interface => {
        module => 'FCGI',
        args   => \%options,
        request_handler => $app->handler,
    },
)->run;
