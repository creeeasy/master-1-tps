create or replace trigger verif_departement_proj before
   insert on travaille_table_exo_03
   for each row
declare
   v_departement_proj number;
   v_departement_emp  number;
begin
   -- Get the department number for the project
   select n_dep
     into v_departement_proj
     from projet_table_exo_03
    where n_pro = :new.n_proj;

   -- Get the department number for the employee
   select n_dep
     into v_departement_emp
     from employe_table_exo_03
    where matricule = :new.matricule;

   -- Check if the department of the employee matches the project's department
   if v_departement_proj != v_departement_emp then
      raise_application_error(
         -20001,
         'L''employé ne peut pas travailler sur un projet qui n''appartient pas à son département.'
      );
   end if;
end;
/
-- for test 
-- This should fail (department mismatch)
insert into travaille_table_exo_03 (
   matricule,
   n_proj,
   duree
) values ( 'E003',
           103,
           8 );

-- This should fail (department mismatch)
insert into travaille_table_exo_03 (
   matricule,
   n_proj,
   duree
) values ( 'E004',
           101,
           5 );




-- question 02 
create or replace trigger suivi_changements_salaire before
   update of salaire on employe_table_exo_03
   for each row
declare
   v_initial_salaire number;
begin
   -- Get the current salary before the update
   select salaire
     into v_initial_salaire
     from employe_table_exo_03
    where matricule = :old.matricule;

   -- Check if the new salary exceeds a 20% change
   if :new.salaire > v_initial_salaire * 1.2
   or :new.salaire < v_initial_salaire * 0.8 then
      raise_application_error(
         -20002,
         'Le changement de salaire dépasse la limite de 20% du salaire initial.'
      );
   end if;
end;
/


-- question 03 
--  Prevent Name Changes
create or replace trigger prevent_dept_name_change before
   update of nomd on departement_table_exo_03
   for each row
begin
   raise_application_error(
      -20003,
      'Le nom du département ne peut pas être modifié une fois créé.'
   );
end;
/

-- Prevent Deletions
create or replace trigger prevent_dept_deletion before
   delete on departement_table_exo_03
   for each row
begin
   raise_application_error(
      -20004,
      'Le département ne peut pas être supprimé une fois créé.'
   );
end;
/