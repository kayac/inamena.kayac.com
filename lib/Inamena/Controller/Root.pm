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

sub result :Path :Args(1) :Form('Inamena::Form::Comment') {
    my ($self, $c, $name) = @_;
    $name = decode('utf-8', $name);

    my $res = models('API::Search')->search($name)
        or $c->detach('/default');

    if ($c->req->method eq 'POST' and $self->form->submitted_and_valid) {
        my $keyword = $res->{title};

        my $add_comment = sub {
            my $keyword = models('Keyword')->find_or_create({ keyword => $keyword });
            $keyword->add_to_comments({
                body => $self->form->param('comment'),
            });
        };

        eval {
            models('schema')->txn_do($add_comment);
        };
        if ($@) {
            $self->log( error => $@ );
            $c->detach;
        }

        $c->redirect_and_detach( $c->req->uri );
    }
    else {
        $c->stash->{result} = $res;
        $c->stash->{keyword} = models('Keyword')->find({ keyword => $res->{title} });

        $c->stash->{link}
            = qq!<a href="@{[ $c->uri_for('/', $name) ]}" target="_blank">${name}の否めないエピソード</a>!;
    }
}

sub index :Path :Form('Inamena::Form::Search') {
    my ($self, $c) = @_;

    if ($c->req->method eq 'POST' and $self->form->submitted_and_valid) {
        $c->redirect_and_detach( $c->uri_for('/', $self->form->param('q')) );
    }

    $c->stash->{counter} = {
        keyword => models('Keyword')->search({ count => { '>', 0 }})->count,
        comment => models('Comment')->search->count,
    };
    $c->stash->{top_keywords_cloud} = models('Keyword')->top_keywords_cloud;
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
