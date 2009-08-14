#!/usr/bin/env perl

use strict;
use warnings;
use FindBin::libs;

use Inamena;

use HTTP::Engine;

my $app = Inamena->new;
$app->setup_minimal( action_cache => 'tmp/action_cache' );

HTTP::Engine->new(
    interface => {
        module => 'CGI',
        request_handler => $app->handler,
    },
)->run;
