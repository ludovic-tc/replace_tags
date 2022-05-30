use warnings;
use strict;

use Test::More;
use Test::File::Contents;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Path::Tiny;

use ReplaceTags;

my $template = <<TEMPLATE;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html>
   <head>
      <title>!title!</title>
	  <meta HTTP-EQUIV="expires" CONTENT="!expires!">
   </head>
   <body>
      <p>!content!</p>
   </body>
</html>
TEMPLATE

my $output = <<OUTPUT;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html>
   <head>
      <title>Replace Tags</title>
	  <meta HTTP-EQUIV="expires" CONTENT="Mon, 31 Dec 2012 12:00:00 GMT">
   </head>
   <body>
      <p>Hello, World!</p>
   </body>
</html>
OUTPUT

# if everything is as expected
my $templatepath = "$Bin/../templates/home.tpl";
ok -f $templatepath, "template file found at expected relative path";

file_contents_eq $templatepath, $template, "template in expected original state";

ReplaceTags::run({
	expires => 'Mon, 31 Dec 2012 12:00:00 GMT',
	title   => 'Replace Tags',
	content => 'Hello, World!',
});

file_contents_eq $templatepath, $output, "template successfully converted to expected output file";

# reset template file
path($templatepath)->spew_utf8($template);
# successful reset
file_contents_eq $templatepath, $template, "template in expected original state";

done_testing;

