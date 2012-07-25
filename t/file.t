use Test::More tests => 3;

use IO::All;

is io('t/hai.txt')->all, "O HAI\n",
    'Implicit file works';
is io->file('t/hai.txt')->all, "O HAI\n",
    'Explicit file works';
is io('t/hai.txt')->file->all, "O HAI\n",
    'Implicit/Explicit file works';
