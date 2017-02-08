with Liste_Generique;

package Math is

   type Vecteur is array(Positive range<>) of Float;
   subtype Point2D is Vecteur(1..2);
   package Liste_Points is new Liste_Generique(Point2D);
   use Liste_Points;

   -- convertit une courbe de Bezier cubique en segments
   procedure Bezier(P1, C1, C2, P2 : Point2D ; Nb_Points : Positive ;
                    Points : out Liste);
   -- convertit une courbe de Bezier quadratique en segments
   procedure Bezier(P1, C, P2 : Point2D ; Nb_Points : Positive ;
                    Points : out Liste);

   -- Pour visualise les points des segments
   procedure Affichage_Segment(P : in out Point2D);
   procedure Affiche_Segment is new Liste_Points.Parcourir(Affichage_Segment);

   -- Pour Trouver de Xmin et Ymin
   procedure Cherche_Min(P : in out Point2D);
   procedure Min is new Liste_Points.Parcourir(Cherche_Min);

   -- Pour Translate tous les points
   procedure Move(P : in out Point2D);
   procedure Translate is new Liste_Points.Parcourir(Move);

   -- Raccordage a la fin et au debut
   procedure Raccorder_Tete(P : in Point2D; Points : out Liste);
   procedure Raccorder_Queue(P : in Point2D; Points : out Liste);

   -- affichage de (Xmin,Ymin)
   procedure Affiche_min;

   -- addition de 2 vecteurs
   function "+" (A : Vecteur ; B : Vecteur) return Vecteur;

end;
