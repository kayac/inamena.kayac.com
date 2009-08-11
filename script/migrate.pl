#!/usr/bin/env perl

use strict;
use warnings;
use FindBin::libs;

use Inamena::Models 'model';

my $schema = model('schema');

if ($schema->get_db_version) {
    $schema->upgrade;
}
else {
    $schema->deploy;
}
