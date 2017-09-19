#!/usr/bin/perl
use POSIX;

my $filename = $ARGV[0];
my($word,$syllable,$sentence) = (0,0,0);
open(FILE, "+<$filename") or die "Could not open file: '$filename' $!";
@vowels = ("a","e","i","o","u","y","A","E","I","O","U","Y");
my ($line);
@line = <FILE>;
foreach $ch (@line)
{
      #Checks the number of words in file
      $word += scalar(split(/\W+/, $ch));
      #Checks for any punctuation on the line
      $sentence += @punct = $ch =~ /[.!?;:]+/g;
      #Checks for vowels
      foreach (split //,$ch)
      {
            if($ch =~ "a" && $ch =~ "e" && $ch =~ "i" && $ch =~ "o" && $ch =~ "u" && $ch =~ "y")
            {
                  $syllable++;
                  if($ch+1 =~ "a" && $ch+1 =~ "e" && $ch+1 =~ "i" && $ch+1 =~ "o" && $ch+1 =~ "u" && $ch+1 =~ "y")
                  {
                        $syllable--;
                  }
            }
            elsif($ch =~ "A" && $ch =~ "E" && $ch =~ "I" && $ch =~ "O" && $ch =~ "U" && $ch =~ "Y")
            {
                  $syllable++;
            }
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
