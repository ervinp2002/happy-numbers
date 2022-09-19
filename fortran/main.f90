! Ervin Pangilinan
! CSC 330: Organization of Programming Languages
! Project 1: Base 10 Happy Numbers Norms
! Main Program in Fortran 90

module happy_nums
    ! Contains functions for happy numbers.
    implicit none

    contains
        integer function digit_sum(number) result(sum)
            ! PRE: An integer is passed in. 
            ! POST: Returns the squared digit sum of the integer. 
            implicit none

            integer, intent(in) :: number
            integer :: digit
            integer :: counter

            sum = 0
            counter = number
            do while (counter /= 0)
                digit = mod(counter, 10)
                sum = digit ** 2
                counter = counter / 10  
            end do

        end function digit_sum

        logical function is_happy(number) result(happy)
            ! PRE: Integer passed in is within the user-specified range. 
            ! POST: Returns a boolean if the integer is happy. 
            implicit none

            integer, intent(in) :: number
            integer :: count

            ! Unhappy numbers will always have 4 in their sequence. 
            count = number
            do while (count /= 1 .and. count /= 4)
                count = digit_sum(count)
            end do

            if (count == 1) then
                happy = .true.
            else
                happy = .false.
            end if

        end function is_happy

end module happy_nums

program main
    ! POST: Outputs the 10 happy numbers with the highest norms.
    use happy_nums
    implicit none

    integer :: list(10)
    integer :: arg1
    integer :: arg2
    character(len = 20) :: str
    character(len = 20) :: str2

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

end program main
