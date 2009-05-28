package Inamena::Controller::Root;
use Ark 'Controller';

has '+namespace' => default => '';

# default 404 handler
sub default :Path :Args {
    my ($self, $c) = @_;

    $c->res->status(404);
    $c->res->body('404 Not Found');
    $c->view('MT')->template('errors/404');
    
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    $c->res->body('Ark Default Index');
}

sub end :Private {
    my ($self, $c) = @_;

    unless ($c->res->body or $c->res->status =~ /^3\d\d/) {
        $c->view('MT')->template('');
    }
}

1;
