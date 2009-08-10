use inc::Module::Install;
name 'Inamena';
all_from 'lib/Inamena.pm';

requires 'Ark';

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
