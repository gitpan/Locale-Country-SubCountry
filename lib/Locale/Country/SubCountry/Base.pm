package Locale::Country::SubCountry::Base;

use strict;
use warnings;

use DBIx::Connector;

use Hash::FieldHash ':all';

use Locale::Country::SubCountry::Util::Config;

fieldhash my %config    => 'config';
fieldhash my %connector => 'connector';
fieldhash my %verbose   => 'verbose';

our $VERSION = '1.01';

# -----------------------------------------------

sub init
{
	my($self, $arg) = @_;
	$$arg{config}   = Locale::Country::SubCountry::Util::Config -> new -> config;
	$$arg{verbose}  ||= 0;
	my($dir_name)   = File::HomeDir -> my_dist_config('Locale-Country-SubCountry');
	my($file_name)  = Path::Class::file($dir_name, 'country.sqlite');
	my($dsn)        = "dbi:SQLite:dbname=$file_name";
	my($attr)       = {AutoCommit => 1, RaiseError => 1, sqlite_unicode => 1};

	$$arg{connector} = DBIx::Connector -> new($dsn, $$arg{config}{username}, $$arg{config}{password}, {AutoCommit => 1, RaiseError => 1});
	
	$$arg{connector} -> dbh -> do('PRAGMA encoding = "UTF-8"');
	$$arg{connector} -> dbh -> do('PRAGMA foreign_keys = ON');

	return from_hash($self, $arg);

} # End of init.

# -----------------------------------------------

sub new
{
	my($class, %arg) = @_;
    my($self)        = bless {}, $class;

	return $self -> init(\%arg);

} # End of new.

# -----------------------------------------------

1;

=pod

=head1 NAME

L<Locale::Country::SubCountry::Base> - Country names in English, and subcountry names in native scripts

=head1 Synopsis

See L<Locale::Country::SubCountry>.

=head1 Description

L<Locale::Country::SubCountry> provides subcountry names in their native scripts.

This module serves as a parent for various other modules.

Use L<Locale::Country::SubCountry::Database::Base> for apps.

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
