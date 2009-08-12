package Inamena::Test;
use Ark 'Test';

use Test::More;
use File::Temp qw/tempdir/;

use Inamena::Models;

sub import {
    my ($class, @args) = @_;

    strict->import;
    warnings->import;
    utf8->import;

    # export Test::More
    Test::More->export_to_level(1);

    # mock database and cache
    my $conf   = models('conf');
    my $tmpdir = tempdir( CLEANUP => 1 );
    $conf->{database} = [
        "dbi:SQLite:$tmpdir/database.db", undef, undef,
        { unicode => 1, ignore_version => 1 },
    ];
    $conf->{cache} = {
        class => 'Cache::FastMmap',
        deref => 1,
        args  => {
            share_file => "$tmpdir/cache",
            cache_size => '1m',
        },
    };
    models('schema')->deploy;

    @_ = ($class, 'Inamena', @args);
    goto &Ark::Test::import;
}

1;

