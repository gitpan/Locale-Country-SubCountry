package Locale::Country::SubCountry::Database::Export;

use parent 'Locale::Country::SubCountry::Database::Base';
use strict;
use warnings;

use Hash::FieldHash ':all';

use Locale::Country::SubCountry::Database;

use Text::CSV_XS;
use Text::Xslate;

fieldhash my %whole_page => 'whole_page';

our $VERSION = '1.01';

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

sub countries_as_csv
{
	my($self) = @_;

	my(@row);

	push @row,
	[
		'name', 'code2', 'code3', 'address_format',
	];

	for my $item (@{$self -> all_countries})
	{
		push @row,
		[
			$$item{name},
			$$item{code2},
			$$item{code3},
			$$item{address_format},
		];
	}

	for (@row)
	{
		print '"', join('","', @$_), '"', "\n";
	}

}	# End of countries_as_csv.

# -----------------------------------------------

sub countries_as_html
{
	my($self) = @_;

	my(@row);

	push @row,
	[
	 {td => 'Name'},
	 {td => 'Code2'},
	 {td => 'Code3'},
	 {td => 'Address format'},
	];

	for my $item (@{$self -> all_countries})
	{
		push @row,
		[
			{td => $$item{name} },
			{td => $$item{code2} },
			{td => $$item{code3} },
			{td => $$item{address_format} },
		];
	}

	push @row,
	[
	 {td => 'Name'},
	 {td => 'Code2'},
	 {td => 'Code3'},
	 {td => 'Address format'},
	];

	my($tx) = Text::Xslate -> new
		(
		 input_layer => '',
		 path        => ${$self -> config}{template_path},
		);

	return $tx -> render
		(
		 $self -> whole_page ? 'whole.page.tx' : 'basic.table.tx',
		 {
			 row => \@row
		 }
		);

} # End of countries_as_html.

# -----------------------------------------------

sub init
{
	my($self, $arg)   = @_;
	$$arg{whole_page} ||= 0;

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
		 Locale::Country::SubCountry::Database -> new(config => $self -> config)
		);

	return $self;

} # End of new.

# -----------------------------------------------

sub sub_countries_as_csv
{
	my($self) = @_;

	my(@row);

	push @row,
	[
		'country_id', 'code', 'name',
	];

	for my $item (@{$self -> all_sub_countries})
	{
		push @row,
		[
			$$item{country_id},
			$$item{code},
			$$item{name},
		];
	}

	for (@row)
	{
		print '"', join('","', @$_), '"', "\n";
	}

}	# End of sub_countries_as_csv.

# -----------------------------------------------

sub sub_countries_as_html
{
	my($self) = @_;

	my(@row);

	push @row,
	[
	 {td => 'Country ID'},
	 {td => 'Code'},
	 {td => 'Name'},
	];

	for my $item (@{$self -> all_sub_countries})
	{
		push @row,
		[
			{td => $$item{country_id} },
			{td => $$item{code} },
			{td => $$item{name} },
		];
	}

	push @row,
	[
	 {td => 'Country ID'},
	 {td => 'Code'},
	 {td => 'Name'},
	];

	my($tx) = Text::Xslate -> new
		(
		 input_layer => '',
		 path        => ${$self -> config}{template_path},
		);

	return $tx -> render
		(
		 $self -> whole_page ? 'whole.page.tx' : 'basic.table.tx',
		 {
			 row => \@row
		 }
		);

} # End of sub_countries_as_html.

# -----------------------------------------------

1;

=pod

=head1 NAME

L<Locale::Country::SubCountry::Database::Export> - Country names in English, and subcountry names in native scripts

=head1 Synopsis

See L<Locale::Country::SubCountry>.

=head1 Description

L<Locale::Country::SubCountry> provides subcountry names in their native scripts.

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

=head2 countries_as_csv()

Print to STDOUT a CSV version of the 'countries' table.

The output should match data/countries, except for slight variations in sort order.

=head2 countries_as_html()

Return a string of HTML containing a table of most country data (name, code2, code3, address_format).

See the -whole_page option in scripts/export.countries.as.html.pl for how to output either just a
HTML table (for inclusion in a web page), or a whole web page.

The templates for this HTML are in htdocs/assets/templates/locale/country/subcountry/.

=head2 init()

For use by subclasses.

Sets default values for object attributes.

=head2 new()

For use by subclasses.

=head2 sub_countries_as_csv()

Print to STDOUT a CSV version of the 'sub_countries' table.

The output should match data/sub_countries, except for slight variations in sort order.

=head2 sub_countries_as_html()

Return a string of HTML containing a table of most subcountry data (country_id, code, name).

See the -whole_page option in scripts/export.countries.as.html.pl for how to output either just a
HTML table (for inclusion in a web page), or a whole web page.

The templates for this HTML are in htdocs/assets/templates/locale/country/subcountry/.

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
