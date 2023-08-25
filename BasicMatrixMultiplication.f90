program BasicMatrixMultiplication
    implicit none

    integer, parameter :: N = 20000
    integer, parameter :: M = 20000
    integer, parameter :: K = 20000

    real(8), dimension(N, K) :: A
    real(8), dimension(K, M) :: B
    real(8), dimension(N, M) :: C

    integer :: i, j, q
    real(8) :: start_time, end_time  ! Declare the timing var

    ! Initialize matrices A and B with random values
    do j = 1, K
        do i = 1, N
            A(i, j) = rand()
        end do
    end do

    do j = 1, M
        do i = 1, K
            B(i, j) = rand()
        end do
    end do

    call cpu_time(start_time)
    ! Perform matrix multiplication
    do j = 1, M
        do i = 1, N
            C(i, j) = 0.0
            do q = 1, K
                C(i, j) = C(i, j) + A(i, q) * B(q, j)
            end do
        end do
    end do
    call cpu_time(end_time)

    print *, "Time without ext library in seconds:", end_time - start_time

end program BasicMatrixMultiplication
