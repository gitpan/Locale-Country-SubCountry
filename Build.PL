use Module::Build;

my $class = Module::Build->subclass(code => <<'EOF');

sub ACTION_build
{
	my $self = shift;
	$self->SUPER::ACTION_build(@_);
	$self->run_perl_script('scripts/copy.config.pl');
}
EOF

$class -> new
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
) -> create_build_script();
