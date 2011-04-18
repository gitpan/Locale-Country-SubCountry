#!/usr/bin/env perl

use strict;
use warnings;

use Locale::Country::SubCountry::Database::Export;

# -------------------------------

print Locale::Country::SubCountry::Database::Export -> new -> countries_as_csv;
