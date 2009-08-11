package Inamena::Controller::Root;
use Ark 'Controller::Form';

use Encode;
use Inamena::Models;
use Inamena::Form::Search;

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

sub result :Path :Args(1) {
    my ($self, $c, $name) = @_;
    $name = decode('utf-8', $name);

    my $res = models('API::Search')->search($name)
        or $c->detach('/default');

    $c->stash->{result} = $res;
    $c->stash->{link} =
        qq!<a href="@{[ $c->uri_for('/', $name) ]}" target="_blank">${name}の否めないエピソード</a>!;
}

sub index :Path :Form('Inamena::Form::Search') {
    my ($self, $c) = @_;

    if ($c->req->method eq 'POST' and $self->form->submitted_and_valid) {
        $c->redirect_and_detach( $c->uri_for('/', $self->form->param('q')) );
    }
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
