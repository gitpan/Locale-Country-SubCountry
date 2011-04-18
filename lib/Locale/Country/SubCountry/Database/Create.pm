package Locale::Country::SubCountry::Database::Create;

use parent 'Locale::Country::SubCountry::Base';
use strict;
use warnings;

use DBIx::Admin::CreateTable;

use Hash::FieldHash ':all';

use Try::Tiny;

fieldhash my %creator     => 'creator';
fieldhash my %engine      => 'engine';
fieldhash my %time_option => 'time_option';

our $VERSION = '1.00';

# -----------------------------------------------

sub create_all_tables
{
	my($self) = @_;

	$self -> connector -> txn
		(
		 fixup => sub{ $self -> create_tables }, catch{ defined $_ ? die $_ : ''}
		);

}	# End of create_all_tables.

# -----------------------------------------------

sub create_tables
{
	my($self) = @_;

	my($method);

	# Warning: The order is important.

	for my $table_name (qw/
countries
sub_countries
/)
	{
		$method = "create_${table_name}_table";

		$self -> $method;
	}

}	# End of create_all_tables.

# --------------------------------------------------

sub create_countries_table
{
	my($self)        = @_;
	my($table_name)  = 'countries';
	my($primary_key) = $self -> creator -> generate_primary_key_sql($table_name);
	my($result)      = $self -> creator -> create_table(<<SQL);
create table $table_name
(
id $primary_key,
address_format varchar(255) not null,
code2 char(2) not null,
code3 char(3) not null,
name varchar(255) not null
)
SQL
	$self -> report($table_name, 'created', $result);

}	# End of create_countries_table.

# --------------------------------------------------

sub create_sub_countries_table
{
	my($self)        = @_;
	my($table_name)  = 'sub_countries';
	my($primary_key) = $self -> creator -> generate_primary_key_sql($table_name);
	my($result)      = $self -> creator -> create_table(<<SQL);
create table $table_name
(
id $primary_key,
country_id integer not null references countries(id),
code varchar(5) not null,
name varchar(255) not null
)
SQL
	$self -> report($table_name, 'created', $result);

}	# End of create_sub_countries_table.

# -----------------------------------------------

sub drop_all_tables
{
	my($self) = @_;

	$self -> connector -> txn
		(
		 fixup => sub{ $self -> drop_tables }, catch{ defined $_ ? die $_ : ''}
		);

}	# End of drop_all_tables.

# -----------------------------------------------

sub drop_tables
{
	my($self) = @_;

	# Warning: The order is important.

	for my $table_name (qw/
sub_countries
countries
/)
	{
		$self -> drop_table($table_name);
	}

}	# End of drop_all_tables.

# -----------------------------------------------

sub drop_table
{
	my($self, $table_name) = @_;

	$self -> creator -> drop_table($table_name);

} # End of drop_table.

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
 
	$self -> creator
		(
		 DBIx::Admin::CreateTable -> new
		 (
		  dbh     => $self -> connector -> dbh,
		  verbose => 0,
		 )
		);

	$self -> engine
		(
		 $self -> creator -> db_vendor =~ /(?:Mysql)/i ? 'engine=innodb' : ''
		);

	$self -> time_option
		(
		 $self -> creator -> db_vendor =~ /(?:MySQL|Postgres)/i ? '(0) without time zone' : ''
		);

    return $self;

} # End of new.

# -----------------------------------------------

sub report
{
	my($self, $table_name, $message, $result) = @_;

	if ($result)
	{
		die "Table '$table_name' $result. \n";
	}
	elsif ($self -> verbose)
	{
		print STDERR "Table '$table_name' $message. \n";
	}

} # End of report.

# -----------------------------------------------

1;

=pod

=head1 NAME

L<Locale::Country::SubCountry::Database::Create> - Country names in English, and subcountry names in native scripts

=head1 Synopsis

See L<Locale::Country::SubCountry>.

=head1 Description

L<Locale::Country::SubCountry> provides subcountry names in their native scripts.

=head1 Methods

=head2 create_all_tables()

Calls create_tables() inside a transaction.

=head2 create_tables()

Calls create_countries_table() and create_sub_countries_table().

=head2 drop_all_tables()

Calls drop_tables() inside a transaction.

=head2 drop_tables()

Calls drop_table() for both the 'countries' and 'sub_countries' tables.

=head2 drop_table($table_name)

Drops the named table.

=head2 init()

For use by subclasses.

Sets default values for object attributes.

=head2 new()

For use by subclasses.

=head2 report()

Reports table creation to STDERR, or dies if the table could not be created.

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
