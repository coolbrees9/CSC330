with Ada.Text_IO;
with Ada.IO_Exceptions;
use Ada.Text_IO;
use Ada.IO_Exceptions;

procedure flesch is

In_File :File_Type;
value :Character;
string_array :array(1..5000000)of Character;
pos :Integer;
word :Float:= 0.0;
syllable :Float:= 0.0;
sentence :Float:= 0.0;
alpha :Float;
beta :Float;
index :Float;
grade :Float;
vowel : constant String:="aeiouyAEIOUY";

begin

Ada.Text_IO.Open(File=>In_File,Mode=>Ada.Text_IO.In_File,Name=>"KJV.txt");

pos:=0;
while not End_of_File(In_File) loop
      Ada.Text_IO.Get(File=>In_File,Item=>value);
      pos:=pos+1;
      string_array(pos):=value;
end loop;

exception
when Ada.IO_Exceptions.END_ERROR=>Ada.Text_IO.Close(File=>In_File);
--Does the word count
for i in In_File'Range
 loop
      if In_File(i) = ' ' and Word = true then
            Word:=False;
      elsif In_File(i) /= '_' and Word = false then
            Word:=True;
      word:=word+1;
      else
            null;
      end if;
end loop;
--Checks for the sentence count
for i in In_File'Range
 loop
      if In_File(i) = '.' 
      or if In_File(i) = '?' 
      or if In_File(i) = '!' 
      or if In_File(i) = ';' 
      or if In_File(i) = ':' then
           sentence:=sentence+1;
      end if;
end loop;
--Checks for vowels
for i in In_File'Range
 loop
      if In_File(i) = 'a' or 'e' or 'i' or 'u' or 'y' or 'A' or 'E' or 'I' or 'O' or 'U' or 'Y' then
            syllable:=syllable+1;
      end if;
end loop;
      
--Ada.Text_IO.New_Line;
--Calculates the variables
alpha:=syllable/word;
beta:=word/sentence;
index:=209.835-(alpha*84.6)-(beta*1.015);
grade:=(alpha*11.8)+(beta*0.39)-15.59;
--Prints the variables
Put_Line(Item=>"Words: " &Float'image(word));
Put_Line(Item=>"Sentences: " &Float'image(sentence));
Put_Line(Item=>"Syllables: " &Float'image(syllable));
Put_Line(Item=>"Index: " &Float'image(index));
Put_Line(Item=>"Grade: " &Float'image(grade));

end flesch;
