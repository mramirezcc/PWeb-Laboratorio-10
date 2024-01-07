#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use CGI;

my $db_name   = 'PWeb10';
my $db_user   = 'max';
my $db_pass   = '60782999';
my $db_host   = 'localhost';
my $dsn = "DBI:mysql:database=$db_name;host=$db_host";
my $dbh = DBI->connect($dsn, $db_user, $db_pass, { RaiseError => 1, PrintError => 0 });

my $cgi = CGI->new;
my $year = $cgi->param('year');
my $sql = "SELECT * FROM peliculas WHERE YEAR(fecha_lanzamiento) = $year";
my $sth = $dbh->prepare($sql);
$sth->execute();
print "Content-type: text/html\n\n";
print <<HTML
<html>
    <head>
        <title>Películas de 1985</title>
    </head>
    <body>
        <h1>Películas de 1985</h1>
        <table border='1'>
            <tr>
                <th>ID</th>
                <th>Título</th>
                <th>Fecha de Lanzamiento</th>
            </tr>
HTML
while (my $row = $sth->fetchrow_hashref) {
    print <<HTML
        <tr>
            <td>$row->{id}</td>
            <td>$row->{titulo}</td>
            <td>$row->{fecha_lanzamiento}</td>
        </tr>
HTML
}
print "</table>";
print "</body></html>";
$dbh->disconnect;