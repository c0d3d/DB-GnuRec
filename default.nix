# perl Makefile.PL INC="-I/home/pitb0ss/.local/include" CCFLAGS="-L/home/pitb0ss/.local/lib"
{ ... }:
let
  nixpkgs = import <nixpkgs> {};
  perlPkgs = nixpkgs.perl528Packages;
  makeFile = nixpkgs.writeTextFile {
    name = "Makefile.PL";
    text = ''
      use 5.026001;
      use ExtUtils::MakeMaker;

      WriteMakefile(
        NAME              => 'DB::GnuRec',
        VERSION_FROM      => 'lib/DB/GnuRec.pm',
        PREREQ_PM         => {},
        ABSTRACT_FROM     => 'lib/DB/GnuRec.pm',
        AUTHOR            => 'Neil Locketz <neil@nlocketz.com>',
        LIBS              => ["-L${nixpkgs.recutils}/lib -lrec"],
        INC               => "-I${nixpkgs.recutils}/include"
      );
    '';
  };
in nixpkgs.buildPerlPackage rec {
  pname = "DB-GnuRec";
  version = "0.01";
  propogatedNativeBuildInputs = [ nixpkgs.recutils perlPkgs.ExtUtilsTypemapsDefault ];
#  nativeBuildInputs
  buildInputs = [


#    perlPkgs.ExtUtilsMakeMaker
#    perlPkgs.ExtUtilsXSpp
  ];
  src = ./.;
  preConfigure = ''
#    makeMakerFlags=" INC=\"-I\" CCFLAGS=\"-L${nixpkgs.recutils}/lib\" "
    ls -Rl ${nixpkgs.recutils}/include
    export NIX_CFLAGS_COMPILE="-E -I${nixpkgs.recutils}/include $NIX_CFLAGS_COMPILE"
    export CC="gcc -E"
    cp "${makeFile}" ./Makefile.PL
    pwd
  '';

}
