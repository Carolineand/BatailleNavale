program bataille_navale;
uses crt;

const
	b1=6;			// b1 signifie bateau 1
	b2=5;          // Bateau 2
	b3=4;         //Bateau 3
	Ncellule=15;    //Ncell signifie nombre de cellules
	

//Les enregistrements

type cellule=record

	 x:integer;	
end;

type bateau=record

	b1,b2,b3:integer;
end;

type flotte=record

	TBat: ARRAY [1..Ncellule,1..Ncellule] of bateau;
end;

type grille= record

	TGrille: ARRAY [1..Ncellule*Ncellule] of cellule;

End;
//Fin enregistrements
	
procedure CreationGrille (VAR place:grille);  //Procedure pour la création de la grille 
var
	i,j:integer;

begin

	for i:=1 to Ncellule*Ncellule do
		begin

			if(i MOD Ncellule = 0) then
				writeln ;
		end;
	writeln;
end;
//Fin de la procedure de la creation de la grille 

function Comparaison(VAR Tableau:grille ; x,y:integer):boolean;  //Fonction pour faire une comparaison de 2 cases
begin
	if Tableau[(y-1)*Ncellule] = 1 then
	begin
		Exit(True);
    end
	else
	begin
		Exit(False);
	end;
end;
//Fin de la fonction 
procedure PlaceB(var Tableau:grille ; Bateau:flotte);  //Procedure pour le placement des bateaux
var
	i, j: integer;
	CX, CY: integer; //C =Choix
begin
	for i:= b3 to b1 do
	begin
		writeln('Veuillez placer un bateau de taille ', i, 'sur le x voulu : ');
		readln(CX);
		while((CX < 1) or (CX > Ncellule)) do
		begin
			writeln('X doit être supérieur ou égal à 1 et inferieur à ', Ncellule, ': ');
			readln(CX);
		end;
		
		writeln('Veuillez placer un bateau de taille ', i, 'sur le y voulu : ');
		readln(CY);
		while((CY < 1) or (CY + i > Ncellule)) do
		begin
			writeln('Y doit etre superieur ou egal a 1 et inferieur a ', Ncellule - i + 1, ': ');
			readln(CY);
		end;
		
		for j:= 1 to i do
		begin
			Tableau[(CY-1)*Ncellule + CX + (j-1)*Ncellule] := 1;
		end;
	end;
	
	for i:= 1 to Ncellule*Ncellule do
	begin
	
		if(i mod Ncellule = 0) then
			write;
	end;
end;
//Fin de la procedure qui permet de placer les bateaux
	
function ToucherBateau (var tab:grille; place:flotte): boolean; // Fonction pour les attaques entre joueurs 
var
	x, y , i: integer;
	ToucherBateau : boolean;
begin
	writeln('Où souhaites-tu toucher sur la coordonnée de X: ');
	readln(x);
	while ((x<1) or (x>Ncellule)) do
	begin
		writeln('Faux, tu ne peux toucher qu entre 1 et  ',Ncellule,': ');
		readln (x);
	end;
	writeln('Où souhaites-tu toucher sur la coordonnée de Y ');
	readln(y);
	while ((y<1) or (y>Ncellule)) do
	begin
		writeln('Faux, tu ne peux toucher qu entre 1 et ',Ncellule,': ');
		readln (y);
	end;
	
	ToucherBateau := toucher(tab, x, y);
	if(ToucherBateau) then
		begin
			writeln('toucher');
			tab[x+(y-1)*Ncell] := 0;
		end
	else
		writeln('Tu n as pas toucher de bateaux !!');
end;
//Fin de la fonction pour attaquer son adversaire

function Reste (tab:grille) : boolean;    //Fonction pour les bateaux restants
var
	i : integer;
	reste : boolean;
begin
	reste := false;
	for i := 1 to Ncellule*Ncellule do
	begin
		if(tab[i] <> 0) then
			reste := true;
	end;
	Exit(reste);
End;
 //Fin de la fonction des bateaux restants
//Programme Principal
var
	tab: grille;
	FlotteBis: flotte;
	
begin
    clrscr;
	CreationGrille(tab);
	PlaceB(tab, FlotteBis);
	while(Reste(tab)) do
		 ToucherBateau(tab, FlotteBis);
	readln;
end.
