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
# Next line runs copy.config.pl when user runs 'make'.
# Warning: '...' => 0 is OK but => '' or undef are ignored.
 PL_FILES  => {'scripts/copy.config.pl' => 'Copying...'},
 PREREQ_PM =>
 {
 	 Config::Tiny          => 2.13,
	 Data::Section::Simple => 0.02,
 	 File::Copy            => 2.18,
 	 File::HomeDir         => 0.97,
	 Getopt::Long          => 2.38,
	 Hash::FieldHash       => 0.10,
 	 parent                => 0.224,
 	 Path::Class           => 0.23,
	 Pod::Usage            => 1.36,
	 Test::More            => 0.98,
	 Text::CSV_XS          => 0.80,
 	 Text::Xslate          => 1.0007,
 },
 VERSION_FROM => 'lib/Locale/Country/SubCountry.pm',
);
