##!/usr/bin/perl
use strict;
use warnings;
use DBI;

my $db_name   = 'PWeb10';
my $db_user   = 'max';
my $db_pass   = '60782999';
my $db_host   = 'localhost';
my $dbh = DBI->connect("DBI:mysql:database=$db_name;host=$db_host", $db_user, $db_pass, { RaiseError => 1, PrintError => 0 });

my $sql = "SELECT actor_id, first_name, last_name FROM actor WHERE actor_id = 5";
my $sth = $dbh->prepare($sql);
$sth->execute($actor_id);
print "Content-type: text/html\n\n";
print <<HTML
<html>
    <head>
        <title>Consulta de Actor</title>
    </head>
    <body>;
HTML
if (my $row = $sth->fetchrow_array) {
    print "<h1>Información del Actor:</h1>";
    print "<p><strong>Nombre:</strong> $row->{first_name} $row->{last_name}</p>";
} else {
    print "<h1>No se encontró ningún actor con ID</h1>";
}
print "</body></html>";
$dbh->disconnect;