use inc::Module::Package 'Ingy:modern 0.07';

requires    'IO::String' => '0';
recommends  'File::ReadBackwards';

# XXX Not working yet...
# use_gloom   'IO::All::Base';

clean_files 't/output/';
