with Types; use Types;

package Motors is
   Command : Motor_Cmd; -- Delt og trådsikker lagring av motor-kommandoer

   procedure Drive(Left, Right : Integer); -- API for kontrilltask
   procedure Stop;                        -- Stopper bilen, setter begg hjul til 0

   task Actuator_Task; -- Periodisk task som leser Command og styrer motorene|
end Motors;
