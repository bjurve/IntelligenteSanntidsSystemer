with Ada.Real_Time;  use Ada.Real_Time;
with Sensor_Task;
with Drive_Task;
with Decision_Task;

procedure Main is

 T_Start, T_Stop : Time;
 Worst_Case : time_span := To_Time_Span (0);

begin

   for I in 1 ..100 loop
      T_Start := Clock;

      Distances.Update;

      T_Stop := Clock;

      declare
         Exec_Time : Time_Span := T_Stop - T_Start;
      begin
         if Exec_Time > Worst_Case then
            Worst_Case := Exec_Time;
         end if;
      end;
   end loop;


   Put_Line ("Worst case exec_Time: " & Time_Span'Image (Worst_Case));

end Main;
