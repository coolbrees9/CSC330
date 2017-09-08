#!/usr/bin/perl
use warnings;
my $filename = ARGV[0];
my($word,$syllable,$sentence) = (0,0,0);
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file: '$filename' $!";
while(<File>)
{
      $word += scalar(split(/\W+/, $_)); 
}
$alpha = $syllable/$word;
$beta = $word/$sentence; 
$index = 206.835 - ($alpha*84.6) - ($beta*1.015);
$grade = ($alpha*11.8) + ($beta*.39) - 15.59;
print("Number of words: $word\n");
print("Number of sentences: $sentence\n");
print("Number of syllables: $syllable\n");
print("Index: $index\n");
print("Grade: $grade\n");

