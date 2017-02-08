with Ada.Text_IO, Ada.Float_Text_IO, Math, SeqCarM1;
use Ada.Text_IO, Ada.Float_Text_IO, Math, SeqCarM1;

package body Svg_Element is

   function Char_to_No(C : Character) return Float is
   begin
      return Float(Character'Pos(C) - Character'Pos('0'));
   end Char_to_No;

   procedure Go_to_Data_Line(Cas : out Character; Data : in out Boolean) is
   begin
      if Data then
         raise Error_Data;
      end if;

      while not FinCar and then not Data loop
         if CarCour = 'd' then
            AvCar;
            if CarCour = '=' then
               AvCar;
               if CarCour = '"' then
                  AvCar;
                  if (CarCour = 'm' or CarCour = 'M' or CarCour = 'L' or CarCour = 'l' or CarCour = 'H' or CarCour = 'h' or CarCour = 'V' or
                        CarCour = 'v' or CarCour = 'C' or CarCour = 'c' or CarCour = 'Q' or CarCour = 'q') then
                     Cas := CarCour;
                     AvCar;
                     if CarCour = ' ' then
                        Data := True;
                     end if;
                  end if;
               end if;
            end if;
         end if;
         AvCar;
      end loop;

   end Go_to_Data_Line;

   procedure MoveOrLine_to_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P : Point2D := (0.0,0.0);
      Y_Cordinate : Boolean := False;
      Power : Positive := 1;
      Decimal : Boolean := True;
      NbXnegative : Boolean := False;
      NbYnegative : Boolean := False;
   begin
      while CarCour /= ' ' loop
         if CarCour = ',' then
            Y_Cordinate := True;
            Power := 1;
            Decimal := True;
         elsif CarCour = '.' then
            Decimal := False;
         elsif CarCour = '-' and not Y_Cordinate then
            NbXnegative := True;
         elsif CarCour = '-' and Y_Cordinate then
            NbYnegative := True;
         elsif CarCour in in_Number then
            if not Y_Cordinate then
               if Decimal then
                  P(1) := P(1)*10.0 + Char_to_No(CarCour);
               else
                  P(1) := P(1) + Char_to_No(CarCour)*(0.1**Power);
                  Power := Power + 1;
               end if;
            else
               if Decimal then
                  P(2) := P(2)*10.0 + Char_to_No(CarCour);
               else
                  P(2) := P(2) + Char_to_No(CarCour)*(0.1**Power);
                  Power := Power + 1;
               end if;
            end if;
         end if;
         AvCar;
         if CarCour = '"' then
            End_Data := True;
         end if;
      end loop;

      if NbXnegative then
         P(1) := P(1)*(-1.0);
      end if;

      if NbYnegative then
         P(2) := P(2)*(-1.0);
      end if;

      P := "+"(P,P_ORIGIN);
      P_ORIGIN(1) := P(1);
      P_ORIGIN(2) := P(2);
      Insertion_Queue(L,P);
   end MoveOrLine_to_Relatif;

   procedure MoveOrLine_to(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P : Point2D := (0.0,0.0);
      Y_Cordinate : Boolean := False;
      Power : Positive := 1;
      Decimal : Boolean := True;
      NbXnegative : Boolean := False;
      NbYnegative : Boolean := False;
   begin
      while CarCour /= ' ' loop
         if CarCour = ',' then
            Y_Cordinate := True;
            Power := 1;
            Decimal := True;
         elsif CarCour = '.' then
            Decimal := False;
         elsif CarCour = '-' and not Y_Cordinate then
            NbXnegative := True;
         elsif CarCour = '-' and Y_Cordinate then
            NbYnegative := True;
         elsif CarCour in in_Number then
            if not Y_Cordinate then
               if Decimal then
                  P(1) := P(1)*10.0 + Char_to_No(CarCour);
               else
                  P(1) := P(1) + Char_to_No(CarCour)*(0.1**Power);
                  Power := Power + 1;
               end if;
            else
               if Decimal then
                  P(2) := P(2)*10.0 + Char_to_No(CarCour);
               else
                  P(2) := P(2) + Char_to_No(CarCour)*(0.1**Power);
                  Power := Power + 1;
               end if;
            end if;
         end if;
         AvCar;
         if CarCour = '"' then
            End_Data := True;
         end if;
      end loop;

      if NbXnegative then
         P(1) := P(1)*(-1.0);
      end if;

      if NbYnegative then
         P(2) := P(2)*(-1.0);
      end if;

      P_ORIGIN(1) := P(1);
      P_ORIGIN(2) := P(2);
      Insertion_Queue(L,P);
   end MoveOrLine_to;

   procedure Cubic_Bezier_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P1, P2, P3 : Point2D := (0.0,0.0);
      Y_Cordinate : Boolean := False;
      Power : Positive := 1;
      NbPoint : Positive := 1;
      Decimal : Boolean := True;
      NbXnegative : Boolean := False;
      NbYnegative : Boolean := False;
   begin
      while NbPoint <= 3 loop
         while CarCour /= ' ' loop
            if CarCour = ',' then
               Y_Cordinate := True;
               Power := 1;
               Decimal := True;
            elsif CarCour = '.' then
               Decimal := False;
            elsif CarCour = '-' and not Y_Cordinate then
               NbXnegative := True;
            elsif CarCour = '-' and Y_Cordinate then
               NbYnegative := True;
            elsif CarCour in in_Number then
               case NbPoint is
               when 1 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P1(1) := P1(1)*10.0 + Char_to_No(CarCour);
                     else
                        P1(1) := P1(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P1(2) := P1(2)*10.0 + Char_to_No(CarCour);
                     else
                        P1(2) := P1(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when 2 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P2(1) := P2(1)*10.0 + Char_to_No(CarCour);
                     else
                        P2(1) := P2(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P2(2) := P2(2)*10.0 + Char_to_No(CarCour);
                     else
                        P2(2) := P2(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when 3 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P3(1) := P3(1)*10.0 + Char_to_No(CarCour);
                     else
                        P3(1) := P3(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P3(2) := P3(2)*10.0 + Char_to_No(CarCour);
                     else
                        P3(2) := P3(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when others => null;
               end case;
            end if;
            AvCar;
            if CarCour = '"' then
               End_Data := True;
            end if;

         end loop;

         if NbXnegative then
            case NbPoint is
            when 1 =>
               P1(1) := P1(1)*(-1.0);
            when 2 =>
               P2(1) := P2(1)*(-1.0);
            when 3 =>
               P3(1) := P3(1)*(-1.0);
            when others => null;
            end case;
            NbXnegative := False;
         end if;

         if NbYnegative then
            case NbPoint is
            when 1 =>
               P1(2) := P1(2)*(-1.0);
            when 2 =>
               P2(2) := P2(2)*(-1.0);
            when 3 =>
               P3(2) := P3(2)*(-1.0);
            when others => null;
            end case;
            NbYnegative := False;
         end if;

         AvCar;
         NbPoint := NbPoint + 1;
         Y_Cordinate := False;
         Decimal := True;
         Power := 1;

      end loop;

      P1 := "+"(P1,P_ORIGIN);
      P2 := "+"(P2,P_ORIGIN);
      P3 := "+"(P3,P_ORIGIN);
      Bezier(P_ORIGIN,P1,P2,P3,N,L);
      P_ORIGIN(1) := P3(1);
      P_ORIGIN(2) := P3(2);

   end Cubic_Bezier_Relatif;

   procedure Cubic_Bezier(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P1, P2, P3 : Point2D := (0.0,0.0);
      Y_Cordinate : Boolean := False;
      Power : Positive := 1;
      NbPoint : Positive := 1;
      Decimal : Boolean := True;
      NbXnegative : Boolean := False;
      NbYnegative : Boolean := False;
   begin
      while NbPoint <= 3 loop
         while CarCour /= ' ' loop
            if CarCour = ',' then
               Y_Cordinate := True;
               Power := 1;
               Decimal := True;
            elsif CarCour = '.' then
               Decimal := False;
            elsif CarCour = '-' and not Y_Cordinate then
               NbXnegative := True;
            elsif CarCour = '-' and Y_Cordinate then
               NbYnegative := True;
            elsif CarCour in in_Number then
               case NbPoint is
               when 1 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P1(1) := P1(1)*10.0 + Char_to_No(CarCour);
                     else
                        P1(1) := P1(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P1(2) := P1(2)*10.0 + Char_to_No(CarCour);
                     else
                        P1(2) := P1(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when 2 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P2(1) := P2(1)*10.0 + Char_to_No(CarCour);
                     else
                        P2(1) := P2(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P2(2) := P2(2)*10.0 + Char_to_No(CarCour);
                     else
                        P2(2) := P2(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when 3 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P3(1) := P3(1)*10.0 + Char_to_No(CarCour);
                     else
                        P3(1) := P3(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P3(2) := P3(2)*10.0 + Char_to_No(CarCour);
                     else
                        P3(2) := P3(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when others => null;
               end case;
            end if;
            AvCar;
            if CarCour = '"' then
               End_Data := True;
            end if;

         end loop;

         if NbXnegative then
            case NbPoint is
            when 1 =>
               P1(1) := P1(1)*(-1.0);
            when 2 =>
               P2(1) := P2(1)*(-1.0);
            when 3 =>
               P3(1) := P3(1)*(-1.0);
            when others => null;
            end case;
            NbXnegative := False;
         end if;

         if NbYnegative then
            case NbPoint is
            when 1 =>
               P1(2) := P1(2)*(-1.0);
            when 2 =>
               P2(2) := P2(2)*(-1.0);
            when 3 =>
               P3(2) := P3(2)*(-1.0);
            when others => null;
            end case;
            NbYnegative := False;
         end if;

         AvCar;
         NbPoint := NbPoint + 1;
         Y_Cordinate := False;
         Decimal := True;
         Power := 1;

      end loop;

      Bezier(P_ORIGIN,P1,P2,P3,N,L);
      P_ORIGIN(1) := P3(1);
      P_ORIGIN(2) := P3(2);

   end Cubic_Bezier;

   procedure Quadratic_Bezier_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P1, P2 : Point2D := (0.0,0.0);
      Y_Cordinate : Boolean := False;
      Power : Positive := 1;
      NbPoint : Positive := 1;
      Decimal : Boolean := True;
      NbXnegative : Boolean := False;
      NbYnegative : Boolean := False;
   begin
      while NbPoint <= 2 loop
         while CarCour /= ' ' loop
            if CarCour = ',' then
               Y_Cordinate := True;
               Power := 1;
               Decimal := True;
            elsif CarCour = '.' then
               Decimal := False;
            elsif CarCour = '-' and not Y_Cordinate then
               NbXnegative := True;
            elsif CarCour = '-' and Y_Cordinate then
               NbYnegative := True;
            elsif CarCour in in_Number then
               case NbPoint is
               when 1 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P1(1) := P1(1)*10.0 + Char_to_No(CarCour);
                     else
                        P1(1) := P1(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P1(2) := P1(2)*10.0 + Char_to_No(CarCour);
                     else
                        P1(2) := P1(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when 2 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P2(1) := P2(1)*10.0 + Char_to_No(CarCour);
                     else
                        P2(1) := P2(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P2(2) := P2(2)*10.0 + Char_to_No(CarCour);
                     else
                        P2(2) := P2(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when others => null;
               end case;
            end if;
            AvCar;
            if CarCour = '"' then
               End_Data := True;
            end if;

         end loop;

         if NbXnegative then
            case NbPoint is
            when 1 =>
               P1(1) := P1(1)*(-1.0);
            when 2 =>
               P2(1) := P2(1)*(-1.0);
            when others => null;
            end case;
            NbXnegative := False;
         end if;

         if NbYnegative then
            case NbPoint is
            when 1 =>
               P1(2) := P1(2)*(-1.0);
            when 2 =>
               P2(2) := P2(2)*(-1.0);
            when others => null;
            end case;
            NbYnegative := False;
         end if;

         AvCar;
         NbPoint := NbPoint + 1;
         Y_Cordinate := False;
         Decimal := True;
         Power := 1;

      end loop;

      P1 := "+"(P1,P_ORIGIN);
      P2 := "+"(P2,P_ORIGIN);
      Bezier(P_ORIGIN,P1,P2,N,L);
      P_ORIGIN(1) := P2(1);
      P_ORIGIN(2) := P2(2);
   end Quadratic_Bezier_Relatif;

   procedure Quadratic_Bezier(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P1, P2 : Point2D := (0.0,0.0);
      Y_Cordinate : Boolean := False;
      Power : Positive := 1;
      NbPoint : Positive := 1;
      Decimal : Boolean := True;
      NbXnegative : Boolean := False;
      NbYnegative : Boolean := False;
   begin
      while NbPoint <= 2 loop
         while CarCour /= ' ' loop
            if CarCour = ',' then
               Y_Cordinate := True;
               Power := 1;
               Decimal := True;
            elsif CarCour = '.' then
               Decimal := False;
            elsif CarCour = '-' and not Y_Cordinate then
               NbXnegative := True;
            elsif CarCour = '-' and Y_Cordinate then
               NbYnegative := True;
            elsif CarCour in in_Number then
               case NbPoint is
               when 1 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P1(1) := P1(1)*10.0 + Char_to_No(CarCour);
                     else
                        P1(1) := P1(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P1(2) := P1(2)*10.0 + Char_to_No(CarCour);
                     else
                        P1(2) := P1(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when 2 =>
                  if not Y_Cordinate then
                     if Decimal then
                        P2(1) := P2(1)*10.0 + Char_to_No(CarCour);
                     else
                        P2(1) := P2(1) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  else
                     if Decimal then
                        P2(2) := P2(2)*10.0 + Char_to_No(CarCour);
                     else
                        P2(2) := P2(2) + Char_to_No(CarCour)*(0.1**Power);
                        Power := Power + 1;
                     end if;
                  end if;
               when others => null;
               end case;
            end if;
            AvCar;
            if CarCour = '"' then
               End_Data := True;
            end if;

         end loop;

         if NbXnegative then
            case NbPoint is
            when 1 =>
               P1(1) := P1(1)*(-1.0);
            when 2 =>
               P2(1) := P2(1)*(-1.0);
            when others => null;
            end case;
            NbXnegative := False;
         end if;

         if NbYnegative then
            case NbPoint is
            when 1 =>
               P1(2) := P1(2)*(-1.0);
            when 2 =>
               P2(2) := P2(2)*(-1.0);
            when others => null;
            end case;
            NbYnegative := False;
         end if;

         AvCar;
         NbPoint := NbPoint + 1;
         Y_Cordinate := False;
         Decimal := True;
         Power := 1;

      end loop;

      Bezier(P_ORIGIN,P1,P2,N,L);
      P_ORIGIN(1) := P2(1);
      P_ORIGIN(2) := P2(2);
   end Quadratic_Bezier;

   procedure Horizontal_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P : Point2D := (0.0,0.0);
      Power : Positive := 1;
      Decimal : Boolean := True;
      NbXnegative : Boolean := False;
   begin
      while CarCour /= ' ' loop
         if CarCour = '.' then
            Decimal := False;
         elsif CarCour = '-' then
            NbXnegative := True;
         elsif CarCour in in_Number then
            if Decimal then
               P(1) := P(1)*10.0 + Char_to_No(CarCour);
            else
               P(1) := P(1) + Char_to_No(CarCour)*(0.1**Power);
               Power := Power + 1;
            end if;
         end if;
         AvCar;
         if CarCour = '"' then
            End_Data := True;
         end if;
      end loop;

      if NbXnegative then
         P(1) := P(1)*(-1.0);
      end if;

      P := "+"(P,P_ORIGIN);
      P_ORIGIN(1) := P(1);
      P_ORIGIN(2) := P(2);
      Insertion_Queue(L,P);
   end Horizontal_Relatif;

   procedure Horizontal(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P : Point2D := (0.0,P_ORIGIN(2));
      Power : Positive := 1;
      Decimal : Boolean := True;
      NbXnegative : Boolean := False;
   begin
      while CarCour /= ' ' loop
         if CarCour = '.' then
            Decimal := False;
         elsif CarCour = '-' then
            NbXnegative := True;
         elsif CarCour in in_Number then
            if Decimal then
               P(1) := P(1)*10.0 + Char_to_No(CarCour);
            else
               P(1) := P(1) + Char_to_No(CarCour)*(0.1**Power);
               Power := Power + 1;
            end if;
         end if;
         AvCar;
         if CarCour = '"' then
            End_Data := True;
         end if;
      end loop;

      if NbXnegative then
         P(1) := P(1)*(-1.0);
      end if;

      P_ORIGIN(1) := P(1);
      P_ORIGIN(2) := P(2);
      Insertion_Queue(L,P);
   end Horizontal;

   procedure Vertical_Relatif(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P : Point2D := (0.0,0.0);
      Power : Positive := 1;
      Decimal : Boolean := True;
      NbYnegative : Boolean := False;
   begin
      while CarCour /= ' ' loop
         if CarCour = '.' then
            Decimal := False;
         elsif CarCour = '-' then
            NbYnegative := True;
         elsif CarCour in in_Number then
            if Decimal then
               P(2) := P(2)*10.0 + Char_to_No(CarCour);
            else
               P(2) := P(2) + Char_to_No(CarCour)*(0.1**Power);
               Power := Power + 1;
            end if;
         end if;
         AvCar;
         if CarCour = '"' then
            End_Data := True;
         end if;
      end loop;

      if NbYnegative then
         P(2) := P(2)*(-1.0);
      end if;

      P := "+"(P,P_ORIGIN);
      P_ORIGIN(1) := P(1);
      P_ORIGIN(2) := P(2);
      Insertion_Queue(L,P);
   end Vertical_Relatif;

   procedure Vertical(P_ORIGIN : in out Point2D; End_Data : out Boolean; L : in out Liste) is
      P : Point2D := (P_ORIGIN(1),0.0);
      Power : Positive := 1;
      Decimal : Boolean := True;
      NbYnegative : Boolean := False;
   begin
      while CarCour /= ' ' loop
         if CarCour = '.' then
            Decimal := False;
         elsif CarCour = '-' then
            NbYnegative := True;
         elsif CarCour in in_Number then
            if Decimal then
               P(2) := P(2)*10.0 + Char_to_No(CarCour);
            else
               P(2) := P(2) + Char_to_No(CarCour)*(0.1**Power);
               Power := Power + 1;
            end if;
         end if;
         AvCar;
         if CarCour = '"' then
            End_Data := True;
         end if;
      end loop;

      if NbYnegative then
         P(2) := P(2)*(-1.0);
      end if;

      P_ORIGIN(1) := P(1);
      P_ORIGIN(2) := P(2);
      Insertion_Queue(L,P);
   end Vertical;
end;
