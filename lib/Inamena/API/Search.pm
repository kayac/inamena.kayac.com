package Inamena::API::Search;
use Any::Moose;

use Inamena::Models;
use WebService::SimpleAPI::Wikipedia;

has wikipedia => (
    is      => 'rw',
    isa     => 'WebService::SimpleAPI::Wikipedia',
    lazy    => 1,
    default => sub {
        WebService::SimpleAPI::Wikipedia->new;
    },
    handles => ['api'],
);

has cache => (
    is      => 'rw',
    isa     => 'Object',
    lazy    => 1,
    default => sub { models('cache') },
);

sub search {
    my ($self, $keyword) = @_;

    my $cache_key = 'api::search::' . $keyword;

    my $res = $self->cache->get($cache_key);
    return $res if $res;

    local $XML::Simple::PREFERRED_PARSER = 'XML::Parser';
    $res = $self->api({ keyword => $keyword, search => 1 });
    return unless $res && $res->nums;

    $self->cache->set( $cache_key => $res->[0] );

    $res->[0];
}

__PACKAGE__->meta->make_immutable;

