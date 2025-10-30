with Ada.Real_Time; use Ada.Real_Time;
with Types; use Types;

package body Ultrasonic is
   Period : constant Time_span := Milliseconds(50); -- sensor oppdateres hvert 50 ms

   task body Sensor_Task is
      Next : Time := Clock; -- neste kjøringstid
      Val  : Cm;

   begin
      loop
          -- 1) TRIG: sett trigger-pin HØY en kort stund (10 µs), så LAV
         -- 2) Mål ECHO-pulslengde (mikrosekunder) -> konverter til cm
         --    cm ≈ echo_us / 58 for HC-SR04. Bytt ut med faktisk I/O-kode.
         --    Eksempel: Val := Cm(Integer(Echo_Us / 58));
         Val := 400;                     -- Placeholder inntil du kobler ekte måling
         Sensor_Reading.Update(Val);     -- Skriv målingen atomisk inn i delt buffer

         next := next + Period;
         delay until next;
      end loop;
   end Sensor_Task;
end Ultrasonic;
