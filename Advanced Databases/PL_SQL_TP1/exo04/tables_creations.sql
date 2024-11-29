CREATE TABLE PARTICIPANT_Table_Exo_04 (
   id NUMBER PRIMARY KEY,
   nom VARCHAR2(100),
   age NUMBER,
   KmParcourus NUMBER DEFAULT 0,
   categorie VARCHAR2(20)
);
CREATE TABLE SORTIE_Table_Exo_04 (
   id NUMBER PRIMARY KEY,
   participant_id NUMBER,
   distance NUMBER, -- Distance of the outing
   precedent_id NUMBER, -- ID of the previous outing (for chaining)
   FOREIGN KEY (participant_id) REFERENCES PARTICIPANT_Table_Exo_04(id),
   FOREIGN KEY (precedent_id) REFERENCES SORTIE_Table_Exo_04(id)
);
