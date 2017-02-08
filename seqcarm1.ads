-- machine séquentielle de lecture des caractères modèle 1.

package SeqCarM1 is

   procedure Open_File(Nom_Fichier : String);

   procedure DemCar ;
   -- si un argument sur la ligne de commande:
   --    on utilise cet argument comme nom de fichier a lire
   -- sinon, on utilise l'entree standard:
   --    => dans ce cas, les caracteres lus sont affiches.
   --    => en interactif, utiliser "Ctrl-D" pour faire une fin de fichier.

   function FinCar return Boolean ;

   procedure AvCar ;
   -- requiert "not FinCar"

   function CarCour return Character ;
   -- requiert "not FinCar"

   procedure StopCar ;
   -- sert a fermer proprement le fichier ouvert.

end SeqCarM1;
