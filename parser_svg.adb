with Ada.Text_IO, Ada.Float_Text_IO, Math, SeqCarM1, Svg_Element;
use Ada.Text_IO, Ada.Float_Text_IO, Math, SeqCarM1, Svg_Element;

package body Parser_Svg is

   Data_Line : Boolean := False;
   Etat : Character;  -- Etat de MCLVQH
   ORIGIN : Point2D := (0.0, 0.0);
   End_of_Data : Boolean := False;

   procedure Chargement_Bezier(Nom_Fichier : String; L : out Liste) is
   begin

      Put("Getting all point from the curves in " & Nom_Fichier & "...");

      Open_File(Nom_Fichier);
      DemCar;
      Go_to_Data_Line(Etat, Data_Line);

      while Data_Line and then not End_of_Data loop
         if (CarCour = 'm' or CarCour = 'M' or CarCour = 'L' or CarCour = 'l' or CarCour = 'H' or CarCour = 'h' or CarCour = 'V' or
               CarCour = 'v' or CarCour = 'C' or CarCour = 'c' or CarCour = 'Q' or CarCour = 'q') then
            Etat := CarCour;
            AvCar;
            AvCar;
         end if;

         case Etat is
            when 'm' =>
               MoveOrLine_to_Relatif(ORIGIN, End_of_Data, L);
            when 'M' =>
               MoveOrLine_to(ORIGIN, End_of_Data, L);
            when 'c' =>
               Cubic_Bezier_Relatif(ORIGIN, End_of_Data, L);
            when 'C' =>
               Cubic_Bezier(ORIGIN, End_of_Data, L);
            when 'q' =>
               Quadratic_Bezier_Relatif(ORIGIN, End_of_Data, L);
            when 'Q' =>
               Quadratic_Bezier(ORIGIN, End_of_Data, L);
            when 'l' =>
               MoveOrLine_to_Relatif(ORIGIN, End_of_Data, L);
            when 'L' =>
               MoveOrLine_to(ORIGIN, End_of_Data, L);
            when 'h' =>
               Horizontal_Relatif(ORIGIN, End_of_Data, L);
            when 'H' =>
               Horizontal(ORIGIN, End_of_Data, L);
            when 'v' =>
               Vertical_Relatif(ORIGIN, End_of_Data, L);
            when 'V' =>
               Vertical(ORIGIN, End_of_Data, L);
            when others => null;
         end case;

         if CarCour not in in_Number and not (CarCour = 'm' or CarCour = 'M' or CarCour = 'L' or CarCour = 'l' or CarCour = 'H' or CarCour = 'h'
                                              or CarCour = 'V' or CarCour = 'v' or CarCour = 'C' or CarCour = 'c' or CarCour = 'Q' or CarCour = 'q')then
               AvCar;
         end if;

      end loop;

      Put_Line("done.");
      Put_Line("Total Point: " & Natural'Image(Taille(L)));
      if Taille(L) /= 0 then
         Put("Searching for Xmin and Ymin...");
         Min(L);
         Put_Line("done.");
         Put("Moving the curve to point (0.0)...");
         Translate(L);
         Put_Line("done.");
         Put("Verifying the start point is at (Xstart,0)...");
         Raccorder_Tete(Tete(L), L);
         Put_Line("done.");
         Put("Verifying the end point is at (Xend,0)...");
         Raccorder_Queue(Queue(L), L);
         Put_Line("done.");
      end if;

      StopCar;
   exception
         when Error_Data => Put_Line("Probleme de trouver la ligne des donnees");
   end;
end;
