use inc::Module::Package 'Ingy:modern 0.17';

requires    'IO::String' => '1.08';
recommends  'File::ReadBackwards';

clean_files 't/output/';
