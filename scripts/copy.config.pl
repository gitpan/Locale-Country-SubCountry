#!/usr/bin/env perl

use strict;
use warnings;

use File::Copy;
use File::HomeDir;

use Path::Class;

# ----------------------------------------

sub transfer_file
{
	my($source_path, $source_file, $dir_name) = @_;

	File::Copy::copy($source_path, $dir_name);

	my($dest_file_name) = Path::Class::file($dir_name, $source_file);

	if (-e $dest_file_name)
	{
		print "Copied $source_path to $dir_name\n";
	}
	else
	{
		die "Unable to copy $source_path to $dir_name\n";
	}

} # End of transfer_file.

# ----------------------------------------

my($module)           = 'Locale::Country::SubCountry';
my($module_dir)       = $module;
$module_dir           =~ s/::/-/g;
my($dir_name)         = File::HomeDir -> my_dist_config($module_dir, {create => 1});
my($config_name)      = '.htlocale.country.subcountry.conf';
my($source_file_name) = Path::Class::file('config', $config_name);

if ($dir_name)
{
	transfer_file($source_file_name, $config_name, $dir_name);

	my($country_name) = 'country.sqlite';
	$source_file_name = Path::Class::file('config', $country_name);

	transfer_file($source_file_name, $country_name, $dir_name);
}
else
{
	print "Unable to create directory using File::HomeDir -> my_dist_config('$module_dir', {create => 1})\n";
	die "for use by File::Copy::copy($source_file_name, \$dir_name)\n";
}
