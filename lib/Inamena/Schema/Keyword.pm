package Inamena::Schema::Keyword;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("UTF8Columns", "Core");
__PACKAGE__->table("keyword");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "keyword",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 255,
  },
  "created_date",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("id");


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
