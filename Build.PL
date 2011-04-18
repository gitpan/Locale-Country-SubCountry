use Module::Build;

Module::Build -> new
(
 module_name    => 'Locale::Country::SubCountry',
 license        => 'artistic',
 dist_abstract  => 'Country names in English, and subcountry names in native scripts',
 dist_author    => 'Ron Savage <ron@savage.net.au>',
 build_requires =>
 {
 	 Test::More => 0.94,
 	 Test::Pod  => 1.44,
 },
 configure_requires =>
 {
 	 Module::Build => 0.3800,
 },
 requires =>
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
) -> create_build_script();
