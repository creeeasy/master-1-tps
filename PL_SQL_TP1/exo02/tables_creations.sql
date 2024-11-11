create table Employe_Table_Exo_02 (
   nuempl  varchar2(20) primary key,
   nomempl varchar2(100),
   salaire integer
);

create table Service_Table_Exo_02 (
   nuserv  number primary key,
   nomserv varchar2(100),
   chef    varchar2(20),
   foreign key (chef) 
      references Employe_Table_Exo_02 (nuempl)
);

create table Projet_Table_Exo_02 (
   nuproj  number primary key,
   nomproj varchar2(100),
   resp    varchar2(20),
   foreign key (resp)
      references Employe_Table_Exo_02 (nuempl)
);

create table Travail_Table_Exo_02 (
   nuempl varchar2(20),
   nuproj number,
   duree  integer,
   primary key (nuempl, nuproj),
   foreign key (nuempl)
      references Employe_Table_Exo_02 (nuempl),
   foreign key (nuproj)
      references Projet_Table_Exo_02 (nuproj)
);
