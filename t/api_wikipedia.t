use utf8;
use Test::Base;
use FindBin;
use lib "$FindBin::Bin/../extlib";

use Inamena::API::Wikipedia;

plan tests => 4 * blocks;

filters { opt => 'yaml', id => 'chomp', title => 'chomp' };

run {
    my $block = shift;
    my $api = Inamena::API::Wikipedia->new;

    my $res  = $api->search($block->opt->{keyword});
    my $item = $api->find($block->opt->{keyword});

    my @val = grep { $_->id eq $block->id } @{ $res };

    if (@val) {
        is $val[0]->title, $block->title;
        is $item->title, $block->title;
        like $val[0]->datetime->year, qr/^20/;
        like $item->datetime->year, qr/^20/;
    } else {
        fail("disagreement of id: " . $block->id);
        fail;
    }
}

__END__

===
--- opt
keyword: Perl
lang: ja
search: 1
--- id
1063
--- title
Perl

===
--- opt
keyword: TCP/IP
lang: ja
search: 1
--- id
1438
--- title
TCP/IP

===
--- opt
keyword: Google
lang: ja
search: 1
--- id
668439
--- title
Google

===
--- opt
keyword: Yahoo
lang: ja
search: 1
--- id
63513
--- title
Yahoo

===
--- opt
keyword: 日本
lang: ja
search: 1
--- id
28
--- title
日本

