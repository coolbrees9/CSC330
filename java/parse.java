//This program will take the Flesch index and grade of the file that is put into the command line
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.util.*;
import java.io.*;
public class parse
{
      public static void main(String[] args)
      {
            //Variable declarations
            int word = 0;
            int syllable = 0;
            int sentence = 0;
            int vcount = 0;
            String line;
            try
            {
                  //Goes into the file entered
                  File input = new File(args[0]);
                  Scanner file = new Scanner(input);
                  //Loop to go through entire file
                  while(file.hasNext())
                  {
                        //Gets rid of whitespace
                        line = file.next().trim();
                        word++;
                        //For loop to go through length of a word and count # of syllables
                        for(int i = 0; i < line.length(); i++)
                        {
                              //Checks if the word is a number
                              if(Number(line.charAt(i)))
                              {
                                    word--;
                                    if(i < line.length()-1 && Number(line.charAt(i+1)))
                                          word++;
                              }
                              //Checks if the current char is a vowel
                              if(Vowel(line.charAt(i)))
                              {
                                    syllable++;
                                    //Checks if vowel is adjacent to another vowel
                                    if(i < line.length()-1 && Vowel(line.charAt(i+1)))
                                    {
                                          syllable--;
                                    }
                                    vcount++;
                              }
                              //Checks if the word ends with an e
                              if(i == line.length()-1 && line.charAt(i) == 'e' && vcount > 1)
                              {
                                    syllable--;
                                    vcount = 0;
                              }
                              //Checks for sentences
                              if(Sentence(line.charAt(i)))
                                    sentence++;
                              //Resets vowel count
                              if(i == line.length()-1)
                                    vcount = 0;
                        }
                  }
                  file.close();
            }catch(Exception ex){}
            double alpha = (double) syllable / word;
            double beta = (double) word / sentence;
            //System.out.println(alpha);
            //System.out.println(beta);
            //Formulas for calculating index and grade
            int index = (int) Math.round((206.835-(alpha*84.6)-(beta*1.015))*1)/1;
            double grade = Math.round(((alpha * 11.8) + (beta * 0.39) - 15.59)*10.0)/10.0;
            //System.out.println("Number of words in file: " + word);
            //System.out.println("Number of sentences: " + sentence);
            //System.out.println("Number of syllables: " + syllable);
            System.out.println("Flesch Index: " + index);
            System.out.println("Flesch Grade: " + grade);
      }
      //Method that checks all vowels and returns true if is a vowel
      public static boolean Vowel(char v)
      {
            if(v == 'a' || v == 'e' || v == 'i' || v == 'o' || v == 'u' || v == 'y' || v == 'A' || v == 'E' || v == 'I' || v == 'O' || v == 'U' || v == 'Y')
                  return true;
            else
                  return false;
      }
      //Method for checking sentences
      public static boolean Sentence(char s)
      {
            if(s == '.' || s == '?' || s == '!' || s == ';' || s == ':')
                  return true;
            else 
                  return false;
      }
      //Method to check for numbers
      public static boolean Number(char l)
      {
            if(l == '0' || l == '1' || l == '2' || l == '3' || l == '4' || l == '5' || l == '6' || l == '7' || l == '8' || l == '9')
                  return true;
            else
                  return false;
      }
}
