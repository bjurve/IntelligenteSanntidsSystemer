with Ada.Real_Time; use Ada.Real_Time;
with Types; use Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body Motors is
   period : constant Time_Span := Milliseconds(20); -- motor oppdateres hvert 20 ms


   procedure Drive(Left, Right : Integer) is
   begin
      Command.Set(Left, Right);
   end Drive;

   procedure Stop is
   begin
      Command.Stop;
   end Stop;

      type Motor_Command_Type is record
         L, R : Integer;
      end record;



   task body Actuator_Task is
      Next : Time := Clock; -- neste kjøringstid
      Motor_Command : Motor_Command_Type;

   begin
      loop
         Motor_Command := Command.Get;  -- leser begge kanalene samtidig
         --koble til motor-driveren her:
         Set_Left_PWM(Motor_Command.L);
         Set_Right_PWM(Motor_Command.R);




         next := next + Period; -- scheduler neste kjøringstid
         delay until next;
      end loop;
   end Actuator_Task;
end Motors;
