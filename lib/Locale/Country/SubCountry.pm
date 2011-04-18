package Locale::Country::SubCountry;

use parent Locale::Country::SubCountry::Database::Base;
use strict;
use warnings;

use Hash::FieldHash ':all';

our $VERSION = '1.00';

# -----------------------------------------------

sub all_countries
{
	my($self) = @_;

	return $self -> connector -> dbh -> selectall_arrayref('select * from countries order by name', {Slice => {} });

} # End of all_countries;

# -----------------------------------------------

sub all_sub_countries
{
	my($self) = @_;

	return $self -> connector -> dbh -> selectall_arrayref('select * from sub_countries order by country_id, name', {Slice => {} });

} # End of all_sub_countries;

# -----------------------------------------------

sub init
{
	my($self, $arg) = @_;

	$self -> SUPER::init($arg);

	return from_hash($self, $arg);

} # End of init.

# -----------------------------------------------

sub new
{
	my($class, %arg) = @_;
    my($self)        = bless {}, $class;

	$self -> init(\%arg);

	$self -> db
		(
		 Locale::Country::SubCountry::Database::Base -> new(config => $self -> config)
		);

} # End of new.

# ------------------------------------------------

1;

=pod

=head1 NAME

L<Locale::Country::SubCountry> - Country names in English, and subcountry names in native scripts

=head1 Synopsis

	#!/usr/bin/env perl

	use strict;
	use warnings;

	use Locale::Country::SubCountry;

	# ------------------------------

	my($obj)             = Locale::Country::SubCountry -> new;
	my($country)         = $obj -> all_countries;
	my($country_id2name) = {map{($$_{id} => $$_{name})} @$country};
	my($sub_country)     = $obj -> all_sub_countries;
	$sub_country         = [map{ {%$_, country_name => $$country_id2name{$$_{country_id} } } } @$sub_country];

	print map{"$$_{country_name} => $$_{name} => $$_{code}\n"} @$sub_country;

See scripts/demo.pl.

=head1 Description

L<Locale::Country::SubCountry> provides subcountry names in their native scripts.

It also provides:

=over 4

=item o ISO 3166-1 2 letter codes for countries

=item o ISO 3166-1 3 letter codes for countries

=item o ISO 3166-2 1 .. 5 letter codes for subcountries

=item o All this in an SQLite database

=back

This module is light-weight, in that it uses neither L<DBIx::Class> nor L<Moose>.

=head1 Distributions

This module is available as a Unix-style distro (*.tgz).

See L<http://savage.net.au/Perl-modules/html/installing-a-module.html>
for help on unpacking and installing distros.

=head1 Installation

=head2 The Module Itself

Install L<Locale::Country::SubCountry> as you would for any C<Perl> module:

Run:

	cpanm Locale::Country::SubCountry

or run:

	sudo cpan Locale::Country::SubCountry

or unpack the distro, and then either:

	perl Build.PL
	./Build
	./Build test
	sudo ./Build install

or:

	perl Makefile.PL
	make (or dmake or nmake)
	make test
	make install

=head2 The Configuration File

All that remains is to tell L<Locale::Country::SubCountry> your values for some options.

For that, see config/.htlocale.country.subcountry.conf.

But wait! Before editing that config file, run scripts/copy.config.pl. It will copy
the config file using L<File::HomeDir>, to a directory where the run-time code in
L<Locale::Country::SubCountry> will look for it.

	shell>cd Locale-Country-SubCountry-1.00
	shell>perl scripts/copy.config.pl

Under Debian, this directory will be $HOME/.perl/Locale-Country-SubCountry/. When you
run copy.config.pl, it will report where it has copied the config file to.

Also, it will copy config/country.sqlite to the same directory, since this is where
the code looks for that file too at run time.

Check the docs for L<File::HomeDir> to see what your operating system returns for a
call to my_dist_config().

The point of this is that after the module is installed, the config file will be
easily accessible and editable without needing permission to write to the directory
structure in which modules are stored.

That's why L<File::HomeDir> and L<Path::Class> are pre-requisites for this module.

All modules which ship with their own config file are advised to use the same mechanism
for storing such files.

=head1 Constructor and Initialization

C<new()> is called as C<< my($builder) = Locale::Country::SubCountry -> new(k1 => v1, k2 => v2, ...) >>.

It returns a new object of type C<Locale::Country::SubCountry>.

Key-value pairs in accepted in the parameter list (see corresponding methods for details):

=over 4

=item o (None as yet)

=back

=head1 Methods

=head1 Methods

=head2 all_countries()

Read the whole 'countries' table.

Returns an arrayref, 1 element per country, where each element is a hashref with these keys:

=over 4

=item o id

Unique identifier for the country. Actually the database's primary key.

=item o address_format

A string showing how to format an address in this country. Only set for some countries.

Split the string on '#' characters, to produce a format of N lines.

Replace the tokens ':X' with the corresponding data (if available).

=item o code2

The ISO3166-1 2-letter code for the country.

=item o code3

The ISO3166-1 3-letter code for the country.

=item o name

The name of the country, in English.

=back

=head2 all_subcountries()

Read the whole 'sub_countries' table.

Returns an arrayref, 1 element per subcountry, where each element is a hashref with these keys:

=over 4

=item o id

Unique identifier for the subcountry. Actually the database's primary key.

=item o country_id

The primary key into the 'countries' table.

=item o code

The ISO3166-2 1 .. 5-letter code for the country.

=item o name

The name of the subcountry, in the country's native script.

=back

=head2 init()

For use by subclasses.

Sets default values for object attributes.

=head2 new()

For use by subclasses.

=head1 Machine-Readable Change Log

The file CHANGES was converted into Changelog.ini by L<Module::Metadata::Changes>.

=head1 Version Numbers

Version numbers < 1.00 represent development versions. From 1.00 up, they are production versions.

=head1 Thanks

Many thanks are due to the people who chose to make osCommerce, PrestaShop, Zen Cart, etc, Open Source.

=head1 Support

Email the author, or log a bug on RT:

L<https://rt.cpan.org/Public/Dist/Display.html?Name=Locale::Country::SubCountry>.

=head1 Author

L<Locale::Country::SubCountry> was written by Ron Savage I<E<lt>ron@savage.net.auE<gt>> in 2011.

Home page: L<http://savage.net.au/index.html>.

=head1 Copyright

Australian copyright (c) 2011, Ron Savage.

	All Programs of mine are 'OSI Certified Open Source Software';
	you can redistribute them and/or modify them under the terms of
	The Artistic License, a copy of which is available at:
	http://www.opensource.org/licenses/index.html

=cut
