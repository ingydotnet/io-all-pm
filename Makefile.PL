use inc::Module::Install;

name        'IO-All';
all_from    'lib/IO/All.pm';
readme_from 'lib/IO/All.pod';
manifest_skip;
ack_xxx;
version_check;

requires    'IO::String' => '0';

# use_gloom   'IO::All::Base';

clean_files 't/output/';

WriteAll;
