package Inamena::Schema::Keyword;
use strict;
use warnings;

use DateTime::Format::MySQL;

__PACKAGE__->utf8_columns(qw/keyword/);
__PACKAGE__->has_many( messages => 'Inamena::Schema::Message', 'keyword' );

__PACKAGE__->inflate_column(
    created_date => {
        inflate => sub {
            DateTime::Format::MySQL
                    ->parse_datetime(shift)->set_time_zone('Asia/Tokyo');
        },
        deflate => sub {
            DateTime::Format::MySQL
                    ->format_datetime(shift->set_time_zone('Asia/Tokyo'));
        },
    },
);

sub insert {
    my $self = shift;

    $self->created_date( DateTime->now )
        unless $self->created_date;

    $self->next::method(@_);
}

1;

