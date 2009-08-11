package Inamena::Models;
use Ark::Models -Base;

register cache => sub {
    my $self = shift;
    my $conf = $self->get('conf')->{cache};

    $self->adaptor($conf);
};

register schema => sub {
    my $self = shift;
    my $conf = $self->get('conf')->{database};

    $self->ensure_class_loaded('Inamena::Schema');
    Inamena::Schema->connect(@$conf);
};

register_namespaces 'API' => 'Inamena::API';

1;

