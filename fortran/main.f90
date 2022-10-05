! Ervin Pangilinan
! CSC 330: Organization of Programming Languages
! Project 1: Base 10 Happy Numbers Norms
! Main Program in Fortran 90

module happy_nums
    ! Contains procedures for happy numbers.
    implicit none

    contains
        integer(kind = 8) function digit_sum(number) result(sum)
            ! PRE: An integer is passed in. 
            ! POST: Returns the squared digit sum of the integer. 
            implicit none

            integer(kind = 8), intent(in) :: number
            integer(kind = 8) :: digit
            integer(kind = 8) :: counter

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

            integer(kind = 8), intent(in) :: number
            integer(kind = 8) :: count
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

        real(kind = 8) function find_norm(number) result(norm)
            ! PRE: Passed argument is a happy number. 
            ! POST: Returns the norm of the happy number. 
            implicit none

            integer(kind = 8), intent(in) :: number
            integer(kind = 8) :: counter
            integer(kind = 8) :: addend
            real(kind = 8) :: total
 
            if (number == 1) then 
                norm = 1.0
            else
                total = (number ** 2) + 1
                counter = number
                do while (counter /= 1)
                    addend = digit_sum(counter)
                    total = total + (addend * addend)
                    counter = addend
                end do   
            end if

            norm = sqrt(total)

        end function find_norm

        subroutine bubble_sort(numbers, norms)
            ! PRE: Parallel arrays are completely filled when passed in. 
            ! POST: Sorts by descending norms in quadratic time. 
            implicit none

            integer(kind = 8), intent(inout) :: numbers(:)
            real(kind = 8), intent(inout) :: norms(:)

            integer :: index
            logical :: needs_swap = .true.

            integer(kind = 8) :: temp_val
            real(kind = 8) :: temp_norm

            do while (needs_swap .eqv. .true.)
                needs_swap = .false.
                do index = 1, size(numbers) - 1
                    if (norms(index) < norms(index + 1)) then

                        ! Temp variables to hold current.
                        temp_val = numbers(index)
                        temp_norm = norms(index)

                        ! Move the bigger value-norm pair to the front.
                        numbers(index) = numbers(index + 1)
                        norms(index) = norms(index + 1)

                        ! Move the smaller value-norm pair to the back
                        numbers(index + 1) =  temp_val
                        norms(index + 1) = temp_norm

                        needs_swap = .true.

                    end if
                end do
            end do

        end subroutine bubble_sort

end module happy_nums

program main
    ! POST: Outputs the 10 happy numbers with the highest norms.
    use happy_nums
    implicit none

    ! Parallel arrays to store happy number and its norm. 
    integer(kind = 8) :: values(10)
    real(kind = 8) :: norms(10)

    ! Estabishes the bounds to find happy numbers. 
    integer(kind = 8) :: lower
    integer(kind = 8) :: upper

    ! To be used with swaps. 
    integer(kind = 8) :: temp
    real(kind = 8) :: temp_norm

    ! To be used with iterations. 
    integer(kind = 8) :: current
    integer :: counter
    integer :: save_count
    character(len = 20) :: str

    ! Establish upper and lower bounds from input.
    write(*, "(a)", advance = "no") "First Argument: "
    read(*, *) str
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
        if (is_happy(current) .eqv. .true.) then
            temp_norm = find_norm(current)

            ! Fill the parallel arrays if there are still empty indices. 
            if (counter < 10) then
                values(counter) = current
                norms(counter) = temp_norm   
                counter = counter + 1   
            else
                ! Push out minimum values when the parallel arrays are full. 
                if (temp_norm > minval(norms)) then
                    values(minloc(norms)) = current
                    norms(minloc(norms)) = temp_norm
                end if
            end if
        end if
    end do

    ! Initialize empty indices to 0. 
    save_count = counter ! Holds the last index with a non-zero element. 
    if (counter < 10) then
        do counter = counter, 10
            values(counter) = 0
            norms(counter) = 0
        end do
    end if

    call bubble_sort(values, norms)

    ! Convert happy numbers into strings.
    do counter = 1, 10 
        if (norms(counter) /= 0) then
            write(str, "(i20)") values(counter)
            write(*, "(a)") trim(adjustl(str))
        else 
            exit
        end if
    end do

    if (save_count == 1) then
        write(*, "(a)") trim(adjustl("NOBODY'S HAPPY :("))
    end if

end program main
