package Locale::Country::SubCountry::Database;

use strict;
use warnings;

use DBIx::Admin::CreateTable;
use DBIx::Connector;

use Hash::FieldHash ':all';

fieldhash my %config    => 'config';
fieldhash my %connector => 'connector';

our $VERSION = '1.01';

# -----------------------------------------------

sub init
{
	my($self, $arg) = @_;

	return from_hash($self, $arg);

} # End of init.

# -----------------------------------------------

sub new
{
	my($class, %arg) = @_;
    my($self)        = bless {}, $class;

	$self -> init(\%arg);
 
	my($config)    = $self -> config;
	my($dir_name)  = File::HomeDir -> my_dist_config('Locale-Country-SubCountry');
	my($file_name) = Path::Class::file($dir_name, 'country.sqlite');
	my($dsn)       = "dbi:SQLite:dbname=$file_name";
	my($attr)      = {AutoCommit => 1, RaiseError => 1, sqlite_unicode => 1};

	$self -> connector(DBIx::Connector -> new($dsn, $$config{username}, $$config{password}, $attr) );
	$self -> connector -> dbh -> do('PRAGMA encoding = "UTF-8"');
	$self -> connector -> dbh -> do('PRAGMA foreign_keys = ON');

	return $self;

}	# End of new.

# --------------------------------------------------

1;

=pod

=head1 NAME

L<Locale::Country::SubCountry::Database> - Country names in English, and subcountry names in native scripts

=head1 Synopsis

See L<Locale::Country::SubCountry>.

=head1 Description

L<Locale::Country::SubCountry> provides subcountry names in their native scripts.

Used by L<Locale::Country::SubCountry::Database::Export>.

=head1 Methods

=head2 init()

For use by subclasses.

Sets default values for object attributes.

=head2 new()

For use by subclasses.

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
