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

__PACKAGE__->utf8_columns(qw/keyword/);
__PACKAGE__->has_many( messages => 'Inamena::Schema::Message', 'keyword' );

1;
