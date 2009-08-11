package Inamena::Form::Comment;
use Ark '+Inamena::Form';

param comment => (
    type => 'TextField',
    id   => 'addEpisodeTxt',
    constraints => [
        'NOT_NULL',
    ],
    
);

1;

