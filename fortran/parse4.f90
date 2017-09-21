program reader
implicit none

integer::filesize
!Variable declarations
integer(8), parameter::length=5000000
integer::pos,pos2,pos3,i,j,k,nwords,nsentence,nsyllable
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

!Counts words
nwords=0
pos=1
loop:do 
      i = verify(long_string(pos:), ' ')
      if(i == 0) exit loop
      nwords = nwords + 1
      pos = pos + i - 1
      i = scan(long_string(pos:), ' ')
      if(i == 0 ) exit loop
      pos = pos + i - 1
end do loop
pos2=1
nsentence=0
!Loop to check for punctuations
loop:do
      j = verify(long_string(pos2:), '.?!;:')
      if(j == 0) exit loop
      nsentence = nsentence + 1
      pos2 = pos2 + j - 1
      j = scan(long_string(pos2:), '.?!;:')
      if(j == 0 ) exit loop
       pos2 = pos2 + j - 1
end do loop
alpha = nsyllable/nwords
beta = nwords/nsentence;
!Calculations for the index and grade
findex =float(int((206.835-(alpha*84.6)-(beta*1.015))*1000.0+0.5))/1000.0
grade = (((alpha*11.8)+(beta*.39)-15.59)*1000.0)/1000.0
print*,"Words: ", nwords
print*,"Sentences: ", nsentence
print*,"Syllables: ", nsyllable
print*,"Index: ", findex
print*,"Grade: ", grade

end program reader
