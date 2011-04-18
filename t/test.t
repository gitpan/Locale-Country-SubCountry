use Test::More tests => 2;

use Locale::Country::SubCountry;

# ------------------------

my($obj)             = Locale::Country::SubCountry -> new;
my($country)         = $obj -> all_countries;
my($country_id2name) = {map{($$_{id} => $$_{name})} @$country};
my($sub_country)     = $obj -> all_sub_countries;
$sub_country         = [map{ {%$_, country_name => $$country_id2name{$$_{country_id} } } } @$sub_country];

ok($$sub_country[190]{country_name} eq 'Australia' && $$sub_country[190]{name} eq 'Australian Capital Territory', 'Found ACT');
ok($$sub_country[197]{country_name} eq 'Australia' && $$sub_country[197]{name} eq 'Western Australia',            'Found WA');
