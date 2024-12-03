-- la question premiere 

create type tnom as object (
      nom_famille varchar2(100),
      prenom      varchar2(100)
);

create type tadresse as object (
      rue         varchar2(100),
      numero      varchar2(100),
      ville       varchar2(100),
      pays        varchar2(100),
      code_postal integer
);

create type ttelephone as
   varray(10) of integer;


-- la question deuxieme 
create or replace type tpersonne as object (
      nss            integer,
      nom            tnom,
      date_naissance date,
      adresse        tadresse,
      telephone      ttelephone,
      member function get_age return integer
) not final;

create or replace type body tpersonne as
   member function get_age return integer is
      years_difference integer;
   begin
      years_difference := extract(year from sysdate) - extract(year from date_naissance);
      if to_date ( to_char(
         sysdate,
         'MM-DD'
      ),'MM-DD' ) < to_date ( to_char(
         date_naissance,
         'MM-DD'
      ),'MM-DD' ) then
         years_difference := years_difference - 1;
      end if;

      return years_difference;
   end;
end;

-- la question troiseme 
create table personne of tpersonne (
   primary key ( nss )
);

-- la question quatrieme 

insert into personne values ( 123456789, -- NSS
                              tnom(
                                 'ADIMI',
                                 'Mohamed'
                              ), --
                              to_date('1980-01-01','YYYY-MM-DD'),
                              tadresse(
                                 'Rue de la Gare',
                                 '22',
                                 'Alger',
                                 'Algérie',
                                 1600
                              ),
                              ttelephone(
                                 023112345,
                                 0554321921
                              ) );


-- 02 
create type tcompte as object (
      numero integer,
      banque varchar2(100)
);
create type tdiplome as object (
      nom   varchar2(100),
      annee integer
);

create type t_diplome_set as
   table of tdiplome;
create type tensignement under tpersonne (
      n_ens  integer,
      compte tcompte
);

create or replace type tetudiant under tpersonne (
      n_etudiant integer,
      department varchar2(100),
      diplome    t_diplome_set
);

-- deuxieme question 

insert into personne values ( tetudiant(
   123123123,
   tnom(
      'MERABETI',
      'Adam'
   ),
   to_date('1985-05-01',
          'YYYY-MM-DD'),
   tadresse(
      'Didouche Mourad',
      null,
      'Alger',
      'Algérie',
      null
   ),
   ttelephone(),
   999,
   'Informatique',
   t_diplome_set()
) );

-- troiseme question 

insert into personne values ( tensignement(
   666999666,
   tnom(
      'LAMARI',
      'Meriem'
   ),
   to_date('1975-06-04',
             'YYYY-MM-DD'),
   tadresse(
      '99 Boulevard Colonel Amirouche',
      '',
      'Alger',
      'Algérie',
      null
   ), -- Adresse
   ttelephone(),
   777,
   tcompte(
      310123456789,
      'BDA'
   )
) );


-- quatrieme question 


insert into personne values ( tensignement(
   556978566,
   tnom(
      'SALEMI',
      'Ahmed'
   ),
   to_date('1965-06-04',
             'YYYY-MM-DD'),
   tadresse(
      '99 Ismail Yafsah',
      '',
      'Alger',
      'Algérie',
      null
   ), -- Adresse
   ttelephone(),
   787,
   tcompte(
      330123489756,
      'BEA'
   )
) );
-- cinqieme question 
update personne
   set
   telephone = ttelephone(
      022342222,
      066543333
   )
 where nss = 123123123;

-- siexieme question 
update personne
   set
   telephone = ttelephone(
      022342222,
      066543333
   )
 where nss = 666999666;

-- septieme question :
select p.nom.nom_famille,
       p.nom.prenom,
       treat(value(p) as tetudiant).n_etudiant as numero
  from personne p
 where value(p) is of ( tetudiant );

-- huitieme question 

select p1.nom.nom_famille as nom_famille_1,
       p1.nom.prenom as prenom_1,
       p2.nom.nom_famille as nom_famille_2,
       p2.nom.prenom as prenom_2,
       t1.column_value as shared_phone_number
  from personne p1,
       table ( p1.telephone ) t1,
       personne p2,
       table ( p2.telephone ) t2
 where t1.column_value = t2.column_value
   and p1.nss < p2.nss
 order by p1.nom.nom_famille,
          p2.nom.nom_famille;



--  PART 03 
-- LA QUESTION PREMIRE 

create type t_cours as object (
      n_cour  integer,       -- Course code
      libelle varchar2(200),     -- Course name
      credit  number(3)
);


create type t_evaluation as object (
      note    integer,       -- Grade (e.g., 85.50)
      evadate date                -- Date of the evaluation
);
-- PART 03

create type tcours;
create type tevaluation;
create type t_set_ref_cours as
   table of ref tcours;
create type t_set_ref_evaluation as
   table of ref tevaluation;

alter type tensignement add attribute enseignant_cours ref tcours
   cascade;

alter type tetudiant add attribute etudiant_cours t_set_ref_cours
   cascade;

alter type tetudiant add attribute etudiant_evaluation t_set_ref_evaluation
   cascade;


create type t_set_ref_etudiant as
   table of ref tetudiant;
create type t_set_ref_enseignant as
   table of ref tensignement;

create or replace type tcours as object (
      numero_cours     varchar2(5),
      libelle          varchar2(50),
      credit           integer,
      est_pre_requis   t_set_ref_cours,
      a_pre_requis     t_set_ref_cours,
      cours_enseignant t_set_ref_enseignant,
      cours_evaluation t_set_ref_evaluation,
      cours_etudiant   t_set_ref_etudiant
);
create or replace type tevaluation as object (
      evaluation_cours    ref tcours,
      evaluation_etudiant ref tetudiant,
      date_evaluation     date,
      note                number(
         4,
         2
      )
);

-- creation de la table 
-- la table cours 
create table cours of tcours (
   primary key ( numero_cours )
)
   nested table est_pre_requis store as table_est_pre_requis,
   nested table a_pre_requis store as table_a_pre_requis,
   nested table cours_etudiant store as table_cours_etudiant,
   nested table cours_enseignant store as table_cours_enseignant,
   nested table cours_evaluation store as table_cours_evaluation;
   -- la table evaluation 
create table evaluation of tevaluation (
   foreign key ( evaluation_cours )
      references cours,
   foreign key ( evaluation_etudiant )
      references personne
);