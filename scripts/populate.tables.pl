#!/usr/bin/env perl

use strict;
use warnings;

use Locale::Country::SubCountry::Database::Import;

# ----------------------------

Locale::Country::SubCountry::Database::Import -> new -> populate_all_tables;
