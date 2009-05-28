package Inamena::Controller::Search;
use Ark 'Controller';

use FormValidator::Lite;

sub index :Path Args(0) {
    my ($self, $c) = @_;

    
    my $v = FormValidator::Lite->new($c->req);
    $v->load_function_message('ja');

    $v->set_param_message(
        q => 'キーワード',
    );

    my $res = $v->check(
        q => [qw/NOT_NULL/, [qw/LENGTH 0 100/]],
    );

    
    $c->stash->{form} = $res;
}


1;
