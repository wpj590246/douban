#!/usr/bin/perl
use LWP::Simple;
use DBI;

sub spider_book{
	$douban_book_url = $_[0];
	$douban_book_intro = get($douban_book_url) or die"Error to get the webpage!";
	 
}
