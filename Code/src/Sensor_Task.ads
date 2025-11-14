package Sensor_Task is
   function Left_Distance  return Integer;
   function Right_Distance return Integer;
   procedure Update_Distances;
   task Sensor;
end Sensor_Task;
