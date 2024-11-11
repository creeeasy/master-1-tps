-- 1. Create Table: Client
create table client (
   clt_id    integer primary key,
   clt_nom   varchar2(100),
   clt_email varchar2(100) unique,
   clt_vip   number(1) check ( clt_vip in ( 0,
                                          1 ) )
);

-- 2. Create Table: Voiture
create table voiture (
   matricule     varchar2(20) primary key,
   moteur_taille integer,
   kilom         integer,
   marque        varchar2(50),
   modele        integer
);

-- 3. Create Table: Reserver
create table reserver (
   clt_id    integer,
   matricule varchar2(20),
   date_res  date,
   date_ret  date,
   nb_jours  integer,
   etat_res  number(1) check ( etat_res in ( 0,
                                            1 ) ),
   primary key ( clt_id,
                 matricule,
                 date_res ),
   foreign key ( clt_id )
      references client ( clt_id ),
   foreign key ( matricule )
      references voiture ( matricule )
);

-- 4. Create Table: Maintenance
create table maintenance (
   maint_id        integer primary key,
   matricule       varchar2(20),
   date_panne      date,
   etat_reparation number(1) check ( etat_reparation in ( 0,
                                                          1 ) ),
   foreign key ( matricule )
      references voiture ( matricule )
);

-- 5. Create Table: ClientRouge
create table clientrouge (
   clt_id     integer primary key,
   date_ajout date,
   raison_ban varchar2(255),
   foreign key ( clt_id )
      references client ( clt_id )
);