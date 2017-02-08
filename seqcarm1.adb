with Ada.Text_IO, Ada.Command_Line;
use Ada.Text_IO, Ada.Command_Line ;

package body SeqCarM1 is

   Svg : File_Type ;
   Car : Character ;
   Est_Fin : Boolean := True ;

   Anomalie: exception ;

   procedure Open_File(Nom_Fichier : String) is
   begin
      Open(Svg, In_File, Nom_Fichier) ;
      Set_Input(Svg) ;
   exception
      when Status_Error => Put_Line("### Fichier """ &  Nom_Fichier & """ deja ouvert") ;
         raise ;
      when Name_Error => Put_Line("### Fichier """ &  Nom_Fichier & """ inexistant") ;
         raise ;
      when Use_Error => Put_Line("### Fichier """ &  Nom_Fichier & """ interdit en lecture") ;
         raise ;
   end ;

   procedure DemCar is
   begin
      if not Est_Fin then
         raise Anomalie ;
      end if ;
      Est_Fin := False ;
      AvCar;
   end ;

   procedure AvCar is
   begin
      if Est_Fin then
         raise Anomalie ;
      end if ;
      Get_Immediate(Car) ;
      Est_Fin := False ;
   exception
      when End_Error =>
	 Est_Fin :=True ;   
   end ;

   function CarCour return Character is
   begin
      if Est_Fin then
         raise Anomalie ;
      end if ;
      return Car ;
   end ;

   function FinCar return Boolean is
   begin
      return Est_Fin ;
   end ;

   procedure StopCar is
   begin
      Close(Svg);
      Set_Input(Standard_Input);
      Est_Fin := True ;
   end ;

end SeqCarM1 ;
