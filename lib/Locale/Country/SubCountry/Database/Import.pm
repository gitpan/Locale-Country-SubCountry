package Locale::Country::SubCountry::Database::Import;

use parent 'Locale::Country::SubCountry::Base';
use strict;
use warnings;

use FindBin;

use Hash::FieldHash ':all';

use IO::File;

use Text::CSV_XS;

our $VERSION = '1.00';

# -----------------------------------------------

sub init
{
	my($self, $arg) = @_;

	$self -> SUPER::init($arg);

	return from_hash($self, $arg);

} # End of init.

# -----------------------------------------------

sub insert_hash
{
	my($self, $table_name, $field_values) = @_;

	my(@fields) = sort keys %$field_values;
	my(@values) = @{$field_values}{@fields};
	my($sql)    = sprintf 'insert into %s (%s) values (%s)', $table_name, join(',', @fields), join(',', ('?') x @fields);

	$self -> connector -> dbh -> do($sql, {}, @values);

} # End of insert_hash.

# -----------------------------------------------

sub new
{
	my($class, %arg) = @_;
    my($self)        = bless {}, $class;

	return $self -> init(\%arg);

} # End of new.

# -----------------------------------------------

sub populate_all_tables
{
	my($self) = @_;

	$self -> populate_table('countries');
	$self -> populate_table('sub_countries');

}	# End of populate_all_tables.

# -----------------------------------------------

sub populate_table
{
	my($self, $table_name) = @_;
	my($path) = "$FindBin::Bin/../data/$table_name.csv";

	$self -> insert_hash($table_name, $_) for @{$self -> read_csv_file($path)};

} # End of populate_table.

# -----------------------------------------------

sub read_csv_file
{
	my($self, $file_name) = @_;
	my($csv) = Text::CSV_XS -> new({binary => 1});
	my($io)  = IO::File -> new($file_name, 'r');

	$csv -> column_names($csv -> getline($io) );

	return $csv -> getline_hr_all($io);

} # End of read_csv_file.

# -----------------------------------------------

1;

=pod

=head1 NAME

L<Locale::Country::SubCountry::Database::Import> - Country names in English, and subcountry names in native scripts

=head1 Synopsis

See L<Locale::Country::SubCountry>.

=head1 Description

L<Locale::Country::SubCountry> provides subcountry names in their native scripts.

=head1 Methods

=head2 init()

For use by subclasses.

Sets default values for object attributes.

=head2 insert_hash()

Insert a hashref of data into a given table.

=head2 new()

For use by subclasses.

=head2 populate_all_tables()

Calls populate_table(...) for both the 'countries' and 'sub_countries' tables.

=head2 populate_table($table_name)

Populates the given table with data read from data/$table_name.csv.

=head2 read_csv_table($file_name)

Reads a CSV file and returns an arrayref (1 element per line) of hashrefs.

The CSV file must have column headings.

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
