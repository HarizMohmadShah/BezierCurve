--  with Ada.Text_IO;
--  use Ada.Text_IO;
with Math; use Math;

package Svg_Element is
   use Liste_Points;

   Error_Data : exception;
   N : constant Positive := 100;

   subtype in_Number is Character range '0'..'9';

   -- Convertit le character au nombre
   function Char_to_No(C : Character) return Float;

   -- Envoyer Data=True si on trouve (id"m )
   procedure Go_to_Data_Line(Cas : out Character; Data : in out Boolean);

   procedure MoveOrLine_to_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);

   procedure MoveOrLine_to(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);

   procedure Cubic_Bezier_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);

   procedure Cubic_Bezier(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);

   procedure Quadratic_Bezier_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);

   procedure Quadratic_Bezier(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);

   procedure Horizontal_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);

   procedure Horizontal(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);

   procedure Vertical_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);

   procedure Vertical(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste);
end;
