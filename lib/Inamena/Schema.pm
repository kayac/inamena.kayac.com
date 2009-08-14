package Inamena::Schema;
use strict;
use warnings;
use base 'DBIx::Class::Schema';

our $VERSION = '2';

__PACKAGE__->load_namespaces;

__PACKAGE__->load_components(qw/Schema::Versioned/);
__PACKAGE__->upgrade_directory('sql/');
__PACKAGE__->backup_directory('sql/backups/');

1;

