#!/usr/bin/perl
use POSIX;

my $filename = $ARGV[0];
my($word,$syllable,$sentence) = (0,0,0);
#Opens the file entered
open(FILE, "+<$filename") or die "Could not open file: '$filename' $!";
my ($line);
@line = <FILE>;
foreach $ch (@line)
{
      #Checks the number of words in file
      $word += scalar(split(/\W+/, $ch));
      #Checks for any punctuation
      $sentence += @punct = $ch =~ /[.!?;:]+/g;
      #Checks for vowels and does syllable rules
      $syllable += $ch =~ s/(?!e[ds]?$)[aeiouy]+//g;
}
close(FILE);
$alpha = $syllable/$word;
$beta = $word/$sentence;
#Calculates and prints the grade and index 
$index = (206.835 - ($alpha*84.6) - ($beta*1.015));
$roundedindex = sprintf "%.0f", $index;
$grade = ($alpha*11.8) + ($beta*.39) - 15.59;
$roundedgrade = sprintf "%.1f", $grade;
#print("Number of words: $word\n");
#print("Number of sentences: $sentence\n");
#print("Number of syllables: $syllable\n");
print("Index: $roundedindex\n");
print("Grade: $roundedgrade\n");