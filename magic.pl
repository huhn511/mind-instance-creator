#!/usr/bin/perl

use strict;
use warnings;

use Git::Repository;

########################################
my $document_root = '/var/www/html';
my $instance_dir = $pfad . '/' . $instance_name;
my $git_url = 'https://github.com/huhn511/rails-docker-sample.git';

my $instance_name = $ARGV[0];
chomp($instance_name);

printf($instance_name . "\n");
########################################
system("mkdir -p $document_root/$instance_name");

Git::Repository->run( clone => $git_url => $instance_dir );
my $repo = Git::Repository->new( work_tree => $instance_dir );
