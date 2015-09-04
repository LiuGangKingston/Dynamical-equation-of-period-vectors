program t1
use period_acceleration_mdl
implicit none
real*8 :: mass(3)
real*8 :: period(3,3)
real*8 :: in_s(3,3)
real*8 :: ex_s(3,3)
real*8 :: acct(3,3)

period=0.0d0
period(1,1)=1.0d0
period(2,2)=2.0d0
period(3,3)=3.0d0
mass=(/1.0d0,2.0d0,4.0d0/)
in_s=0.0d0
in_s(1,1)=14.0d0
in_s(2,2)=15.0d0
in_s(3,3)=16.0d0
ex_s=0.0d0
       call ACCELERATION_OF_PERIODS(mass,period,in_s,ex_s,acct)
print*,"acct: "
print*, acct(1:3,1)
print*, acct(1:3,2)
print*, acct(1:3,3)

stop 
end

