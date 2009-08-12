my $home = Inamena::Models->get('home');

my $cache = {
    class => 'Cache::FastMmap',
    args  => {
        share_file     => $home->file('tmp/cache')->stringify,
        cache_size     => '10m',
        unlink_on_exit => 0,
    },
    deref => 1,
};

my $database = [
    'dbi:SQLite:' . $home->file('database.db'), undef, undef,
    { unicode => 1 },
];

# Or mysql
#my $database = [
#    'dbi:mysql:inamena', 'root', '',
#    {
#        mysql_enable_utf8 => 1,
#        on_connect_do     => ['SET NAMES utf8'],
#    },
#];

return {
    cache    => $cache,
    database => $database,
};
