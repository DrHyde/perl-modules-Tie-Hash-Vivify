use 5.006001;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Tie::Hash::Vivify',
    META_MERGE => {
        license => 'other',
        resource => {
	    repository => 'https://github.com/DrHyde/perl-modules-Tie-Hash-Vivify'
        }
    },
    VERSION_FROM      => 'lib/Tie/Hash/Vivify.pm',
    PREREQ_PM         => {},
);
