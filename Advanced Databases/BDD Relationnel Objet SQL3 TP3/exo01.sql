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

create type tpersonne as object (
      nss            integer,
      nom            tnom,
      date_naissance date,
      adresse        tadresse,
      telephone      ttelephone
) not final;

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
-- create table etudiant of tetudiant (
--    primary key ( n_etudiant )
-- )
-- nested table diplome store as diplome_nt;

-- create table enseignant of tensignant (
--    primary key ( employee_id )
-- );

-- deuxieme question 
insert into personne values ( tetudiant(
   123123123, -- NSS
   tnom(
      'MERABETI',
      'Adam'
   ), -- Name
   to_date('1985-05-01',
          'YYYY-MM-DD'), -- Date of Birth
   tadresse(
      'Didouche Mourad',
      null,
      'Alger',
      'Algérie',
      null
   ), -- Address
   ttelephone(), -- Empty phone numbers (no phone)
   999, -- Student number
   'Informatique', -- Department
   t_diplome_set() -- No diplomas
) );

-- troiseme question 

insert into personne values ( tensignement(
   666999666,                                      -- NSS
   tnom(
      'LAMARI',
      'Meriem'
   ),                        -- Nom (Family Name and First Name)
   to_date('1975-06-04',
             'YYYY-MM-DD'),            -- Date of Birth
   tadresse(
      '99 Boulevard Colonel Amirouche',
      '',
      'Alger',
      'Algérie',
      null
   ), -- Adresse
   ttelephone(),                                    -- Telephone (empty array)
   777,                                           -- Employee Number
   tcompte(
      310123456789,
      'BDA'
   )                    -- Bank Account (Account Number and Bank)
) );


-- quatrieme question 


insert into personne values ( tensignement(
   556978566,                                      -- NSS
   tnom(
      'SALEMI',
      'Ahmed'
   ),                        -- Nom (Family Name and First Name)
   to_date('1965-06-04',
             'YYYY-MM-DD'),            -- Date of Birth
   tadresse(
      '99 Ismail Yafsah',
      '',
      'Alger',
      'Algérie',
      null
   ), -- Adresse
   ttelephone(),                                    -- Telephone (empty array)
   787,                                           -- Employee Number
   tcompte(
      330123489756,
      'BEA'
   )                    -- Bank Account (Account Number and Bank)
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

select distinct p.nss,
                p.nom.nom_famille,
                t.column_value
  from personne p,
       table ( p.telephone ) t
 order by p.nss;


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
-- PART 03 N'AI PAS TERMINE 