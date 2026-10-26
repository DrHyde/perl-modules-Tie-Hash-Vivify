use 5.006001;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Tie::Hash::Vivify',
    META_ADD => {
        license => 'open_source',
},
META_MERGE => {
        resources => {
	    repository => 'https://github.com/DrHyde/perl-modules-Tie-Hash-Vivify',
	    bugtracker => 'https://github.com/DrHyde/perl-modules-Tie-Hash-Vivify/issues'
        }
    },
    VERSION_FROM      => 'lib/Tie/Hash/Vivify.pm',
    PREREQ_PM         => {
        Test::More => '0.88', # done_testing
    },
);
