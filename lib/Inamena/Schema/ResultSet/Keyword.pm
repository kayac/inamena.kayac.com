package Inamena::Schema::ResultSet::Keyword;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use List::Util 'shuffle';
use WWW::CloudCreator;

sub top_keywords {
    my ($self, $attr) = @_;

    $self->search(
        { count => { '>', 0 } },
        { rows => 20, order_by => 'count desc', %{ $attr || {} } },
    );
}

sub top_keywords_cloud {
    my ($self, $attr) = @_;

    my $cloud = WWW::CloudCreator->new(
        smallest => 1,
        largest  => 7,
    );

    my $count;
    my @keywords = shuffle $self->top_keywords($attr);
    for my $word (@keywords) {
        $cloud->add($word->keyword, $word->count);
        $count->{ $word->keyword } = $word->count;
    }

    my @res;
    for my $item ($cloud->gencloud) {
        push @res, {
            keyword => $item->[0],
            weight  => $item->[1],
            count   => $count->{ $item->[0] },
        };
    }

    \@res;
}

1;
