#!/usr/bin/perl
use strict;
use warnings;
use DBI;

my $db_name   = 'PWeb10';
my $db_user   = 'max';
my $db_pass   = '60782999';
my $db_host   = 'localhost';
my $dsn = "DBI:mysql:database=$db_name;host=$db_host";
my $dbh = DBI->connect($dsn, $db_user, $db_pass, { RaiseError => 1, PrintError => 0 });

my $sql = "SELECT * FROM peliculas WHERE puntaje > 7 AND votos > 5000";
my $sth = $dbh->prepare($sql);
$sth->execute();
print "Content-type: text/html\n\n";
print <<HTML;
<html>
<head>
    <title>Películas con Puntaje Mayor a 7 y Más de 5000 Votos</title>
</head>
<body>
    <h1>Películas con Puntaje Mayor a 7 y Más de 5000 Votos</h1>
    <table border='1'>
        <tr>
            <th>ID</th>
            <th>Título</th>
            <th>Puntaje</th>
            <th>Votos</th>
        </tr>
HTML
while (my $row = $sth->fetchrow_hashref) {
    print <<HTML;
        <tr>
            <td>$row->{id}</td>
            <td>$row->{titulo}</td>
            <td>$row->{puntaje}</td>
            <td>$row->{votos}</td>
        </tr>
HTML
}
print <<HTML;
    </table>
</body>
</html>
HTML
$dbh->disconnect;