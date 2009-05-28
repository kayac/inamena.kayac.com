use Test::Base qw(no_plan);
use FindBin;
use lib "$FindBin::Bin/../extlib";

use Ark::Test 'Inamena';

like ( get('/search'), qr{入力してください</li>});
my $long_text = 'h' x 101;
like ( get("/search?q=$long_text"), qr{<li>キーワード の長さがちがいます</li>});

unlike ( get('/search?q=test'), qr{<ul class="error">});


