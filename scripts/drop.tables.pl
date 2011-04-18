#!/usr/bin/env perl

use strict;
use warnings;

use Locale::Country::SubCountry::Database::Create;

# ----------------------------

Locale::Country::SubCountry::Database::Create -> new -> drop_all_tables;
