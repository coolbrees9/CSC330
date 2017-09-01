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
		String vowel = "aeiouy";
		double alpha = 0.0;
		double beta = 0.0;
		try
		{
			//Goes into the file entered
			File input = new File(args[0]);
			Scanner file = new Scanner(input);
			while(file.hasNext())
			{
				String line = file.next().trim();
				//If statement that checks for sentences 
				if(line.contains(".") || line.contains(":") || line.contains(";") || line.contains("?") || line.contains("!"))
					sentence++;
				//For loop to go through length of a word and count # of syylables
				for(int i = 0; i < line.length(); i++)
				{
					//Checks if the current char is a vowel
					if(Vowel(line.charAt(i)))
					{
						syllable++;
						//Checks if next letter is syllable
						if(Vowel(line.charAt(i+1)));
							syllable--;
					}
					//Checks if the word ends with an e
					if(i == line.length()-1 && line.charAt(i) == 'e')
						syllable--;
				}
				word++;
			}
			file.close();
		}catch(Exception ex){}
		alpha = syllable / word;
		beta = word / sentence;
		//Formulas for calculating index and grade
		int index = (int) Math.round((206.835 - (alpha * 84.6) - (beta * 1.015)) * 1) / 1;
		double grade = Math.round(((alpha * 11.8) - (beta * .39) - 15.59) * 10) / 10;
		//System.out.println("Number of words in file: " + word);
		//System.out.println("Number of sentences: " + sentence);
		System.out.println("Number of syllables: " + syllable);
		System.out.println("Flesch Index: " + index);
		System.out.println("Flesch Grade: " + grade);
	}
	//Method that checks all vowels and returns true if is a vowel
	public static boolean Vowel(char v)
	{
		if(v == 'a' || v == 'e' || v == 'i' || v == 'o'|| v == 'u' || v == 'y')
			return true;
		else
			return false;
	}
}
