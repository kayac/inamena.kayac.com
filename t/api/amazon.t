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

{
    # adult
    models('cache')->clear;

    my $safe = $api->search('うんこ');
    my $safe_item = $safe->[0];

    no strict 'refs';
    no warnings 'redefine';
    local *Inamena::API::Amazon::_parse_response = sub { # mock
        my ($self, $response) = @_;
        my $xml = $self->xml_parser->XMLin($response);

        my @items;
        for my $item (@{ $xml->{Items}{Item} || [] }) {
#            next if $item->{ItemAttributes}{IsAdultProduct}; # adult filter

            push @items, {
                asin         => $item->{ASIN},
                link         => $item->{DetailPageURL},
                image        => $item->{ImageSets}{ImageSet}[0]{MediumImage}{URL} || '',
                title        => $item->{ItemAttributes}{Title},
                author       => join(', ', @{ $item->{ItemAttributes}{Author} || [] }),
                manufacturer => $item->{ItemAttributes}{Manufacturer},
                price        => $item->{ItemAttributes}{ListPrice}{FormattedPrice},
                adult        => $item->{ItemAttributes}{IsAdultProduct},
            };
        }

        \@items;
    };

    models('cache')->clear;

    my $adult = $api->search('うんこ');
    my $adult_item = $adult->[0];

    is $adult_item->{adult}, 1, 'adult item';
    isnt $safe_item->{asin}, $adult_item->{asin}, 'search return no adult content';
}

done_testing;
