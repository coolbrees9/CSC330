#!/usr/bin/perl
use POSIX;

my $filename = $ARGV[0];
my($word,$syllable,$sentence) = (0,0,0);
open(FILE, "+<$filename") or die "Could not open file: '$filename' $!";
@vowels = ("a","e","i","o","u","y");
my ($line);
@ch = <FILE>;
foreach $line (@ch)
{
      chomp($line);
      #Checks the number of words in file
      $word += scalar(split(/\W+/, $line));
      #Checks for any punctuation on the line
      $sentence += @punct = $line =~ /[.!?;:]+/g;
      #Checks for vowels
            if($line =~ /a/ || $line =~ /e/ || $line =~ /i/ || $line =~ /o/ || $line =~ /u/ || $line =~ /y/)
            {
                  $syllable++;
            }
            elsif($line =~ /A/ || $line =~ /E/ || $line =~ /I/ || $line =~ /O/ || $line =~ /U/ || $line =~ /Y/)
            {
                  $syllable++;
            }
}
close(FILE);
$alpha = $syllable/$word;
$beta = $word/$sentence;
#Calculates and prints the grade and index 
$index = (206.835 - ($alpha*84.6) - ($beta*1.015));
$roundedindex = sprintf "%.0f", $index;
$grade = ($alpha*11.8) + ($beta*.39) - 15.59;
$roundedgrade = sprintf "%.1f", $grade;
print("Number of words: $word\n");
print("Number of sentences: $sentence\n");
print("Number of syllables: $syllable\n");
print("Index: $roundedindex\n");
print("Grade: $roundedgrade\n");
