## How to use

Install [Ark](http://github.com/typester/ark-perl).

Fetch source and install dependency.

    git clone git://github.com/kayac/inamena.kayac.com.git
    cd inamena.kayac.com
    perl Makefile.PL
    make installdeps

Create database

    ./script/migrate.pl

Create your local config, and write it your amazon api info

    edit config_local.pl # like following

    return {
        amazon => {
            access_key => 'your amazon access key',
            secret_key => 'your amazon secret key',
        },
    };

Then, run server

    ark.pl server -d

## Copyright and license

Copyright (c) 2009 by KAYAC Inc.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with this module.

