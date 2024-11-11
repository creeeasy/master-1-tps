-- Insert data into DEPARTEMENT_Table_Exo_03
insert into DEPARTEMENT_Table_Exo_03 (n_dep, nomd) values (1, 'Human Resources');
insert into DEPARTEMENT_Table_Exo_03 (n_dep, nomd) values (2, 'Information Technology');
insert into DEPARTEMENT_Table_Exo_03 (n_dep, nomd) values (3, 'Accounting');

-- Insert data into PROJET_Table_Exo_03
insert into PROJET_Table_Exo_03 (n_pro, nom_proj, n_dep) values (101, 'Software Development', 2);
insert into PROJET_Table_Exo_03 (n_pro, nom_proj, n_dep) values (102, 'Data Analysis', 2);
insert into PROJET_Table_Exo_03 (n_pro, nom_proj, n_dep) values (103, 'System Updates', 1);

-- Insert data into EMPLOYE_Table_Exo_03
insert into EMPLOYE_Table_Exo_03 (matricule, nomempl, salaire, n_dep) values ('E001', 'Ahmed Ali', 5000, 1);
insert into EMPLOYE_Table_Exo_03 (matricule, nomempl, salaire, n_dep) values ('E002', 'Mariam Said', 6000, 2);
insert into EMPLOYE_Table_Exo_03 (matricule, nomempl, salaire, n_dep) values ('E003', 'Fatimah Al-Zahra', 4500, 3);
insert into EMPLOYE_Table_Exo_03 (matricule, nomempl, salaire, n_dep) values ('E004', 'Youssef Hassan', 5500, 1);

-- Insert data into TRAVAILLE_Table_Exo_03
insert into TRAVAILLE_Table_Exo_03 (matricule, n_proj, duree) values ('E001', 101, 6);
insert into TRAVAILLE_Table_Exo_03 (matricule, n_proj, duree) values ('E002', 102, 4);
insert into TRAVAILLE_Table_Exo_03 (matricule, n_proj, duree) values ('E003', 103, 8);
insert into TRAVAILLE_Table_Exo_03 (matricule, n_proj, duree) values ('E004', 101, 5);
