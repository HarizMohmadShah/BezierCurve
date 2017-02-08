with Ada.Unchecked_Deallocation;

package body Liste_Generique is

   procedure Liberer is new Ada.Unchecked_Deallocation(Cellule,Pointeur) ;

   procedure Vider(L : in out Liste) is
      Cour: Pointeur := L.Debut;
      Suiv: Pointeur;
   begin
      while Cour /= null loop
         Suiv := Cour.Suivant;
         Liberer(Cour);
         Cour:=Suiv;
      end loop;
      L.Debut:=null;
      L.Taille:=0;
   end;

   procedure Insertion_Tete(L : in out Liste ; E : Element) is
   begin
      L.Debut:=new Cellule'(E,L.Debut);
      L.Taille:=L.Taille+1;
   end;

   procedure Insertion_Queue(L : in out Liste ; E : Element) is
   begin
      if L.Debut=null then
         Insertion_Tete(L,E);
         L.Fin:=L.Debut;
      else
         L.Fin.all.Suivant:= new Cellule'(E,null);
         L.Fin:=L.Fin.Suivant;
      end if;
      L.Taille:=L.Taille+1;
   end;

   procedure Parcourir (L : Liste) is
      P : Pointeur := L.Debut;
   begin
      while P /= null loop
         Traiter(P.Contenu);
         P := P.Suivant;
      end loop;
   end;

   procedure Parcourir_Par_Couples(L : Liste) is
      P1, P2 : Pointeur;
   begin
      if L.Debut = null or else L.Debut.Suivant = null then
         return;
      end if;

      P1 := L.Debut;
      P2 := L.Debut.Suivant;

      while P2 /= null loop
         Traiter(P1.Contenu,P2.Contenu);
         P1 := P2;
         P2 := P2.Suivant;
      end loop;
   end;

   procedure Fusion(L1 : in out Liste ; L2 : in out Liste) is
      Tete, Queue, Cour : Pointeur;
   begin
      if L2.Debut=null then
         return;
      end if;

      Tete:=new Cellule'(L2.Debut.Contenu,null);
      Queue:=Tete;
      Cour:=L2.Debut.Suivant;
      while Cour /= null loop
         Queue.Suivant:=new Cellule'(Cour.Contenu,null);
         Queue:=Queue.Suivant;
         Cour:=Cour.Suivant;
      end loop;

      if L1.Debut = null then
         L1.Debut := Tete;
         L1.Fin := Queue;
      else
         L1.Fin.Suivant:=Tete;
         L1.Fin:=Queue;
      end if;

      L2.Debut := null;
      L2.Fin := null;
      L2.Taille := 0;
   end;

   function Taille(L : Liste) return Natural is
   begin
      return L.Taille;
   end;

   function Tete(L : Liste) return Element is
   begin
      return L.Debut.Contenu;
   end;

   function Queue(L : Liste) return Element is
   begin
      return L.Fin.Contenu;
   end;

end;
