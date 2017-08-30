import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.util.*;
import java.io.*;
public class parse
{
	public static void main(String[] args)
	{
		int word = 0;
		int syllable = 0;
		int sentence = 0;
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
		System.out.println("Flesch Index: " + index);
		System.out.println("Flesch Grade: " + grade);
	}
}
