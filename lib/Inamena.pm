package Inamena;
use Ark;

our $VERSION = '0.01';

use_model 'Inamena::Models';

config 'View::MT' => {
    macro => {
        html => sub { Text::MicroTemplate::escape_html(@_) },
        form => sub {
            Inamena->context->stash->{form};
        },
    },
};

1;
