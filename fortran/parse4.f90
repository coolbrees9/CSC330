!Program that opens file entered and returns the flesch index and grade
program flesch
implicit none

integer::filesize
!Variable declarations
integer::nwords,nsentence,nsyllable,pos,pos2,pos3,i,j,k
real::alpha, beta, grade
integer::findex
character (LEN=8000000)::long_string
character (LEN=1)::input
integer::counter
character(LEN=50)::arg
!Sets arg equal to the file entered
call getarg(1,arg)
!If no argument entered goes here
if(iargc() == 0) then
      print*, "Must input a file."
      read*, arg
endif
!Opens the file 
open(unit=5,status="old",access="direct",form="unformatted",recl=1,file=arg)

counter=1
100 read(5,rec=counter,err=200)input
      long_string(counter:counter)=input
      counter=counter+1
      goto 100
200 continue
counter=counter-1

close(5)
!Loop that gets word count
pos=1
nwords=0
loop: do
      i = verify(long_string(pos:), ' ')  !Sees if char at pos is whitespace
      if(i == 0) exit loop
      nwords = nwords + 1  !Increments nwords based on whitespace
      pos = pos + i - 1
      i = scan(long_string(pos:), ' ')
      if(i == 0 ) exit loop
      pos = pos + i - 1
end do loop
!Loop that gets sentence count
pos2=1
nsentence=0
loop2: do
      j = verify(long_string(pos2:), '.?!;:')  !Sees if char at pos is a punct
      if(j == 0) exit loop2
      nsentence = nsentence + 1  !Increments nsentence based on puntuations
      pos2 = pos2 + j - 1
      j = scan(long_string(pos2:), '.?!;:')
      if(j == 0 ) exit loop2
      pos2 = pos2 + j - 1
end do loop2
!Loop that gets syllable count
pos3=1
nsyllable=0
loop3: do
      k = verify(long_string(pos3:), 'aeiouy')  !Sees if char at pos is a vowel
      if(k == 0) exit loop3
      nsyllable = nsyllable + 1  !Increments nsyllable based on vowel
      pos3 = pos3 + k - 1
      k = scan(long_string(pos3:), 'aeiouy')
      if(k == 0 ) exit loop3
      pos3 = pos3 + k - 1
end do loop3
!Casts variables as real to have decimal places
alpha = real(nsyllable)/real(nwords)
beta = real(nwords)/real(nsentence)
!print*,"Alpha: ", alpha
!print*,"Beta: ", beta
!Calculations for the index and grade
findex = nint(((206.835-(alpha*84.6)-(beta*1.015))))
grade = ((alpha*11.8)+(beta*0.39)-15.59)
!print*,"Words: ", nwords
!print*,"Sentences: ", nsentence
!print*,"Syllables: ", nsyllable
print*,"Index: ", findex
write(*,'("Grade: ", f12.1)') grade  !Rounds grade to one decimal place

end program flesch
