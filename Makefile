package:
	cpanm -l local -n Dist::Zilla
	perl -I local/lib/perl5/ local/bin/dzil authordeps --missing | cpanm -n -l local/
	perl -I local/lib/perl5/ local/bin/dzil build
