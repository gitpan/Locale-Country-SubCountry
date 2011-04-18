#!/usr/bin/env perl

use strict;
use warnings;

use Locale::Country::SubCountry::Database::Create;

# ----------------------------

Locale::Country::SubCountry::Database::Create -> new -> create_all_tables;
