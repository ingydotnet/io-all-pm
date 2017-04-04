#Display a list files with mask /regex/ in the current directory, sorted by the number of rows
perl -MIO::All -E "$p{$_->name}=map{$l++}$_->slurp for grep{/regex/}io('.')->all;for$k(sort{$p{$a}<=>$p{$b}}keys%p){say qq{$k $p{$k}}}"
