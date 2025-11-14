with HAL; use HAL;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with Ada.Real_Time; use Ada.Real_Time;
with System.Fat_Gen;
with System.Val_Util;
with MicroBit.Console; use MicroBit.Console;

package body Drive_Task is

   protected Command_Storage is
      procedure Set (Cmd : Movement_Command);
      function Get return Movement_Command;
   private
      Current : Movement_Command := Stop;
   end Command_Storage;

   protected body Command_Storage is
      procedure Set (Cmd : Movement_Command) is
      begin
         Current := Cmd;
      end Set;

      function Get return Movement_Command is
      begin
         return Current;
      end Get;
   end Command_Storage;

   procedure Set_Command (Cmd : Movement_Command) is
   begin
      Command_Storage.Set (Cmd);
   end Set_Command;

   task body Motor_Control is
      Speed  : constant := 3000;
      Period : constant Time_Span := Milliseconds (20);
      Next   : Time := Clock;
      Cmd    : Movement_Command;
   begin
      loop

         Cmd := Command_Storage.Get;

         case Cmd is
            when Go_Forward =>
               Drive (Forward, (Speed, Speed, Speed, Speed));
            when Turn_Left =>
               Drive (Rotating_Left, (-Speed, Speed, -Speed, Speed));
            when Turn_Right =>
               Drive (Forward, (Speed, -Speed, Speed, -Speed));
            when Turn_Back =>
               Drive (Forward, (Speed, -Speed, Speed, -Speed));
            when Reverse_Car =>
               Drive (Backward, (Speed, Speed, Speed, Speed));
            when Stop =>
               Drive (Forward, (-speed / 3, -speed / 3, -speed / 3, -speed / 3));
                delay until Clock + Milliseconds (120);
               Drive (Stop, (0, 0, 0, 0));
         end case;


         Next := Next + Period;
         delay until Next;
      end loop;
   end Motor_Control;

end Drive_Task;
