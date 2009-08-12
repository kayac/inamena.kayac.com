package Inamena::Schema::ResultSet::Keyword;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use List::Util 'shuffle';
use HTML::TagCloud;

sub top_keywords {
    my ($self, $attr) = @_;

    $self->search(
        { count => { '>', 0 } },
        { rows => 20, order_by => 'count desc', %{ $attr || {} } },
    );
}

sub top_keywords_cloud {
    my ($self, $attr) = @_;

    my $cloud = HTML::TagCloud->new( levels => 6 );

    my @keywords = shuffle $self->top_keywords($attr);
    for my $word (@keywords) {
        $cloud->add($word->keyword, '', $word->count);
    }

    my @res;
    for my $item ($cloud->tags) {
        push @res, {
            keyword => $item->{name},
            weight  => $item->{level} + 1, # 1 - 7
            count   => $item->{count},
        };
    }

    \@res;
}

1;
