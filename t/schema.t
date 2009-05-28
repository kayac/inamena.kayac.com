use Test::Base;

plan skip_all => 'Required INAMENA_DBTEST env to run this test'
    unless $ENV{INAMENA_DB};

plan 'no_plan';

use_ok('Inamena::Schema');

my $schema = Inamena::Schema->connect(
    "dbi:mysql:$ENV{INAMENA_DB}", 'root',
   { on_connect_do => ['SET NAMES utf8']});

isa_ok( $schema, 'DBIx::Class::Schema' );


# keyword
my $keywordrs = $schema->resultset('Keyword');
isa_ok( $keywordrs, 'DBIx::Class::ResultSet' );

my $test_keyword = 'testtest' . time;

ok($keywordrs->create({ keyword => $test_keyword }));

my $keyword = $keywordrs->find({ keyword => $test_keyword });
isa_ok( $keyword, 'DBIx::Class::Row' );

ok( $keyword->created_date );
isa_ok( $keyword->created_date, 'DateTime' );
is( $keyword->keyword, $test_keyword );

# message
my $messagers = $schema->resultset('Message');
isa_ok( $messagers, 'DBIx::Class::ResultSet' );

my $new_message = $keyword->add_to_messages({
    message => $test_keyword . q['s message],
});

ok($new_message, 'new message ok');
isa_ok($new_message, 'DBIx::Class::Row');
isa_ok($new_message, 'Inamena::Schema::Message');

is($new_message->message, $test_keyword . q['s message] );

ok($new_message->created_date);
isa_ok($new_message->created_date, 'DateTime');

my $messages = $keyword->messages;
isa_ok($messages, 'DBIx::Class::ResultSet');
isa_ok($messages->first, 'DBIx::Class::Row');
is($messages->first->message, $new_message->message);

ok($keyword->delete, 'keyword delete ok');
ok(!$keywordrs->find({ keyword => $test_keyword }), 'keyword removable success');

ok(!$messagers->search({ message => $test_keyword . q['s message] })->first);


