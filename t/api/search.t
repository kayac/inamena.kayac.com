use Inamena::Test;
use Inamena::Models;

my $api = models('API::Search');
isa_ok $api, 'Inamena::API::Search';

{
    # live search 1
    my $res = $api->search('イチロー');
    isa_ok $res, 'WebService::SimpleAPI::Wikipedia::Parser';
    is $res->title, 'イチロー', 'title ok';
    like $res->body, qr/鈴木/, 'content ok';
}

{
    # live search 2
    my $res = $api->search('落合博満');
    isa_ok $res, 'WebService::SimpleAPI::Wikipedia::Parser';
    is $res->title, '落合博満', 'title ok';
    like $res->body, qr/プロ野球監督/, 'content ok';
}

{
    # cached
    my $api_called;
    no warnings 'once', 'redefine';
    local *WebService::SimpleAPI::Wikipedia::api = sub {
        $api_called++;
    };

    my $res = $api->search('イチロー');
    isa_ok $res, 'WebService::SimpleAPI::Wikipedia::Parser';
    is $res->title, 'イチロー', 'title ok';
    like $res->body, qr/鈴木/, 'content ok';

    ok(!$api_called, 'cache ok');

    $api->cache->clear;
    $res = $api->search('イチロー');
    ok(!$res, 'request failed ok because api method override in this test');
    ok($api_called, 'mock ok');
}

done_testing;
