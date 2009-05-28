package Inamena::Schema::Keyword;
use strict;
use warnings;

__PACKAGE__->utf8_columns(qw/keyword/);
__PACKAGE__->has_many( messages => 'Inamena::Schema::Message', 'keyword' );

1;

