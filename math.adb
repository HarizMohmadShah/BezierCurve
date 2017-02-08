with Ada.Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Float_Text_IO;
package body  Math is

   P_min : Point2D := (9999.9999,9999.9999);

   function "+" (A : Vecteur ; B : Vecteur) return Vecteur is
      R : Vecteur(A'Range);
   begin
      for I in A'Range loop
         R(I) := A(I) + B(I);
      end loop;
      return R;
   end;

   procedure Bezier(P1, C1, C2, P2 : Point2D ; Nb_Points : Positive ;
                    Points : out Liste) is
      P : Point2D;
      t : Float := 1.0/float(Nb_Points);
   begin
      for I in 1..Nb_Points-1 loop
         P(1) := (1.0-t)*(1.0-t)*(1.0-t)*P1(1) + 3.0*(1.0-t)*(1.0-t)*t*C1(1)+3.0*(1.0-t)*t*t*C2(1) + t*t*t*P2(1);
         P(2) := (1.0-t)*(1.0-t)*(1.0-t)*P1(2) + 3.0*(1.0-t)*(1.0-t)*t*C1(2)+3.0*(1.0-t)*t*t*C2(2) + t*t*t*P2(2);
         Insertion_Queue(Points, P);
         t := t + 1.0/float(Nb_Points);
      end loop;
   end;

   procedure Bezier(P1, C, P2 : Point2D ; Nb_Points : Positive ;
                    Points : out Liste) is
      P : Point2D;
      t : Float := 1.0/float(Nb_Points);
   begin
      for I in 1..Nb_Points-1 loop
         P(1) := (1.0-t)*(1.0-t)*P1(1) + 2.0*(1.0-t)*t*C(1) + t*t*P2(1);
         P(2) := (1.0-t)*(1.0-t)*P1(2) + 2.0*(1.0-t)*t*C(2) + t*t*P2(2);
         Insertion_Queue(Points, P);
         t := t + 1.0/float(Nb_Points);
      end loop;
   end;

   procedure Affichage_Segment(P : in out Point2D) is
   begin
      Put(P(1), Exp => 0, Fore => 0);
      Put(",");
      Put(P(2), Exp => 0, Fore => 0);
      Put(" ");
   end Affichage_Segment;

   procedure Cherche_Min(P : in out Point2D) is
   begin
      if P_min(1) > P(1) then
         P_min(1) := P(1);
      end if;

      if P_min(2) > P(2) then
         P_min(2) := P(2);
      end if;
   end Cherche_Min;

   procedure Move(P : in out Point2D) is
   begin
         P(1) := P(1) - P_min(1);
         P(2) := P(2) - P_min(2);
   end Move;

   procedure Affiche_min is
   begin
      Put(P_min(1), Exp => 0, Fore => 0);
      Put(",");
      Put(P_min(2), Exp => 0, Fore => 0);
      Put(" ");
   end Affiche_min;

   procedure Raccorder_Tete(P : in Point2D; Points : out Liste) is
      Tmp : Point2D;
   begin
      Tmp(1) := P(1);
      Tmp(2) := 0.0;
      if P(2) /= 0.0 then
         Insertion_Tete(Points,Tmp);
      end if;
   end Raccorder_Tete;

   procedure Raccorder_Queue(P : in Point2D; Points : out Liste) is
      Tmp : Point2D;
   begin
      Tmp(1) := P(1);
      Tmp(2) := 0.0;
      if P(2) /= 0.0 then
         Insertion_Queue(Points,Tmp);
      end if;
   end Raccorder_Queue;

end;
