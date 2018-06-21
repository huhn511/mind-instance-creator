#!/usr/bin/perl
#Abhängigkeiten des Scripts installieren
#cpan install Git::Repository;

use strict;
use warnings;
use Git::Repository;

#=== Variablen ===
my $document_root = '/var/www/html';
my $git_url = 'https://github.com/huhn511/rails-docker-sample.git';

my $instance_name = $ARGV[0];
chomp($instance_name);

my $d_yml_file = "docker-compose.yml";
my $port_file  = "/var/www/ports.txt";
my $calc_port  = 0;

my $instance_dir = $document_root . '/' . $instance_name;



printf($instance_name . "\n");

#=== Hauptprogramm ===
if(-d $instance_dir){ #Prüfung auf bereits vorhandene Ordner
  #printf("Directory already exists! Choose another name!\n");
  return 0;
}else{
  system("mkdir -p $document_root/$instance_name");
}

Git::Repository->run( clone => $git_url => $instance_dir ); #Repo clonen
my $repo = Git::Repository->new( work_tree => $instance_dir ); #Repo über Variable $repo ansprechen können

chdir($instance_dir); #Directory wechseln

#ports.txt editieren, ggf. erstellen
my $last_port = `/usr/bin/tail -n 1 $port_file`;
if(-e $port_file){
  open(my $filehandle, ">>", $port_file) or die "Kann $port_file nicht oeffnen!\n";
    $calc_port = $last_port+1;
  	print $filehandle "$calc_port\n";
  close($filehandle);
}else{
  return 0;
}


#docker_compose.yml anpassen
if(-e $d_yml_file){
  system("sed -i 's/EXTERNER_PORT/$calc_port/' $d_yml_file")
}else{
  printf("Datei $d_yml_file konnte nicht gefunden werden!");
  return 0;
}

printf($calc_port . "\n");

#db innerhalb des containers erstellen und starten
system("docker-compose run web rake db:create");
system("docker-compose up");
