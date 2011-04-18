#!/usr/bin/env perl

use strict;
use warnings;

use Locale::Country::SubCountry;

# ------------------------------------------------

my($obj)             = Locale::Country::SubCountry -> new;
my($country)         = $obj -> all_countries;
my($country_id2name) = {map{($$_{id} => $$_{name})} @$country};
my($sub_country)     = $obj -> all_sub_countries;
$sub_country         = [map{ {%$_, country_name => $$country_id2name{$$_{country_id} } } } @$sub_country];

print map{"$$_{country_name} => $$_{name} => $$_{code}\n"} @$sub_country;
