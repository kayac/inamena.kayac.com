#!/usr/bin/env perl

use strict;
use warnings;
use FindBin::libs;
use Path::Class qw/file/;

use Inamena::Schema;

my $current_version = Inamena::Schema->schema_version;
my $next_version    = $current_version + 1;

Inamena::Schema->connect->create_ddl_dir(
    [qw/SQLite MySQL/],
    $next_version,
    "$FindBin::Bin/../sql/",
    $current_version || undef,  # 0 => undef
);

{   # replace version
    my $f = file( $INC{'Inamena/Schema.pm'} );
    my $content = $f->slurp;
    $content =~ s/(\$VERSION\s*=\s*(['"]))(.+?)\2/$1$next_version$2/
        or die "Failed to replace version.";

    my $fh = $f->openw or die $!;
    print $fh $content;
    $fh->close;
}
