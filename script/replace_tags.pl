#!/usr/bin/perl

use warnings;
use strict;
use FindBin qw($Bin);
use lib "$Bin/../lib";

use ReplaceTags;

ReplaceTags::run({
	expires => 'Mon, 31 Dec 2012 12:00:00 GMT',
	title   => 'Replace Tags',
	content => 'Hello, World!',
});
