


package body Types is
   protected body Range_Data is
      procedure Update(V : Cm) is
      begin
         Last := V;
      end Update;

      function Read return Cm is
      begin
         return Last;
      end Read;
   end Range_Data;


   protected body Motor_Cmd is
      procedure Set(Left, Right : Integer) is
      begin
         L := Left;
         R := Right;
      end Set;

      procedure Stop is
      begin
         L := 0;
         R := 0;
      end Stop;

      function Get return Motor_Result is
      begin
         return (L => L, R => R);
      end Get;
   end Motor_Cmd;
end Types;
