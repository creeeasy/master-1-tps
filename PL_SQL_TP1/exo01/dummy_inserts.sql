-- Insert data into Client table
INSERT INTO client (clt_id, clt_nom, clt_email, clt_vip) VALUES (1, 'John Doe', 'johndoe@example.com', 1);
INSERT INTO client (clt_id, clt_nom, clt_email, clt_vip) VALUES (2, 'Jane Smith', 'janesmith@example.com', 0);
INSERT INTO client (clt_id, clt_nom, clt_email, clt_vip) VALUES (3, 'Alice Brown', 'alicebrown@example.com', 1);
INSERT INTO client (clt_id, clt_nom, clt_email, clt_vip) VALUES (4, 'Bob White', 'bobwhite@example.com', 0);

-- Insert data into Voiture table
INSERT INTO voiture (matricule, moteur_taille, kilom, marque, modele) VALUES ('ABC123', 1800, 120000, 'Toyota', 2019);
INSERT INTO voiture (matricule, moteur_taille, kilom, marque, modele) VALUES ('XYZ789', 2000, 90000, 'Ford', 2018);
INSERT INTO voiture (matricule, moteur_taille, kilom, marque, modele) VALUES ('LMN456', 1600, 150000, 'Honda', 2020);
INSERT INTO voiture (matricule, moteur_taille, kilom, marque, modele) VALUES ('JKL321', 2500, 75000, 'Chevrolet', 2017);

-- Insert data into Reserver table
INSERT INTO reserver (clt_id, matricule, date_res, date_ret, nb_jours, etat_res) 
VALUES (1, 'ABC123', TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-10', 'YYYY-MM-DD'), 9, 1);
INSERT INTO reserver (clt_id, matricule, date_res, date_ret, nb_jours, etat_res) 
VALUES (2, 'XYZ789', TO_DATE('2024-09-05', 'YYYY-MM-DD'), TO_DATE('2024-09-15', 'YYYY-MM-DD'), 10, 0);
INSERT INTO reserver (clt_id, matricule, date_res, date_ret, nb_jours, etat_res) 
VALUES (3, 'LMN456', TO_DATE('2024-08-20', 'YYYY-MM-DD'), TO_DATE('2024-08-25', 'YYYY-MM-DD'), 5, 1);
INSERT INTO reserver (clt_id, matricule, date_res, date_ret, nb_jours, etat_res) 
VALUES (4, 'JKL321', TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-07', 'YYYY-MM-DD'), 6, 0);

-- Insert data into Maintenance table
INSERT INTO maintenance (maint_id, matricule, date_panne, etat_reparation) 
VALUES (1, 'ABC123', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 0);
INSERT INTO maintenance (maint_id, matricule, date_panne, etat_reparation) 
VALUES (2, 'XYZ789', TO_DATE('2024-06-15', 'YYYY-MM-DD'), 1);
INSERT INTO maintenance (maint_id, matricule, date_panne, etat_reparation) 
VALUES (3, 'LMN456', TO_DATE('2024-05-10', 'YYYY-MM-DD'), 0);
INSERT INTO maintenance (maint_id, matricule, date_panne, etat_reparation) 
VALUES (4, 'JKL321', TO_DATE('2024-04-20', 'YYYY-MM-DD'), 1);

-- Insert data into ClientRouge table
INSERT INTO clientrouge (clt_id, date_ajout, raison_ban) 
VALUES (2, TO_DATE('2024-08-01', 'YYYY-MM-DD'), 'Unpaid rentals');
INSERT INTO clientrouge (clt_id, date_ajout, raison_ban) 
VALUES (4, TO_DATE('2024-09-12', 'YYYY-MM-DD'), 'Damaged vehicle on return');


--  pour la question 04
-- Insert additional data into Client table if needed
INSERT INTO client (clt_id, clt_nom, clt_email, clt_vip) VALUES (5, 'Carlos Green', 'carlosgreen@example.com', 1);
INSERT INTO client (clt_id, clt_nom, clt_email, clt_vip) VALUES (6, 'Emily Red', 'emilyred@example.com', 0);

-- Insert data into Voiture table for the required matricules if not already present
INSERT INTO voiture (matricule, moteur_taille, kilom, marque, modele) VALUES ('DEF567', 1800, 100000, 'Nissan', 2016);
INSERT INTO voiture (matricule, moteur_taille, kilom, marque, modele) VALUES ('GHI789', 2200, 80000, 'Mazda', 2015);

-- Insert data into Reserver table for July 2020 reservations
INSERT INTO reserver (clt_id, matricule, date_res, date_ret, nb_jours, etat_res) 
VALUES (5, 'DEF567', TO_DATE('2020-07-15', 'YYYY-MM-DD'), TO_DATE('2020-07-20', 'YYYY-MM-DD'), 5, 1);
INSERT INTO reserver (clt_id, matricule, date_res, date_ret, nb_jours, etat_res) 
VALUES (6, 'GHI789', TO_DATE('2020-07-18', 'YYYY-MM-DD'), TO_DATE('2020-07-25', 'YYYY-MM-DD'), 7, 0);
