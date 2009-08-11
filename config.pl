my $home = Inamena::Models->get('home');

my $cache = {
    class => 'Cache::FastMmap',
    args  => { share_file => $home->file('tmp/cache')->stringify, },
    deref => 1,
};

my $database = [
    'dbi:SQLite:' . $home->file('database.db'), undef, undef,
    { unicode => 1 },
];

return {
    cache    => $cache,
    database => $database,
};
