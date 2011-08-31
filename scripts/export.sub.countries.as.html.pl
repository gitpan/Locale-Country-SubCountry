#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;

use Locale::Country::SubCountry::Database::Export;

use Pod::Usage;

# -------------------------------

my($option_parser) = Getopt::Long::Parser -> new();

my(%option);

if ($option_parser -> getoptions
(
 \%option,
 'help',
 'whole_page',
) )
{
	pod2usage(1) if ($option{'help'});

	print Locale::Country::SubCountry::Database::Export -> new(whole_page => $option{whole_page}) -> sub_countries_as_html;

	exit;
}
else
{
	pod2usage(2);
}

__END__

=pod

=head1 NAME

export.as.html.pl - Export names as a table or a whole page.

=head1 SYNOPSIS

export.as.html.pl [options]

	Options:
	-help
	-whole_page

All switches can be reduced to a single letter.

Exit value: 0.

=head1 OPTIONS

=over 4

=item -help

Print help and exit.

=item -whole_page

Output a whole web page.

=back

=cut
