use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile
(
 ($] ge '5.005') ?
 (
  AUTHOR   => 'Ron Savage (ron@savage.net.au)',
  ABSTRACT => 'Country names in English, and subcountry names in native scripts',
    ) : (),
 clean =>
 {
	 FILES => 'blib/* Makefile MANIFEST Locale-Country-SubCountry-*'
 },
 dist =>
 {
	 COMPRESS => 'gzip',
	 SUFFIX   => 'gz'
 },
 DISTNAME  => 'Locale-Country-SubCountry',
 NAME      => 'Locale::Country::SubCountry',
 PL_FILES  => {},
 PREREQ_PM =>
 {
 	 Config::Tiny                => 2.13,
	 DBD::SQLite                 => 1.31,
 	 DBIx::Admin::CreateTable    => 2.07,
 	 DBIx::Connector             => 0.42,
 	 File::Copy                  => 2.18,
 	 File::HomeDir               => 0.97,
	 FindBin                     => 1.50,
	 Hash::FieldHash             => 0.10,
	 IO::File                    => 1.14,
 	 parent                      => 0.224,
 	 Path::Class                 => 0.23,
	 Text::CSV_XS                => 0.80,
 	 Text::Xslate                => 1.0007,
 	 Try::Tiny                   => 0.09,
 },
 VERSION_FROM => 'lib/Locale/Country/SubCountry.pm',
);
