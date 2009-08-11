package Inamena::Controller::Search;
use Ark 'Controller::Form';

sub index :Path :Form('Inamena::Form::Search') {
    my ($self, $c) = @_;

    $c->view('MT')->template('index');

    if ($self->form->submitted_and_valid) {
        
    }
}

1;
