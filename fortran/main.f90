! Ervin Pangilinan
! CSC 330: Organization of Programming Languages
! Project 1: Base 10 Happy Numbers Norms
! Main Program in Fortran 90

program Main

    implicit none

    integer :: arg1
    integer :: arg2
    character(len = 15) :: str
    character(len = 15) :: str2

    ! Step 1: Get range from input
    write(*, "(a)", advance = "no") "First Argument: "
    read(*, *) str
    read(str, *) arg1

    write(*, "(a)", advance = "no") "Second Argument: "
    read(*, *) str2
    read(str2, *) arg2

    ! Step 2: Determine if each number in range is happy

    ! Step 3: Find norm of happy number

    ! Step 4: Keep track of happy numbers with the highest norms.


end program Main
