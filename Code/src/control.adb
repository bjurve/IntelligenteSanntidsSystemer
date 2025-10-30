with Ada.Real_Time; use Ada.Real_Time;
with IS31FL3731;
with Ultrasonic; use Ultrasonic;
with Motors; use Motors;


package body Control is
   period : constant Time_Span := Milliseconds(100); -- kontroll oppdateres hvert 100 ms
   Avstand : constant Integer := 20; -- terskelavstand i cm for å unngå hindringer
   Base_Hastighet : constant Integer := 200; -- grunnhastighet for motorene



   type State_T is (Drive,Avoid_Stop, Avoid_Back, Avoid_Turn);

   task body Control_Task is
      Next  : Time := Clock; -- neste kjøringstid
      S     : State_T := Drive;
      T_End : Time := Clock; -- tid for å avslutte unngåelsesmanøver
      D     : Integer;    -- siste avstand i cm
      Stable_Hits : Integer := 0; -- teller for stabile målinger under unngåelse

   begin
      loop
         D := Integer(Sensor_Reading.Read); -- les siste avstandsmåling

         case S is
            when Drive =>
               if D < Avstand then -- sjekk for hindring
                  Stable_Hits := Stable_Hits + 1; --legger til en count hvis terskel brytes
               else
                  Stable_Hits := 0; -- nullstiller count hvis terskel holdes
               end if;


               if Stable_Hits >= 3 then -- krever 3 stabile målinger for å unngå falske positiver
                  Motors.Stop;   --umiddelbar stopp
                  S := Avoid_Stop; --setter bilen i stopp-tilstand
                  T_End := Clock + Milliseconds(500); -- Bil stopper i x ms
               else
                  Motors.Drive(Base_Hastighet, Base_Hastighet); -- kjør fremover
               end if;

            when Avoid_Stop =>
               if clock >= T_End then
                  Motors.Drive(-Base_Hastighet, -Base_Hastighet); -- rygg tilbake
                  S := Avoid_Back;
                  T_End := Clock + Milliseconds(700); -- rygg i x ms
               end if;


            when Avoid_Back =>
               if clock >= T_End then
                  Motors.Drive(Base_Hastighet, -Base_Hastighet); -- sving til høyre
                  S := Avoid_Turn;
                  T_End := Clock + Milliseconds(600); -- sving i x ms
               end if;


            when Avoid_Turn =>
               if clock >= T_End then
                  S := Drive; -- tilbake til kjøretilstand
                  Stable_Hits := 0; -- nullstiller teller for stabile målinger
               end if;
         end case;

         next := next + Period; -- scheduler neste kjøringstid
         delay until next;

      end loop;
   end Control_Task;
end Control;
