package Inamena::Schema::ResultSet::Keyword;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use List::Util 'shuffle';
use HTML::TagCloud;

sub top_keywords {
    my ($self) = @_;

    my @top = $self->search(
        { count => { '>', 0 } },
        {
            rows     => 50,
            order_by => 'count desc',
        }
    );

    my @recent = $self->search(
        { count => { '>', 0 } },
        {
            rows     => 50,
            order_by => 'updated_date desc',
        }
    );

    return @top, @recent;
}

sub top_keywords_cloud {
    my ($self) = @_;

    my $cloud = HTML::TagCloud->new( levels => 6 );

    my @keywords = shuffle $self->top_keywords;
    my %seen;
    for my $word (@keywords) {
        next if $seen{$word->id}++;
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
