with Ada.Real_Time;  use Ada.Real_Time;
with Sensor_Task;
with Drive_Task;
with Decision_Task;

procedure Main is
   Period : constant Time_Span := Seconds (1);
   Next   : Time := Clock;
begin
   loop
      Next := Next + Period;
      delay until Next;
   end loop;
end Main;
