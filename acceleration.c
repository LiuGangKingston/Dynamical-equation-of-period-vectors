#include <stdio.h>
#include <stdlib.h>


void Acceleration_of_PERIODS( double * alphas,
                              double * current_periods,
                              double * internal_stress,
                              double * external_stress,
                              double * period_accelerations )
{    double cell_surfaces[3][3], cell_volume;
     int               i, j, i3j, k, l, m, n;

     for(i=0; i<3; i++)
        {j = (i+1)%3;
         k = (j+1)%3;
         for(l=0; l<3; l++)
            {m = (l+1)%3;
             n = (m+1)%3;
             cell_surfaces[i][l] =
                 current_periods[j*3+m] * current_periods[k*3+n]
               - current_periods[j*3+n] * current_periods[k*3+m];
            }
        }

     cell_volume = cell_surfaces[0][0] *  current_periods[0]
                 + cell_surfaces[0][1] *  current_periods[1]
                 + cell_surfaces[0][2] *  current_periods[2];

     if(cell_volume < 1.0e-10)
       {printf(" Sorry, too small or negative cell volume: ");
        printf(" %f .\n", cell_volume);
        exit(0);
       }

     for(i=0; i<3; i++)
        {for(j=0; j<3; j++)
            {i3j = i * 3 + j;
             period_accelerations[i3j] = 0.0000000000000000000e0;
             for(k=0; k<3; k++)
                {period_accelerations[i3j]  +=
                    (internal_stress[j*3+k] + external_stress[j*3+k]) *
                                                 cell_surfaces[i][k]  ;
                }
             period_accelerations[i3j] = period_accelerations[i3j]
                                       / alphas[i]               ;
            }
        }
}

