with Types; use Types;

package Ultrasonic is
   Sensor_Reading : Range_Data; -- Lagring av avstand som er delt og trådsikker
   task Sensor_Task;            --periodisk task som oppdaterer Sensor_Reading
end Ultrasonic;
