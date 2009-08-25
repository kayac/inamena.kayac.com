use inc::Module::Install;
name 'Inamena';
all_from 'lib/Inamena.pm';

perl_version '5.008001';
license 'perl';

requires 'Ark';

requires 'Any::Moose';
requires 'LWP::UserAgent';
requires 'URI::Amazon::APA';
requires 'XML::LibXML::Simple';
requires 'Cache::FastMmap';
requires 'DateTime';
requires 'DBIx::Class';
requires 'HTML::TagCloud';
requires 'WebService::SimpleAPI::Wikipedia';

tests 't/*.t';

test_requires 'Test::More' => '0.88';

use_test_base;

auto_include;
auto_install;

WriteAll;
