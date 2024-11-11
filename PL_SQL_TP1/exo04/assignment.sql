-- 1. Factorial Function and Display Factorial(10)
CREATE OR REPLACE FUNCTION factoriel (n IN INTEGER) RETURN INTEGER IS
   result INTEGER := 1;
BEGIN
   FOR i IN 1..n LOOP
      result := result * i;
   END LOOP;
   RETURN result;
END;
/

DECLARE
   fact_10 INTEGER;
BEGIN
   fact_10 := factoriel(10);
   DBMS_OUTPUT.PUT_LINE('Factoriel de 10: ' || fact_10);
END;
/

-- 2. Factorial Calculation with User Input
    -- Prompt the user to input a number
ACCEPT n NUMBER PROMPT 'Enter a number for factorial: ';

DECLARE
   n INTEGER;
   fact_result INTEGER;
BEGIN
   -- Prompt for user input
   n := &n;
   
   -- Calculate factorial using the `factoriel` function
   fact_result := factoriel(n);
   
   -- Output the result
   DBMS_OUTPUT.PUT_LINE('Factoriel de ' || n || ' : ' || fact_result);
END;
/
--  03 
--  Function to Calculate Category Based on Age
CREATE OR REPLACE FUNCTION calculer_categorie (p_age IN NUMBER) RETURN VARCHAR2 IS
BEGIN
   IF p_age < 18 THEN
      RETURN 'Junior';
   ELSIF p_age > 50 THEN
      RETURN 'Senior';
   ELSE
      RETURN 'Middle';
   END IF;
END calculer_categorie;
/
-- Function to Display Participant's Category

CREATE OR REPLACE FUNCTION afficher_categorie_participant RETURN VARCHAR2 IS
   v_nom PARTICIPANT_Table_Exo_04.nom%TYPE;
   v_age PARTICIPANT_Table_Exo_04.age%TYPE;
   v_categorie VARCHAR2(20);
   v_output VARCHAR2(4000);
BEGIN
   FOR participant_record IN (SELECT nom, age FROM PARTICIPANT_Table_Exo_04) LOOP
      v_nom := participant_record.nom;
      v_age := participant_record.age;

      -- Use the function to calculate the category
      v_categorie := calculer_categorie(v_age);

      v_output := v_nom || ' : ' || v_categorie;
      DBMS_OUTPUT.PUT_LINE(v_output);
   END LOOP;
   RETURN 'Affichage terminé.';
END afficher_categorie_participant;
/


-- 04 

CREATE OR REPLACE PROCEDURE afficher_info_participant (p_id IN NUMBER) IS
   v_nom PARTICIPANT_Table_Exo_04.nom%TYPE;
   v_age PARTICIPANT_Table_Exo_04.age%TYPE;
BEGIN
   SELECT nom, age INTO v_nom, v_age
   FROM PARTICIPANT_Table_Exo_04
   WHERE id = p_id;

   DBMS_OUTPUT.PUT_LINE('Nom: ' || v_nom || ', Age: ' || v_age);
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Aucun participant trouvé avec l''ID ' || p_id);
END;
/

-- 05 
-- Trigger for Deleting a Participant's Outings
CREATE OR REPLACE TRIGGER avant_suppression_participant
   BEFORE DELETE ON PARTICIPANT_Table_Exo_04
   FOR EACH ROW
BEGIN
   DELETE FROM SORTIE_Table_Exo_04 WHERE participant_id = :OLD.id;
END;
/


