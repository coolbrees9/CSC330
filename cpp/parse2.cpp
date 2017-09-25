//This program will go through the file entered at the command line and give the flesh index and grade
#include<iostream>
#include<iomanip>
#include<string>
#include<cstdlib>
#include<fstream>
#include<sstream>
using namespace std;
bool Vowel(char v);
static bool Sentence(char s);
static bool Number(char l);
int main(int argc,char* argv[])
{
      //If no arg is entered, goes here
      if(argc <= 1)
      {
            cout<< "Must choose a file" << endl;
            exit(0);
      }
      //Variable declarations
      int word = 0;
      int syllable = 0;
      int sentence = 0;
      int vcount = 0;
      string line;
      ifstream infile;
      //Goes into the file entered
      string filename = argv[1];
      infile.open(filename.c_str());
      getline(infile, line);
      //Goes through the entire file
      while(!infile.eof())
      {
            infile >> line;
            word++;
            //For loop to go through length of a word and count # of syllables
            for(int i = 0; i < line.size(); i++)
            {
                  //Checks if the word is a number
                  if(Number(line[i]))
                  {
                        word--;
                        if(i < line.size()-1 && Number(line[i]))
                              word++;
                  }
                  //Checks if the current char is a vowel
                  if(Vowel(line[i]))
                  {
                        syllable++;
                        //Checks if adjacent letter is a vowel
                        if(i < line.size()-1 && Vowel(line[i+1]))
                        {
                              syllable--;
                        }
                        vcount++;
                  }
                  //Checks if the word ends with an e
                  if(i == line.size()-1 && line[i] == 'e' && vcount > 1)
                  {
                        syllable--;
                        vcount = 0;
                  }
                  //Checks for sentences
                  if(Sentence(line[i]))
                        sentence++;
                  //Resets vowel count
                  if(i == line.length()-1)
                        vcount = 0;
            }
      }
      infile.close();
      double alpha = (double) syllable / word;
      double beta = (double) word / sentence;
      //cout << alpha << endl;
      //cout << beta << endl;
      //Formulas for calculating index and grade
      int index = (int) (206.835-(alpha*84.6)-(beta*1.015));
      double grade = (((alpha * 11.8) + (beta * 0.39) - 15.59));
      //cout << "Number of words in file: " << word << endl;
      //cout << "Number of sentences: " << sentence << endl;
      //cout << "Number of syllables: " << syllable << endl;
      cout << "Flesch Index: " << index << endl;
      cout << "Flesch Grade: " << setprecision(1) << fixed << grade << endl;  //Rounds the variable to one place
      return 0;
}
//Method that checks all vowels and returns true if is a vowel
bool Vowel(char v)
{
      if(v == 'a' || v == 'e' || v == 'i' || v == 'o' || v == 'u' || v == 'y' || v == 'A' || v == 'E' || v == 'I' || v == 'O' || v == 'U' || v == 'Y')
            return true;
      else
            return false;
}
//Method for checking sentences
static bool Sentence(char s)
{
      if(s == '.' || s == '?' || s == '!' || s == ';' || s == ':')
            return true;
      else 
            return false;
}
//Method for checking if character is number
static bool Number(char l)
{     
      if(l == '0' || l == '1' || l == '2' || l == '3' || l == '4' || l == '5' || l == '6' || l == '7' || l == '8' || l == '9')
            return true;
      else
            return false;
}
