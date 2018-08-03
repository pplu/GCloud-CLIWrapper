package: readme
	cpanm -l local -n Dist::Zilla
	perl -I local/lib/perl5/ local/bin/dzil authordeps --missing | cpanm -n -l local/
	perl -I local/lib/perl5/ local/bin/dzil build

readme:
	cpanm -l local -n Pod::Markdown
	perl -I local/lib/perl5/ local/bin/pod2markdown lib/GCloud/CLIWrapper.pm > README.md
