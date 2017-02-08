with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Numerics;
use Ada.Numerics;
with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

package body STL is

   Tmp : Liste_Facettes.Liste; -- Liste temporaire
   Pi : constant Float := Ada.Numerics.Pi;
   M : constant Positive := 36; -- Nombre de fois de la rotation
   Stl : File_Type;

   procedure to_3d(P1, P2 : in Point2D) is
      Z : Float := 0.0;
      P : Facette;
      P_Facettes : Facette;
      Rad : Float := 0.0;
   begin

      P.P1(1) := P1(1);
      P.P1(2) := P1(2);
      P.P1(3) := Z;

      P.P2(1) := P2(1);
      P.P2(2) := P2(2);
      P.P2(3) := Z;

      for I in 1..M+1 loop
         P_Facettes.P1 := P.P1;

         P_Facettes.P2 := P.P2;

         P_Facettes.P3(1) := P2(1);
         P_Facettes.P3(2) := P2(2)*cos(Rad) - Z*sin(Rad);
         P_Facettes.P3(3) := Z*cos(Rad) - P2(2)*sin(Rad);

         Insertion_Queue(Tmp, P_Facettes);

         P_Facettes.P1 := P.P1;

         P_Facettes.P2 := P_Facettes.P3;

         P_Facettes.P3(1) := P1(1);
         P_Facettes.P3(2) := P1(2)*cos(Rad) - Z*sin(Rad);
         P_Facettes.P3(3) := Z*cos(Rad) - P1(2)*sin(Rad);

         Insertion_Queue(Tmp, P_Facettes);

         P.P1 := P_Facettes.P3;
         P.P2 := P_Facettes.P2;
         Rad := Rad + (2.0*Pi)/float(M);
      end loop;
   end to_3d;

   procedure Affichage_Facette(P : in out Facette) is
   begin
      Put(P.P1(1), Exp => 0, Fore => 0);
      Put(",");
      Put(P.P1(2), Exp => 0, Fore => 0);
      Put(",");
      Put(P.P1(3), Exp => 0, Fore => 0);
      Put(" ");
   end Affichage_Facette;

   procedure Stl_Tete(F : in out File_Type) is
   begin
      Put_Line(F, "solid test");
   end Stl_Tete;

   procedure Stl_Fin(F : in out File_Type) is
   begin
      Put_Line(F, "endsolid test");
   end Stl_Fin;

   procedure Write_Facette(F : in out Facette) is
   begin
      Put_Line(Stl, "  facet");
      Put_Line(Stl, "    outer loop");
      Put(Stl, "      vertex ");
      Put(Stl, F.P1(1), Exp => 0, Fore => 0);
      Put(Stl, " ");
      Put(Stl, F.P1(2), Exp => 0, Fore => 0);
      Put(Stl, " ");
      Put(Stl, F.P1(3), Exp => 0, Fore => 0);
      Put_Line(Stl, "");
      Put(Stl, "      vertex ");
      Put(Stl, F.P2(1), Exp => 0, Fore => 0);
      Put(Stl, " ");
      Put(Stl, F.P2(2), Exp => 0, Fore => 0);
      Put(Stl, " ");
      Put(Stl, F.P2(3), Exp => 0, Fore => 0);
      Put_Line(Stl, "");
      Put(Stl, "      vertex ");
      Put(Stl, F.P3(1), Exp => 0, Fore => 0);
      Put(Stl, " ");
      Put(Stl, F.P3(2), Exp => 0, Fore => 0);
      Put(Stl, " ");
      Put(Stl, F.P3(3), Exp => 0, Fore => 0);
      Put_Line(Stl, "");
      Put_Line(Stl, "    endloop");
      Put_Line(Stl, "  end facet");
   end Write_Facette;

   procedure Creation(Segments : in out Liste_Points.Liste ;
                      Facettes :    out Liste_Facettes.Liste) is
   begin
      Put("Converting all 2d points to 3d points...");
      Segments_to_Facettes(Segments);
      Put_Line("done.");
      Put("Putting all the 3d points into the main list...");
      Fusion(Facettes, Tmp);
      Put_Line("done.");
   end;


   procedure Sauvegarder(Nom_Fichier : String ;
                         Facettes : Liste_Facettes.Liste) is

   begin
      Put("Creating " & Nom_Fichier & "...");
      Create(Stl, Out_File, Nom_Fichier);
      Stl_Tete(Stl);
      Stl_Facette(Facettes);
      Stl_Fin(Stl);
      Close(Stl);
      Put_Line("done.");
   end;

end;
