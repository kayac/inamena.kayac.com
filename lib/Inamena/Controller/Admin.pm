package Inamena::Controller::Admin;
use Ark 'Controller::Form';

has '+namespace' => default => '.admin';

use Inamena::Models;

sub index :Path :Form('Inamena::Form::Admin') {
    my ($self, $c) = @_;
    my $form = $self->form;

    $c->stash->{keywords} = models('Keyword')->search({
            $form->valid_param('keyword')
            ? ( keyword => { like => '%' . $form->valid_param('keyword') . '%' } )
            : (),
            count => { '>=', 1 },
        },
        {   page => $form->valid_param('page')    || 1,
            rows => $form->valid_param('perpage') || 30,
            order_by => 'created_date desc',
        }
    );

    $c->view('MT')->template('admin/index');
}

sub keyword :Local :Args(1) :Form('Inamena::Form::Admin::Keyword') {
    my ($self, $c, $id) = @_;

    if ($c->req->method eq 'POST' && $self->form->submitted_and_valid) {
        my $comment = models('Comment')->find( $self->form->valid_param('id') )
            or die;

        $comment->delete;
        $c->redirect_and_detach( $c->req->uri );
    }

    my $keyword = models('Keyword')->find($id)
        or $c->detach('/default');

    $c->stash->{keyword} = $keyword;
    $c->view('MT')->template('admin/keyword');
}

1;
