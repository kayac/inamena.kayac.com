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

    my $res = $self->cache->get($keyword);
    return $res if $res;

    $res = $self->api({ keyword => $keyword, search => 1 });
    return unless $res && $res->nums;

    $self->cache->set( $keyword => $res->[0] );

    $res->[0];
}

__PACKAGE__->meta->make_immutable;

