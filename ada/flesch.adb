--Program that opens the file entered and returns the Flesch index and grade
with Ada.Text_IO,Ada.IO_Exceptions,Ada.Command_Line,Ada.Strings,Ada.Strings.Fixed, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Command_Line;
use Ada.Text_IO,Ada.IO_Exceptions,Ada.Command_Line,Ada.Strings,Ada.Strings.Fixed, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Command_Line;

procedure flesch is

--Variable declarations
In_File :File_Type;
value :Character;
string_array :array(1..10000000)of Character;
pos :Integer;
word, sentence, syllable :Float:= 0.0;
isWord :boolean:= false;
alpha, beta, index, grade :Float;
vcount :Integer:= 0;

begin
--Opens the file from the command line
Open(File=>In_File,Mode=>Ada.Text_IO.In_File,Name=>Argument(1));

pos:= 0;
--Loop that goes through entire file and puts it in string_array
while not End_of_File(In_File) loop
      Get(File=>In_File,Item=>value);
      pos := pos + 1;
      string_array(pos):=value;
      if(End_of_File(In_File)) then
            pos := pos + 1;
            --string_array(pos) := Character'Val(10);  --Takes next line as a space using the ASCII for newline
            --pos := pos + 1;
      end if;
end loop;

exception
when Ada.IO_Exceptions.END_ERROR=>Ada.Text_IO.Close(File=>In_File); -- When reaches the end it closes file
--Does the word count
for i in 1..pos loop
      if (string_array(i) = ' ' and isWord = true) then  --end of word
            isWord:=False;
      elsif (string_array(i) /= '_' and isWord = false) then  --beginning of word
            isWord:=True;
      word := word + 1.0;
      else
            null;
      end if;
end loop;
--Checks for the sentence count based on punctuation marks
for i in 1..pos loop
      if (string_array(i) = '.') or 
      (string_array(i) = '?') or 
      (string_array(i) = '!') or 
      (string_array(i) = ';') or
      (string_array(i) = ':') then
           sentence := sentence + 1.0;
      end if;
end loop;
--Checks for vowels at current index
for i in 1..pos loop
      if (string_array(i) = 'a') or 
      (string_array(i) = 'e') or 
      (string_array(i) = 'i') or
      (string_array(i) = 'o') or 
      (string_array(i) = 'u') or 
      (string_array(i) = 'y') or
      (string_array(i) = 'A') or 
      (string_array(i) = 'E') or 
      (string_array(i) = 'I') or 
      (string_array(i) = 'O') or 
      (string_array(i) = 'U') or 
      (string_array(i) = 'Y') then
            syllable := syllable + 1.0;
            vcount := vcount + 1;
            --If adjacent index is vowel then decrements the syllable
            if (string_array(i) = 'a' and i < string_array'Size - 1) or
            (string_array(i+1) = 'e' and i < string_array'Size - 1) or
            (string_array(i+1) = 'i' and i < string_array'Size - 1) or
            (string_array(i+1) = 'o' and i < string_array'Size - 1) or
            (string_array(i+1) = 'u' and i < string_array'Size - 1) or
            (string_array(i+1) = 'y' and i < string_array'Size - 1) or
            (string_array(i+1) = 'A' and i < string_array'Size - 1) or
            (string_array(i+1) = 'E' and i < string_array'Size - 1) or
            (string_array(i+1) = 'I' and i < string_array'Size - 1) or
            (string_array(i+1) = 'O' and i < string_array'Size - 1) or
            (string_array(i+1) = 'U' and i < string_array'Size - 1) or
            (string_array(i+1) = 'Y' and i < string_array'Size - 1) then
                  syllable := syllable - 1.0;
            end if;
      end if;
      --If last letter ends in e increments syllable
      if (string_array(i+1) = ' ' and string_array(i) = 'e' and vcount > 1) then
                  syllable := syllable + 1.0;
                  vcount := 0;
      end if;
      --Resets vcount at end of string
      if (i = string_array'SIZE) then
            vcount := 0;
      end if;
end loop;
      
--Calculates the variables
alpha := syllable/word;
beta := word/sentence;
index := 209.835-(alpha*84.6)-(beta*1.015);
grade := (alpha*11.8)+(beta*0.39)-15.59;
--Prints the variables
--Put_Line(Item=>"Alpha: " &Float'image(alpha));
--Put_Line(Item=>"beta: " &Float'image(beta));
--Put_Line(Item=>"Words: " &Float'image(word));
--Put_Line(Item=>"Sentences: " &Float'image(sentence));
--Put_Line(Item=>"Syllables: " &Float'image(syllable));
Put("Index: ");
--Converts the index to integer and rounds it
Ada.Integer_Text_IO.Put(Integer(index));
Put_Line("");
Put("Flesch Grade: ");
--Makes the grade only have 1 decimal place with no exponents
Ada.Float_Text_IO.Put(grade,aft => 1, exp => 0);
Put_Line("");

end flesch;
