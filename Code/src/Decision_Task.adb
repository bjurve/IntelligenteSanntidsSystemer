with Sensor_Task;    use Sensor_Task;
with Drive_Task;     use Drive_Task;
with Ada.Real_Time;  use Ada.Real_Time;
with System;
with MicroBit.Console; use MicroBit.Console;
package body Decision_Task is

   Stop_cm    : constant Integer:= 15;
   stop_ms    : constant Time_Span := Milliseconds (400);
   Reverse_ms : constant Time_Span := Milliseconds (800);
   Turn_ms    : constant Time_Span := Milliseconds (1200);
   type State_Type is (Moving_Forward, Stopping, Reversing, Turning);
   State : State_Type := Moving_Forward;
   Phase_End : Time := Clock;

   task body Decision is
      Period : constant Time_Span := Milliseconds (50);
      Next   : Time := Clock;
      L, R   : Integer;
   begin
      loop



         L := Left_Distance;  if L < 1 then L := 300; end if;
         R := Right_Distance; if R < 1 then R := 300; end if;

         case State is
            when Moving_Forward =>
               if Integer'Min (L, R) < Stop_cm then
                  Set_Command (Stop);
                  State     := Stopping;
                  Phase_End := Clock + Stop_ms;
               else
                  Set_Command (Go_Forward);
               end if;

            when Stopping =>
               if Clock >= Phase_End then
                  Set_Command (Reverse_Car);
                  State     := Reversing;
                  Phase_End := Clock + Reverse_ms;
               end if;

            when Reversing =>
               if Clock >= Phase_End then
                  Set_Command (Turn_Left);
                  State     := Turning;
                  Phase_End := Clock + Turn_ms;
               end if;

            when Turning =>
               if Clock >= Phase_End then
                  Set_Command (Go_Forward);
                  State := Moving_Forward;
               end if;
         end case;

         Next := Next + Period;
         delay until Next;
      end loop;
   end Decision;

end Decision_Task;


