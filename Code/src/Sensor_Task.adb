with MicroBit.Ultrasonic;
with MicroBit; use MicroBit;
with Ada.Real_Time; use Ada.Real_Time;

package body Sensor_Task is


   package U_Left  is new MicroBit.Ultrasonic (MB_P16, MB_P0);
   package U_Right is new MicroBit.Ultrasonic (MB_P14, MB_P1);

   protected Distances is
      procedure Update;
      function Left  return Integer;
      function Right return Integer;
   private
      L : Integer := 100;
      R : Integer := 100;
   end Distances;

   protected body Distances is
      procedure Update is
      begin
         L := Integer (U_Left.Read);
         R := Integer (U_Right.Read);
      end Update;

      function Left  return Integer is (L);
      function Right return Integer is (R);
   end Distances;

   function Left_Distance  return Integer is (Distances.Left);
   function Right_Distance return Integer is (Distances.Right);


   task body Sensor is
      Period : constant Time_Span := Milliseconds (100);
      Next   : Time := Clock;
   begin
      loop
         Distances.Update;
         Next := Next + Period;
         delay until Next;
      end loop;
   end Sensor;

end Sensor_Task;
