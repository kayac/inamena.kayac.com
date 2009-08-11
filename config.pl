my $home = Inamena::Models->get('home');

my $cache = {
    class => 'Cache::FastMmap',
    args  => { share_file => $home->file('tmp/cache')->stringify, },
    deref => 1,
};

return {
    cache => $cache,
};
