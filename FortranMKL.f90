program FortranMKL
    use iso_c_binding
    use blas95

    implicit none

    integer, parameter :: N = 20000
    integer, parameter :: M = 20000
    integer, parameter :: K = 20000

    real(C_DOUBLE), dimension(N, K) :: A
    real(C_DOUBLE), dimension(K, M) :: B
    real(C_DOUBLE), dimension(N, M) :: C

    integer :: lda, ldb, ldc
    real(C_DOUBLE) :: alpha, beta

    integer :: i, j
    real(8) :: end_time, start_time

    call random_number(A)
    call random_number(B)

    lda = N
    ldb = K
    ldc = N
    alpha = 1.0
    beta = 0.0

    call cpu_time(start_time)

    do j = 1, M
        do i = 1, N
            C(i, j) = 0.0
        end do
    end do

    call dgemm('N', 'N', N, M, K, alpha, A, lda, B, ldb, beta, C, ldc)

    call cpu_time(end_time)

    print *, "Time with Fortran MKL:", end_time - start_time, "seconds"
    
end program FortranMKL

