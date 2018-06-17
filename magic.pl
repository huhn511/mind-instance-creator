#!/usr/bin/perl

use strict;
use warnings;

my $pfad = '/var/www/html';
my $instance_name = $ARGV[0];
chomp($instance_name);

printf($instance_name . "\n");

system("mkdir -p $pfad/$instance_name");
