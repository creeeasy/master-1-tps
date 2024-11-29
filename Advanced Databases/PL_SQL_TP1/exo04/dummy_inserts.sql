-- Insert sample participants
INSERT INTO PARTICIPANT_Table_Exo_04 (id, nom, age) VALUES (1, 'Ali', 16);
INSERT INTO PARTICIPANT_Table_Exo_04 (id, nom, age) VALUES (2, 'Sophie', 55);
INSERT INTO PARTICIPANT_Table_Exo_04 (id, nom, age) VALUES (3, 'Jean', 30);
INSERT INTO PARTICIPANT_Table_Exo_04 (id, nom, age) VALUES (4, 'Marc', 45);

-- Insert sample outings
INSERT INTO SORTIE_Table_Exo_04 (id, participant_id, distance, precedent_id) VALUES (1, 1, 10, NULL);
INSERT INTO SORTIE_Table_Exo_04 (id, participant_id, distance, precedent_id) VALUES (2, 1, 15, 1);
INSERT INTO SORTIE_Table_Exo_04 (id, participant_id, distance, precedent_id) VALUES (3, 2, 20, NULL);
INSERT INTO SORTIE_Table_Exo_04 (id, participant_id, distance, precedent_id) VALUES (4, 3, 12, NULL);
INSERT INTO SORTIE_Table_Exo_04 (id, participant_id, distance, precedent_id) VALUES (5, 4, 18, NULL);
