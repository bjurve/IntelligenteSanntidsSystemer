package Drive_Task is
   type Movement_Command is (Go_Forward, Turn_Left, Turn_Right, Turn_Back, Reverse_Car, Stop);
   procedure Set_Command (Cmd : Movement_Command);
   task Motor_Control;
end Drive_Task;







