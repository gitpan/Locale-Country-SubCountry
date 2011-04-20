package Locale::Country::SubCountry::Database::Base;

use parent 'Locale::Country::SubCountry::Base';
use strict;
use warnings;

use Hash::FieldHash ':all';

fieldhash my %db => 'db';

our $VERSION = '1.01';

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

	return $self -> init(\%arg);
 
} # End of new.

# -----------------------------------------------

1;

=pod

=head1 NAME

L<Locale::Country::SubCountry::Database::Base> - Country names in English, and subcountry names in native scripts

=head1 Synopsis

See L<Locale::Country::SubCountry>.

=head1 Description

L<Locale::Country::SubCountry> provides subcountry names in their native scripts.

Use this module in applications which need to instantiate a database.

See L<Locale::Country::SubCountry::Database::Export> and scripts/export.countries.as.html for example.

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
