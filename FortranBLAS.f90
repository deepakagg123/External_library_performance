program FortranBLAS
    implicit none

    integer, parameter :: N = 20000
    integer, parameter :: M = 20000
    integer, parameter :: K = 20000

    real(8), dimension(N, K) :: A
    real(8), dimension(K, M) :: B
    real(8), dimension(N, M) :: C

    integer :: lda, ldb, ldc
    real(8) :: alpha, beta

    integer :: i, j
    real(8) :: start_time, end_time  ! Declare the timing variables
    
    call random_number(A)
    call random_number(B)

    lda = N
    ldb = K
    ldc = N
    alpha = 1.0d0
    beta = 0.0d0

    call cpu_time(start_time)

    do j = 1, M
        do i = 1, N
            C(i, j) = 0.0d0
        end do
    end do

    call dgemm('N', 'N', N, M, K, alpha, A, lda, B, ldb, beta, C, ldc)

    call cpu_time(end_time)

    print *, "Time with Fortran BLAS:", end_time - start_time, "seconds"
    
end program FortranBLAS

