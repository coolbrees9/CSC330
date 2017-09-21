program reader
implicit none

character, dimension(:),allocatable::long_string
integer::filesize
!Variable declarations
integer(8), parameter::length=5000000
integer::ierr,nwords,i,j
character,dimension(:),allocatable::word(:)
real::syllable= 0.0
real::sentence= 0.0
real::alpha, beta, findex, grade

interface
subroutine read_file(string,filesize)
character,dimension(:),allocatable::string
integer::filesize
end subroutine read_file
end interface

call read_file(long_string,filesize)
!Counts words
word=""
read(long_string,*,iostat=ierr) word
nwords = count(word/="")
!Loop to check for punctuations
do i=0,len(long_string)
select case(long_string(i))
      case(".")
      sentence = sentence + 1
      case("?")
      sentence = sentence + 1
      case("!")
      sentence = sentence + 1
      case(";")
      sentence = sentence + 1
      case(":")
      sentence = sentence + 1
end select
end do
!Counts the vowels
do j=0,len(long_string)
select case(long_string(j))
      case('a','e','i','o','u','y','A','E','I','O','U','Y')
      syllable = syllable + 1
end select
end do
print*,"READ",filesize,"characters."
alpha = syllable/nwords
beta = nwords/sentence;
!Calculations for the index and grade
findex = 206.835-(alpha*84.6)-(beta*1.015)
grade = (alpha*11.8)+(beta*.39)-15.59
print*,"Words: ",nwords
print*,"Sentences: ", sentence
print*,"Syllables: ", syllable
print*,"Index: ", findex
print*,"Grade: ", grade

end program reader

subroutine read_file(string,filesize)

character,dimension(:),allocatable::string
integer::counter
integer::filesize
character(LEN=1)::input
character(LEN=50)::arg
!Sets arg equal to the file entered
call getarg(1,arg)
if(iargc() == 0) then
      print*, "Must input a file."
      read*, arg
endif

inquire(file=arg,size=filesize)
open(unit=5,status="old",access="direct",form="unformatted",recl=1,file=arg)
allocate(string(filesize))

counter=1
100 read(5,rec=counter,err=200)input
      string(counter:counter)=input
      counter=counter+1
      goto 100
200 continue
counter=counter-1

close(5)
end subroutine read_file
