with Liste_Generique;
with Math; use Math;

package STL is
   type Facette is record
      P1, P2, P3 : Vecteur(1..3);
   end record;

   package Liste_Facettes is new Liste_Generique(Facette);
   use Liste_Facettes;

   procedure to_3d(P1,P2 : in Point2D);
   procedure Segments_to_Facettes is new Liste_Points.Parcourir_Par_Couples(to_3d);

   -- Pour visualise les points des segments
   procedure Affichage_Facette(P : in out Facette);
   procedure Affiche_Facette is new Liste_Facettes.Parcourir(Affichage_Facette);

   -- Pour Creer le fichier Stl
   procedure Write_Facette(F : in out Facette);
   Procedure Stl_Facette is new Liste_Facettes.Parcourir(Write_Facette);

   --prend une liste de segments et cree l'objet 3d par rotations
   procedure Creation(Segments : in out Liste_Points.Liste ;
                      Facettes :    out Liste_Facettes.Liste);

   --sauvegarde le fichier stl
   procedure Sauvegarder(Nom_Fichier : String ;
                         Facettes : Liste_Facettes.Liste);
end;
