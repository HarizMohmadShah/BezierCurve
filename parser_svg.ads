with Math; use Math;

package Parser_Svg is
   use Liste_Points;

   --parse un fichier svg et retourne une liste de points (voir documentation)
   procedure Chargement_Bezier(Nom_Fichier : String; L : out Liste);
end;
