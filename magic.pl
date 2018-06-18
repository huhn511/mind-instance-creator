#!/usr/bin/perl
#cpan install Git::Repository;


use strict;
use warnings;
use Git::Repository;

########################################
my $document_root = '/var/www/html';
my $git_url = 'https://github.com/huhn511/rails-docker-sample.git';

my $instance_name = $ARGV[0];
chomp($instance_name);

my $instance_dir = $document_root . '/' . $instance_name;

printf($instance_name . "\n");
########################################

if(-d $instance_dir){
  printf("Directory already exists! Choose another name!\n");
  return 0;
}else{
  system("mkdir -p $document_root/$instance_name");
}
Git::Repository->run( clone => $git_url => $instance_dir );
my $repo = Git::Repository->new( work_tree => $instance_dir );
