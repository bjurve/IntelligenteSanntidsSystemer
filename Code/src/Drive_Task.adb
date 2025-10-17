with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with DFR0548;
with Ada.Real_Time; use Ada.Real_Time;
with Ultrasonic_Detect;

package body Drive_Task is
   task body Motor_Control is
      Speed  : constant := 3000;
      Period : constant Time_Span := Milliseconds (50);
      Next   : Time := Clock;
   begin
      loop
         if Ultrasonic_Detect.Obstacle_Near then
            Drive (Forward, (0, 0, 0, 0));  -- stopp
         else
            Drive (Forward, (Speed, Speed, Speed, Speed));
         end if;

         Next := Next + Period;
         delay until Next;
      end loop;
   end Motor_Control;
end Drive_Task;
