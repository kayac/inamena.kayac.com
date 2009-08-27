#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;

my $type = $ARGV[0] || 'cgi';

if ($type eq 'cgi') {
    print <<"...";
server.document-root = "$FindBin::Bin/root"

\$HTTP["url"] !~ "^/(css/|imgs?/|images?/|js/|static/|tmp/|[^/]+\\.[^/]+\$)" {
        setenv.add-environment = (
            "SERVER_PORT" => "80",
#            "ARK_DEBUG" => "1",
        )

        cgi.assign = ( "" => "" )
        alias.url = (
            "" => "$FindBin::Bin/script/inamena.cgi",
        )
    }
...

}
elsif ($type eq 'fastcgi') {
    print <<"...";
server.document-root = "$FindBin::Bin/root"

\$HTTP["url"] !~ "^/(css/|imgs?/|images?/|js/|static/|tmp/|[^/]+\\.[^/]+\$)" {
        setenv.add-environment = (
            "SERVER_PORT" => "80",
#            "ARK_DEBUG" => "1",
        )

        fastcgi.server = (
            "" => (
                ("socket" => "$FindBin::Bin/tmp/socket",
                 "check-local" => "disable"),
            ),
        )
    }
...
}
else {
    die qq[Unknown type "$type"];
}

__END__

=head1 NAME

lighttpd_conf.pl - lighttpd config generator

=head1 SYNOPSIS

Usage:

    HTTP["host"] == "inamena.kayac.com" { # your virtual domain
        include_shell "/path/to/lighttpd_conf.pl cgi"
        # or
        # include_shell "/path/to/lighttpd_conf.pl fastcgi"
    }

in your lighttpd.conf

=head1 AUTHOR

Daisuke Murase <typester@cpan.org>

=cut

