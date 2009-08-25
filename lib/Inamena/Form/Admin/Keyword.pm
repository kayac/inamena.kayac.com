package Inamena::Form::Admin::Keyword;
use Ark '+Inamena::Form';

param id => (
    label       => '',
    type        => 'hidden',
    constraints => ['NOT_NULL', 'UINT'],
);

1;

