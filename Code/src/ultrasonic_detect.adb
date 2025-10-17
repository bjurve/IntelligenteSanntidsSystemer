with MicroBit.Ultrasonic;
with MicroBit; use MicroBit;

package body Ultrasonic_Detect is
   Stop_cm : constant := 3;

   -- BYTT til dine TRIG/ECHO-pinner:
   package U_Left  is new MicroBit.Ultrasonic (MB_P16, MB_P0);
   package U_Right is new MicroBit.Ultrasonic (MB_P14, MB_P1);

   function Read_Left  return Integer is (Integer (U_Left.Read));
   function Read_Right return Integer is (Integer (U_Right.Read));

   function Min_Distance return Integer is
      DL : constant Integer := Read_Left;
      DR : constant Integer := Read_Right;
   begin
      return (if DL < DR then DL else DR);
   end Min_Distance;

   function Obstacle_Near return Boolean is
   begin
      return Min_Distance <= Stop_cm;
   end Obstacle_Near;
end Ultrasonic_Detect;
