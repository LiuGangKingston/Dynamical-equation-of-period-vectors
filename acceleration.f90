MODULE PERIOD_ACCELERATION_MDL
    INTERFACE
         SUBROUTINE ACCELERATION_OF_PERIODS( ALPHAS, &
                                    CURRENT_PERIODS, &
                                    INTERNAL_STRESS, &
                                    EXTERNAL_STRESS, &
                               PERIOD_ACCELERATIONS   )
             IMPLICIT NONE
             REAL*8, INTENT(IN) :: ALPHAS(3),            &
                                   CURRENT_PERIODS(3,3), &
                                   INTERNAL_STRESS(3,3), &
                                   EXTERNAL_STRESS(3,3)
             REAL*8, INTENT(OUT):: PERIOD_ACCELERATIONS(3,3)
         END SUBROUTINE ACCELERATION_OF_PERIODS
    END INTERFACE
END MODULE PERIOD_ACCELERATION_MDL




         SUBROUTINE ACCELERATION_OF_PERIODS( ALPHAS, &
                                    CURRENT_PERIODS, &
                                    INTERNAL_STRESS, &
                                    EXTERNAL_STRESS, &
                               PERIOD_ACCELERATIONS   )
             IMPLICIT NONE
             REAL*8, INTENT(IN) :: ALPHAS(3),            &
                                   CURRENT_PERIODS(3,3), &
                                   INTERNAL_STRESS(3,3), &
                                   EXTERNAL_STRESS(3,3)
             REAL*8, INTENT(OUT):: PERIOD_ACCELERATIONS(3,3)
             REAL*8             :: CELL_SURFACES(3,3)
             REAL*8             :: CELL_VOLUME
             INTEGER            :: I, J, K, L, M, N

             DO I = 1, 3
                J = MOD(I, 3) + 1
                K = MOD(J, 3) + 1
                DO L = 1, 3
                   M = MOD(L, 3) + 1
                   N = MOD(M, 3) + 1
                   CELL_SURFACES(L,I) =                              &
                         CURRENT_PERIODS(M,J) * CURRENT_PERIODS(N,K) &
                       - CURRENT_PERIODS(N,J) * CURRENT_PERIODS(M,K)
                END DO
             END DO

             CELL_VOLUME = CELL_SURFACES(1,1) * CURRENT_PERIODS(1,1) &
                         + CELL_SURFACES(2,1) * CURRENT_PERIODS(2,1) &
                         + CELL_SURFACES(3,1) * CURRENT_PERIODS(3,1)

             IF(CELL_VOLUME <= 1.0D-10) THEN
                PRINT*, "Sorry, too small or negative cell volume:"
                PRINT*, CELL_VOLUME
                STOP
             END IF

             DO I = 1, 3
                DO J = 1, 3
                   PERIOD_ACCELERATIONS(J, I) = 0.0D0
                   DO K = 1, 3
                      PERIOD_ACCELERATIONS(J, I) = PERIOD_ACCELERATIONS(J, I) + &
                              (INTERNAL_STRESS(J, K) + EXTERNAL_STRESS(J, K)) * &
                                                          CELL_SURFACES(K, I)
                   END DO
                   PERIOD_ACCELERATIONS(J, I) = PERIOD_ACCELERATIONS(J, I) &
                                              / ALPHAS(I)
                END DO
             END DO

             RETURN
         END SUBROUTINE ACCELERATION_OF_PERIODS
