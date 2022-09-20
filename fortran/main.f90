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
                sum = sum + (digit ** 2)
                counter = counter / 10  
            end do

        end function digit_sum

        logical function is_happy(number) result(happy)
            ! PRE: Integer passed in is within the user-specified range. 
            ! POST: Returns a boolean if the integer is happy. 
            implicit none

            integer, intent(in) :: number
            integer :: count
            happy = .true.

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

        real function find_norm(number) result(norm)
            ! PRE: Passed argument is a happy number. 
            ! POST: Returns the norm of the happy number. 
            implicit none

            integer, intent(in) :: number
            integer :: counter
            real :: sum

            counter = number
            sum = (number ** 2) + 1
            do while (counter /= 1)
                counter = digit_sum(counter)
                sum = sum + (counter ** 2)
            end do
            norm = sqrt(sum)

        end function find_norm

        subroutine selection_sort(numbers, norms)
            ! PRE: Parallel arrays for happy numbers and norms are size 10 when passed in. 
            ! POST: Sorts arrays by descending norms in quadratic time. 
            implicit none

            integer, intent(inout) :: numbers(:)
            real, intent(inout) :: norms(:)

            ! Used for swaps. 
            integer :: temp_val
            real :: temp_norm

            ! Keeps track of indices. 
            integer :: index, length, max, next

            length = size(numbers)
            max = 1
            do index = 1, length
                max = index
                do next = max + 1, length
                    if (norms(index) > norms(max)) then
                        max = next
                    end if

                    if (max /= index) then
                        ! Temp variables are on current index
                        temp_val = numbers(index)
                        temp_norm = norms(index)

                        ! Index swaps to the maximum value
                        numbers(index) = numbers(max)
                        norms(index) = norms(max)

                        ! Max values gets the temp
                        numbers(max) = temp_val
                        norms(max) = temp_norm

                    end if
                end do
            end do

        end subroutine selection_sort

end module happy_nums

program main
    ! POST: Outputs the 10 happy numbers with the highest norms.
    use happy_nums
    implicit none

    ! Parallel arrays to store happy number and its norm. 
    integer :: values(10)
    real :: norms(10)

    ! Estabishes the bounds to find happy numbers. 
    integer :: lower
    integer :: upper

    ! To be used with swaps. 
    integer :: temp
    real :: temp_norm

    ! To be used with iterations. 
    integer :: current
    integer :: counter
    character(len = 20) :: str

    ! Establish upper and lower bounds from input
    write(*, "(a)", advance = "no") "First Argument: "
    read(*, *) str                  ! Converts string to integer
    read(str, *) lower

    write(*, "(a)", advance = "no") "Second Argument: "
    read(*, *) str
    read(str, *) upper

    if (lower > upper) then
        temp = lower
        lower = upper
        upper = temp
    end if

    ! Check each integer that falls within bounds of range. 
    counter = 1
    do current = lower, upper
        write(str, *) current
        if (is_happy(current) .eqv. .true.) then
            temp_norm = find_norm(current)

            if (counter < 10) then
                values(counter) = current
                norms(counter) = temp_norm   
                counter = counter + 1   
            else
                ! Keep track of happy numbers with the highest norms.
                if (temp_norm > minval(norms)) then
                    norms(minloc(norms)) = temp_norm
                    values(minloc(norms)) = current
                end if
            end if
        end if
    end do

    if (counter <= 10) then
        do counter = counter, 10
            values(counter) = 0
            norms(counter) = 0
        end do
    end if

    call selection_sort(values, norms)

    do counter = 1, 10
        if (norms(counter) /= 0) then
            write(str, "(i20)") values(counter)
            write(*, "(a)") trim(adjustl(str))
        else 
            exit
        end if
    end do

end program main
