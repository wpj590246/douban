#!/usr/bin/perl 
use LWP::Simple;
use DBI;

my $db_name = "douban";
my $location = "localhost";
my $port = "3306";
my $database = "DBI:mysql:$db_name:$location:$port";
my $db_user = "root";
my $db_password = '';
my $dbh = DBI->connect($database, $db_user, $db_password) or die $DBI::errstr;

my $sql = "SET NAMES utf8";
my $sth = $dbh->prepare($sql);
$sth->execute or die "$dbh->errstr";

my $sql = "SET CHARACTER set utf8";
my $sth = $dbh->prepare($sql);
$sth->execute or die "$dbh->errstr";

my $douban_series_url_base = "http://book.douban.com/series/";
my $douban_series_id = 12415;
while ($douban_series_id <= 12462)
{
	$douban_series_url = $douban_series_url_base . $douban_series_id;
	$douban_series_intro = get($douban_series_url);
	if ($douban_series_intro =~ /<h1>(.+)<\/h1>[\s\S]+?<span class="pl2" >.+?<\/span>([0-9]+)/) {
		print "Series ID:$douban_series_id; Series Title:$1; Series Book Sum:$2.\n";

		my $sql = "INSERT INTO series VALUES ($douban_series_id,\"$1\",$2)";
		my $sth = $dbh->prepare($sql);
		$sth->execute() or die"$dbh->errstr";
	}else{
		print "Series ID:$douban_series_id; No match!\n";
	}
	$douban_series_id++;
}

$dbh->disconnect;
