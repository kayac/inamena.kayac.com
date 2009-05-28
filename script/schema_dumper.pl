#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use File::Spec;
use lib File::Spec->catfile( $FindBin::Bin, qw/.. schema lib/ );

use Path::Class qw/file dir/;
use DBIx::Class::Schema::Loader qw/make_schema_at/;

die unless @ARGV;

my $libdir = dir($FindBin::Bin, qw/.. lib Inamena Schema/);
if (-d $libdir) {
    $libdir->rmtree;
}

make_schema_at(
    'Inamena::Schema',
    {   components => [ 'UTF8Columns' ],
        dump_directory => File::Spec->catfile( $FindBin::Bin, '..', 'lib' ),
        debug          => 1,
    },
    \@ARGV,
);

# cleanup
for my $file ($libdir->children( all => 1 )) {
    next unless -f $file;

    my $text = $file->slurp;
    $text =~ s/# Created by DBIx::Class::Schema::Loader v[\d\.]+ @ \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}.*?package/package/s;
    $text =~ s/(\r?\n1;\r?\n).*$/$1/s;

    my $fh = $file->openw;
    print $fh $text;
    $fh->close;
}

1;
