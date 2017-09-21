program reader
implicit none

integer::filesize
!Variable declarations
integer::nwords,nsentence,nsyllable
real::alpha, beta, findex, grade

character (LEN=5000000)::long_string
character (LEN=1)::input
integer::counter
character(LEN=50)::arg
!Sets arg equal to the file entered
call getarg(1,arg)
if(iargc() == 0) then
      print*, "Must input a file."
      read*, arg
endif

open(unit=5,status="old",access="direct",form="unformatted",recl=1,file=arg)

counter=1
100 read(5,rec=counter,err=200)input
      long_string(counter:counter)=input
      counter=counter+1
      goto 100
200 continue
counter=counter-1

close(5)
!Calls the subroutines
call countWords(long_string,nwords)
call countSentence(long_string,nsentence)
call countSyllable(long_string,nsyllable)
alpha = nsyllable/nwords
beta = nwords/nsentence;
!Calculations for the index and grade
findex =float(int((206.835-(alpha*84.6)-(beta*1.015))*1000.0+0.5))/1000.0
grade = (((alpha*11.8)+(beta*0.39)-15.59)*1000.0)/1000.0
print*,"Words: ", nwords
print*,"Sentences: ", nsentence
print*,"Syllables: ", nsyllable
print*,"Index: ", findex
print*,"Grade: ", grade

end program reader
!Subroutine that counts words
subroutine countWords(string, word)
character(LEN=*)::string
integer::word,pos,i
pos=1
words=0
loop: do
      i = verify(string(pos:), ' ')
      if(i == 0) exit loop
      words = words + 1
      pos = pos + i - 1
      i = scan(string(pos:), ' ')
      if(i == 0 ) exit loop
      pos = pos + i - 1
end do loop
end subroutine countWords
!Subroutine that counts sentences
subroutine countSentence(string, sentence)
character(LEN=*)::string
integer::sentence,pos,i
pos=1
sentence=0
loop: do
      i = verify(string(pos:), '.?!;:')
      if(i == 0) exit loop
      sentence = sentence + 1
      pos = pos + i - 1
      i = scan(string(pos:), '.?!;:')
      if(i == 0 ) exit loop
      pos = pos + i - 1
end do loop
end subroutine countSentence
!Subroutine that counts syllables
subroutine countSyllable(string, syllable)
character(LEN=*)::string
integer::syllable,pos,i
pos=1
syllable=0
loop: do
      i = verify(string(pos:), 'aeiouyAEIOUY')
      if(i == 0) exit loop
      syllable = syllable + 1
      pos = pos + i - 1
      i = scan(string(pos:), 'aeiouyAEIOUY')
      if(i == 0 ) exit loop
      pos = pos + i - 1
end do loop
end subroutine countSyllable
