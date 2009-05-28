package Inamena::Schema::Message;
use strict;
use warnings;

__PACKAGE__->utf8_columns(qw/message/);

__PACKAGE__->belongs_to( keyword => 'Inamena::Schema::Keyword');

1;

