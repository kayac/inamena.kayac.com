package Inamena::API::Wikipedia;
use utf8;
use Mouse;

use WebService::SimpleAPI::Wikipedia;

has api => (
    is      => 'rw',
    isa     => 'WebService::SimpleAPI::Wikipedia',
    lazy    => 1,
    default => sub {
        WebService::SimpleAPI::Wikipedia->new;
    },
);

sub search {
    my ($self, $keyword) = @_;
    $self->api->api({ keyword => $keyword, search => 1 });
}

sub find {
    my ($self, $keyword) = @_;

    for my $r (@{ $self->search($keyword) || []}) {
        return $r if $r->title eq $keyword;
    }

    return;
}

1;

