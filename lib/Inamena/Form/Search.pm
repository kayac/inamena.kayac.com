package Inamena::Form::Search;
use Ark '+Inamena::Form';

param q => (
    id          => 'formTxt',
    type        => 'TextField',
    label       => '',
    constraints => [
        'NOT_NULL',
    ],
    messages => {
        'not_null'  => 'キーワードを入力してください',
        'not_found' => 'キーワードに一致する情報は見つかりませんでした',
    },
);

1;

