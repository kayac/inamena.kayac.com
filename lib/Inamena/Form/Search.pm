package Inamena::Form::Search;
use Ark '+Inamena::Form';

use Inamena::Models;

param q => (
    id          => 'formTxt',
    type        => 'TextField',
    label       => '',
    constraints => [
        'NOT_NULL',
    ],
    messages => {
        'not_null'     => 'キーワードを入力してください',
        'not_found'    => 'キーワードに一致する情報は見つかりませんでした',
        'server_error' => '不明なエラーが発生しました。しばらく時間をおいてお試しください',
    },
    custom_validation => sub {
        my ($self, $form, $field) = @_;
        return unless $form->is_valid($field);

        my $res = models('API::Search')->search( $form->param($field->name) );
        if ($res) {
            $form->param( $field->name => $res->{title} );
        }
        else {
            $form->set_error( $field->name, 'not_found' );
        }
    },
);

1;

