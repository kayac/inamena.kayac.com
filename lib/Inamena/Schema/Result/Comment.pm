package Inamena::Schema::Result::Comment;
use strict;
use warnings;
use base 'Inamena::Schema::ResultBase';

use DateTime;

__PACKAGE__->table('comment');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra => {
            unsigned => 1,
        },
    },
    keyword => { # keyword.id
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra => {
            unsigned => 1,
        },
    },
    body => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    created_date => {
        data_type   => 'DATETIME',
        is_nullable => 0,
        timezone    => 'Asia/Tokyo',
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->belongs_to( keyword => 'Inamena::Schema::Result::Keyword' );

sub insert {
    my $self = shift;

    $self->created_date( DateTime->now );
    $self->keyword->update({ count => \'count + 1' });
    $self->next::method(@_);
}

sub delete {
    my $self = shift;

    $self->keyword->update({ count => \'count - 1' });
    $self->next::method(@_);
}

1;
