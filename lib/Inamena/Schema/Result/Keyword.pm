package Inamena::Schema::Result::Keyword;
use strict;
use warnings;
use base 'Inamena::Schema::ResultBase';

use DateTime;

__PACKAGE__->table('keyword');

__PACKAGE__->add_columns(
    id => {
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra => {
            unsigned => 1,
        },
    },
    keyword => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    count => {
        data_type     => 'INTEGER',
        is_nullable   => 0,
        default_value => 0,
    },
    created_date => {
        data_type   => 'DATETIME',
        is_nullable => 0,
        timezone    => 'Asia/Tokyo',
    },
    updated_date => {
        data_type   => 'DATETIME',
        is_nullable => 0,
        timezone    => 'Asia/Tokyo',
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['keyword']);

__PACKAGE__->has_many( comments => 'Inamena::Schema::Result::Comment', 'keyword' );

sub insert {
    my $self = shift;

    my $now = DateTime->now;
    $self->updated_date($now);
    $self->created_date($now);

    $self->next::method(@_);
}

sub update {
    my $self = shift;

    $self->updated_date(DateTime->now);

    $self->next::method(@_);
}

1;
