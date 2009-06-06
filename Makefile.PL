use inc::Module::Install;

perl_version '5.8.1';
name 'Algorithm-BIT';

all_from 'lib/Algorithm/BIT.pm';

requires 'perl' => '5.8.1';

auto_install;
WriteAll;
