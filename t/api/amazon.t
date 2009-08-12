use Inamena::Test;
use Inamena::Models;

my $api = models('API::Amazon');
isa_ok $api, 'Inamena::API::Amazon';

{
    # live search
    my $res = $api->search('イチロー');
    ok ref $res eq 'ARRAY', 'result ok';

    my $item = $res->[0];
    ok ref $item eq 'HASH', 'item ok';

    ok exists $item->{$_}, "item $_ ok"
        for qw/title asin link price image manufacturer/;

    like $item->{link}, qr/kayac-22/, 'asamasi ok';
}

{
    # cache
    my $ua_called;
    no warnings 'once', 'redefine';
    local *LWP::UserAgent::request = sub {
        $ua_called++;
        my $res = HTTP::Response->new(500);
    };

    my $res = $api->search('イチロー');
    ok ref $res eq 'ARRAY', 'result ok';

    my $item = $res->[0];
    ok ref $item eq 'HASH', 'item ok';

    ok exists $item->{$_}, "item $_ ok"
        for qw/title asin link price image manufacturer/;

    like $item->{link}, qr/kayac-22/, 'asamasi ok';

    ok !$ua_called, 'cache ok';

    models('cache')->clear;

    eval { $api->search('イチロー') };
    like $@, qr/500/, 'api error ok';
    ok $ua_called, 'mock ok';
}

done_testing;
