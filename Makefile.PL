use 5.026001;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'DB::GnuRec',
    VERSION_FROM      => 'lib/DB/GnuRec.pm',
    PREREQ_PM         => {},
    ABSTRACT_FROM     => 'lib/DB/GnuRec.pm',
    AUTHOR            => 'Neil Locketz <neil@nlocketz.com>',
    LIBS              => ['-lrec']
);
