with Ada.Real_Time; use Ada.Real_Time;

package Types is
   type Cm is range 0 .. 400;

   type Motor_Result is record
      L, R  : Integer;
   end record;

   protected type Range_Data is
      procedure Update(V : Cm);
      function Read return Cm;
   private
      Last : Cm := 400;
   end Range_Data;

   protected type Motor_Cmd is
      procedure Set(Left, Right : Integer);
      procedure Stop;
      function Get return Motor_Result;
   private
      L, R : Integer := 0;
   end Motor_Cmd;
end Types;
