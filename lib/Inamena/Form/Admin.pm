package Inamena::Form::Admin;
use Ark '+Inamena::Form';

param page => (
    type        => 'text',
    constraints => ['UINT'],
);

param perpage => (
    type        => 'text',
    constraints => ['UINT'],
);

param keyword => (
    type        => 'text',
    label       => '',
    constraints => ['NOT_NULL'],
);

1;
