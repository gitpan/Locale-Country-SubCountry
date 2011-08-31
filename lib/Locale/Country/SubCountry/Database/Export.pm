package Locale::Country::SubCountry::Database::Export;

use parent 'Locale::Country::SubCountry::Base';
use strict;
use warnings;

use Hash::FieldHash ':all';

use Text::Xslate 'mark_raw';

fieldhash my %whole_page => 'whole_page';

our $VERSION = '1.02';

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

sub _init
{
	my($self, $arg)   = @_;
	$$arg{whole_page} ||= 0;

	$self -> SUPER::_init($arg);

	return from_hash($self, $arg);

} # End of _init.

# -----------------------------------------------

sub new
{
	my($class, %arg) = @_;
    my($self)        = bless {}, $class;

	$self -> _init(\%arg);

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
			mark_raw($$item{name}),
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

See L<Locale::Country::SubCountry::Base/all_countries()>.

=head2 all_sub_countries()

See L<Locale::Country::SubCountry::Base/all_sub_countries()>.

=head2 countries_as_csv()

Print to STDOUT a CSV version of the data returned by L<Locale::Country::SubCountry::Base//all_countries()>.

The output should match data/countries, except for slight variations in sort order.

=head2 countries_as_html()

Return a string of HTML containing a table of most country data (name, code2, code3, address_format).

See the -whole_page option in scripts/export.countries.as.html.pl for how to output either just a
HTML table (for inclusion in a web page), or a whole web page.

The templates for this HTML are in htdocs/assets/templates/locale/country/subcountry/.

=head2 _init()

For use by subclasses.

Sets default values for object attributes.

=head2 new()

For use by subclasses.

=head2 sub_countries_as_csv()

Print to STDOUT a CSV version of the data returned by L<Locale::Country::SubCountry::Base//all_sub_countries()>.

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
