

generic
   type Element is private;

package Liste_Generique is

   type Liste is limited private; -- une liste est initialement vide

   -- vide L et libere la memoire correspondante
   procedure Vider(L : in out Liste);

   -- insere E en tete de L
   procedure Insertion_Tete(L : in out Liste ; E : Element);

   -- insere E en queue de L
   procedure Insertion_Queue(L : in out Liste ; E : Element);

   -- appelle Traiter sur chaque element de L, dans l'ordre
   generic
      with procedure Traiter(E : in out Element);
   procedure Parcourir(L : Liste);

   -- si L = [E1 ; E2 ; ... ; En-1 ; En]
   -- appelle Traiter sur chaque couple (Ei, Ei+1) pour 0 < i < n
   generic
      with procedure Traiter(E1, E2 : in Element);
   procedure Parcourir_Par_Couples(L : Liste);

   --fusionne L2 a la fin de L1; en sortie L2 est vide
   procedure Fusion(L1 : in out Liste ; L2 : in out Liste);

   -- nombre d'éléments de L
   function Taille(L : Liste) return Natural;

   -- requiert Taille(L) /= 0
   function Tete(L : Liste) return Element;

   -- requiert Taille(L) /= 0
   function Queue(L : Liste) return Element;

private
   type Cellule;
   type Pointeur is access Cellule;
   type Cellule is record
      Contenu : Element;
      Suivant : Pointeur;
   end record;
   type Liste is record
      Debut, Fin : Pointeur := null;
      Taille : Natural := 0;
   end record;
end;
