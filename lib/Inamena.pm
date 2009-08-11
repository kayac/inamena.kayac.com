package Inamena;
use Ark;

our $VERSION = '0.01';

config 'View::MT' => {
    macro => {
        form => sub {
            Inamena->context->stash->{form};
        },
    },
};

1;
