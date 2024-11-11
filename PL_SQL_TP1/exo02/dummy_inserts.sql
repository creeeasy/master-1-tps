-- Insert data into Employe_Table_Exo_02
INSERT INTO Employe_Table_Exo_02 (nuempl, nomempl, salaire) VALUES ('E001', 'Alice Dupont', 45000);
INSERT INTO Employe_Table_Exo_02 (nuempl, nomempl, salaire) VALUES ('E002', 'Bob Martin', 55000);
INSERT INTO Employe_Table_Exo_02 (nuempl, nomempl, salaire) VALUES ('E003', 'Carla Rossi', 50000);
INSERT INTO Employe_Table_Exo_02 (nuempl, nomempl, salaire) VALUES ('E004', 'David Nguyen', 48000);
INSERT INTO Employe_Table_Exo_02 (nuempl, nomempl, salaire) VALUES ('E005', 'Emma Lee', 52000);

-- Insert data into Service_Table_Exo_02
INSERT INTO Service_Table_Exo_02 (nuserv, nomserv, chef) VALUES (101, 'Informatique', 'E001');
INSERT INTO Service_Table_Exo_02 (nuserv, nomserv, chef) VALUES (102, 'Ressources Humaines', 'E002');
INSERT INTO Service_Table_Exo_02 (nuserv, nomserv, chef) VALUES (103, 'Marketing', 'E003');

-- Insert data into Projet_Table_Exo_02
INSERT INTO Projet_Table_Exo_02 (nuproj, nomproj, resp) VALUES (201, 'Développement Web', 'E001');
INSERT INTO Projet_Table_Exo_02 (nuproj, nomproj, resp) VALUES (202, 'Recrutement', 'E002');
INSERT INTO Projet_Table_Exo_02 (nuproj, nomproj, resp) VALUES (203, 'Campagne Publicitaire', 'E003');
INSERT INTO Projet_Table_Exo_02 (nuproj, nomproj, resp) VALUES (204, 'Analyse de Données', 'E004');

-- Insert data into Travail_Table_Exo_02
INSERT INTO Travail_Table_Exo_02 (nuempl, nuproj, duree) VALUES ('E001', 201, 120);
INSERT INTO Travail_Table_Exo_02 (nuempl, nuproj, duree) VALUES ('E003', 203, 90);
INSERT INTO Travail_Table_Exo_02 (nuempl, nuproj, duree) VALUES ('E004', 204, 150);
INSERT INTO Travail_Table_Exo_02 (nuempl, nuproj, duree) VALUES ('E005', 201, 80);
INSERT INTO Travail_Table_Exo_02 (nuempl, nuproj, duree) VALUES ('E002', 202, 70);
