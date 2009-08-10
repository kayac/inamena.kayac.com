package Inamena::Controller::Root;
use Ark 'Controller';

has '+namespace' => default => '';

# default 404 handler
sub default :Path :Args {
    my ($self, $c) = @_;

    $c->res->status(404);
    $c->view('MT')->template('errors/404');
}

sub error_handler :Private {
    my ($self, $c) = @_;
    $c->res->status(500);
    $c->view('MT')->template('errors/500');

    $c->log( error => $c->error->[1] );
    $c->error([]);
}

sub index :Path {
    my ($self, $c) = @_;
}

sub end :Private {
    my ($self, $c) = @_;

    $c->res->header('Cache-Control' => 'private');

    if (!$c->debug && @{$c->error}) {
        $c->forward('error_handler');
    }

    unless ($c->res->body or $c->res->status =~ /^3\d\d/) {
        $c->forward( $c->view('MT') );
    }
}

1;
