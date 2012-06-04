#!/usr/bin/perl 
use LWP::Simple;

my $douban_series_url_base = "http://book.douban.com/series/";
my $douban_series_url_id = 12414;
while ($douban_series_url_id <= 12414)
{
	$douban_series_url = $douban_series_url_base . $douban_series_url_id;
	$douban_series_intro = get($douban_series_url);
	if ($douban_series_intro =~ /<h1>(.+)<\/h1>[\s\S]+?<span class="pl2" >.+?<\/span>([0-9]+)/) {
		print "Series ID:$douban_series_id; Series Title:$1; Series Book Sum:$2.\n";
	}else{
		print "Series ID:$douban_series_id; No match!\n";
	}
	$douban_series_url_id++;
}
