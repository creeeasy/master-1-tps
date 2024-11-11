-- Table for 'departement' (department)
create table DEPARTEMENT_Table_Exo_03 (
    n_dep      number primary key,
    nomd       varchar2(100)
);

-- Table for 'projet' (project)
create table PROJET_Table_Exo_03 (
    n_pro      number primary key,
    nom_proj   varchar2(100),
    n_dep      number,
    constraint fk_departement_proj foreign key (n_dep)
        references DEPARTEMENT_Table_Exo_03 (n_dep)
);

-- Table for 'employe' (employee)
create table EMPLOYE_Table_Exo_03 (
    matricule  varchar2(20) primary key,
    nomempl    varchar2(100),
    salaire    integer,
    n_dep      number,
    constraint fk_departement_emp foreign key (n_dep)
        references DEPARTEMENT_Table_Exo_03 (n_dep)
);

-- Table for 'travaille' (work on project)
create table TRAVAILLE_Table_Exo_03 (
    matricule  varchar2(20),
    n_proj     number,
    duree      integer,
    primary key (matricule, n_proj),
    constraint fk_emp_travail foreign key (matricule)
        references EMPLOYE_Table_Exo_03 (matricule),
    constraint fk_proj_travail foreign key (n_proj)
        references PROJET_Table_Exo_03 (n_pro)
);
