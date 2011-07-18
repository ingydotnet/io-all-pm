use inc::Module::Package 'Ingy:modern 0.12';

requires    'IO::String' => '1.08';
recommends  'File::ReadBackwards';

# XXX Not working yet...
# use_gloom   'IO::All::Base';

clean_files 't/output/';
