-- 1. Factorial Function and Display Factorial(10)
create or replace function factoriel (
   n in integer
) return integer is
   result integer := 1;
begin
   for i in 1..n loop
      result := result * i;
   end loop;
   return result;
end;
/

declare
   fact_10 integer;
begin
   fact_10 := factoriel(10);
   dbms_output.put_line('Factoriel de 10: ' || fact_10);
end;
/

-- 2. Factorial Calculation with User Input
    -- Prompt the user to input a number
ACCEPT n NUMBER PROMPT 'Enter a number for factorial: ';

declare
   n           integer;
   fact_result integer;
begin
   -- Prompt for user input
   n := &n;
   
   -- Calculate factorial using the `factoriel` function
   fact_result := factoriel(n);
   
   -- Output the result
   dbms_output.put_line('Factoriel de '
                        || n
                        || ' : '
                        || fact_result);
end;
/
--  03 
--  Function to Calculate Category Based on Age
create or replace function calculer_categorie (
   p_age in number
) return varchar2 is
begin
   if p_age < 18 then
      return 'Junior';
   elsif p_age > 50 then
      return 'Senior';
   else
      return 'Middle';
   end if;
end calculer_categorie;
/
-- Function to Display Participant's Category

create or replace function afficher_categorie_participant return varchar2 is
   v_nom       participant_table_exo_04.nom%type;
   v_age       participant_table_exo_04.age%type;
   v_categorie varchar2(20);
   v_output    varchar2(4000);
begin
   for participant_record in (
      select nom,
             age
        from participant_table_exo_04
   ) loop
      v_nom := participant_record.nom;
      v_age := participant_record.age;

      -- Use the function to calculate the category
      v_categorie := calculer_categorie(v_age);
      v_output := v_nom
                  || ' : '
                  || v_categorie;
      dbms_output.put_line(v_output);
   end loop;
   return 'Affichage terminé.';
end afficher_categorie_participant;
/

begin
   dbms_output.put_line(afficher_categorie_participant);
end;
-- 04 

create or replace procedure afficher_info_participant (
   p_id in number
) is
   v_nom participant_table_exo_04.nom%type;
   v_age participant_table_exo_04.age%type;
begin
   select nom,
          age
     into
      v_nom,
      v_age
     from participant_table_exo_04
    where id = p_id;

   dbms_output.put_line('Nom: '
                        || v_nom
                        || ', Age: '
                        || v_age);
exception
   when no_data_found then
      dbms_output.put_line('Aucun participant trouvé avec l''ID ' || p_id);
end;
/
begin
   afficher_info_participant(1); -- Replace 1 with the participant ID you want to query
end;

-- 05 
-- Trigger for Deleting a Participant's Outings
create or replace trigger avant_suppression_participant before
   delete on participant_table_exo_04
   for each row
begin
   delete from sortie_table_exo_04
    where participant_id = :old.id;
end;
/
DELETE FROM PARTICIPANT_Table_Exo_04 WHERE id = 1;

-- 06 
ALTER TABLE PARTICIPANT_Table_Exo_04 
ADD (KmParcourus NUMBER DEFAULT 0, 
     categorie VARCHAR2(20));

UPDATE PARTICIPANT_Table_Exo_04
SET categorie = calculer_categorie(age);
-- test 
SELECT * FROM PARTICIPANT_Table_Exo_04;


-- 07 
CREATE OR REPLACE TRIGGER mise_a_jour_km_parcourus
   AFTER INSERT ON SORTIE_Table_Exo_04
   FOR EACH ROW
BEGIN
   UPDATE PARTICIPANT_Table_Exo_04
   SET KmParcourus = KmParcourus + :NEW.distance
   WHERE id = :NEW.participant_id;
END;
/

-- test 
INSERT INTO SORTIE_Table_Exo_04 (id, participant_id, distance, precedent_id) VALUES (6, 2, 25, NULL);

SELECT nom, KmParcourus FROM PARTICIPANT_Table_Exo_04 WHERE id = 2;

-- 08 
CREATE OR REPLACE TRIGGER verifier_precedent_id
   BEFORE INSERT OR UPDATE ON SORTIE_Table_Exo_04
   FOR EACH ROW
BEGIN
   IF :NEW.id = :NEW.precedent_id THEN
      RAISE_APPLICATION_ERROR(-20001, 'Une sortie ne peut pas être la suite d’elle-même.');
   END IF;
END;
/

INSERT INTO SORTIE_Table_Exo_04 (id, participant_id, distance, precedent_id) VALUES (7, 3, 10, 7);



