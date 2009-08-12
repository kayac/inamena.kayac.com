package Inamena::API::Amazon;
use Any::Moose;

use Inamena::Models;

use Encode;
use LWP::UserAgent;
use URI::Amazon::APA;
use XML::LibXML::Simple;

has access_key => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has secret_key => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has version => (
    is      => 'rw',
    isa     => 'Str',
    default => '2009-07-01',
);

has associate_tag => (
    is      => 'rw',
    isa     => 'Str',
    default => 'kayac-22',
);

has endpoint => (
    is       => 'rw',
    isa      => 'Str',
    default  => 'http://ecs.amazonaws.jp/onca/xml',
);

has ua => (
    is      => 'rw',
    isa     => 'LWP::UserAgent',
    lazy    => 1,
    default => sub {
        my $ua = LWP::UserAgent->new;
        $ua->env_proxy;
        $ua;
    },
);

has xml_parser => (
    is      => 'rw',
    isa     => 'XML::LibXML::Simple',
    lazy    => 1,
    default => sub {
        XML::LibXML::Simple->new(
            ForceArray => [ qr/^Item$/, qr/^Author$/, qr/^ImageSet$/ ] );
    },
);

has cache => (
    is      => 'rw',
    isa     => 'Object',
    lazy    => 1,
    default => sub {
        models('cache');
    },
);

no Any::Moose;

sub BUILDARGS {
    my ($self, $args) = @_;

    my $conf = models('conf')->{amazon};

    return {
        %$conf,
        %{ $args || {} },
    };
}

sub search {
    my ($self, $keyword) = @_;
    $keyword = encode_utf8 $keyword; # input should be utf8

    my $cache_key = 'api:amazon:' . $keyword;
    if (my $cached = $self->cache->get($cache_key)) {
        return $cached;
    }

    my $u = URI::Amazon::APA->new($self->endpoint);
    $u->query_form(
        AssociateTag   => $self->associate_tag,
        AWSAccessKeyId => $self->access_key,
        Version        => $self->version,
        Service        => 'AWSECommerceService',
        Operation      => 'ItemSearch',
        Keywords       => $keyword,
        SearchIndex    => 'All',
        ResponseGroup  => 'Small,Images,ItemAttributes',
    );
    $u->sign(
        key    => $self->access_key,
        secret => $self->secret_key,
    );

    my $res = $self->ua->request(HTTP::Request->new( GET => $u ));

    if ($res->is_success) {
        my $obj = $self->parse_response($res->content);
        $self->cache->set( $cache_key => $obj );
        return $obj;
    }
    else {
        die $res->status_line;
    }
}

sub parse_response {
    my ($self, $response) = @_;
    my $xml = $self->xml_parser->XMLin($response);

    my @items;
    for my $item (@{ $xml->{Items}{Item} || [] }) {
        push @items, {
            asin         => $item->{ASIN},
            link         => $item->{DetailPageURL},
            image        => $item->{ImageSets}{ImageSet}[0]{MediumImage}{URL} || '',
            title        => $item->{ItemAttributes}{Title},
            author       => join(', ', @{ $item->{ItemAttributes}{Author} || [] }),
            manufacturer => $item->{ItemAttributes}{Manufacturer},
            price        => $item->{ItemAttributes}{ListPrice}{FormattedPrice},
        };
    }

    \@items;
}

__PACKAGE__->meta->make_immutable;
