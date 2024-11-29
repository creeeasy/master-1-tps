--  funciton 01 
create or replace procedure update_salaire (
   p_nuempl  in varchar2,
   p_montant in integer
) is
begin
   update employe_table_exo_02
      set
      salaire = p_montant
    where nuempl = p_nuempl;

   if sql%rowcount = 0 then
      raise_application_error(
         -20001,
         'Employé non trouvé ou aucun changement de salaire.'
      );
   end if;
   commit;
end;

declare
   v_nuempl  varchar2(20) := 'E001';
   v_montant integer := 5500;
begin
   update_salaire(
      v_nuempl,
      v_montant
   );
   dbms_output.put_line('Salaire mis à jour pour l employé '
                        || v_nuempl
                        || ' à '
                        || v_montant);
exception
   when others then
      dbms_output.put_line('Error: ' || sqlerrm);
end;
/

-- function 02 

create or replace function nb_employes_projet (
   p_nuproj in integer
) return integer is
   v_count integer;
begin
   select count(*)
     into v_count
     from travail_table_exo_02
    where nuproj = p_nuproj;

   return v_count;
end;

declare
   emp_count integer;
begin
   emp_count := nb_employes_projet(201);
   dbms_output.put_line('Nombre d employés sur le projet : ' || emp_count);
end;

-- function 03 

create or replace function nb_projets_employe (
   p_nuempl in varchar2
) return integer is
   v_count integer;
begin
   select count(*)
     into v_count
     from travail_table_exo_02
    where nuempl = p_nuempl;

   return v_count;
end;

declare
   proj_count integer;
begin
   proj_count := nb_projets_employe('E001');
   dbms_output.put_line('Nombre de projets pour l employé : ' || proj_count);
end;

-- function 04 

create or replace function evaluer_salaire (
   p_nuempl in varchar2
) return varchar2 is
   v_salaire     integer;
   v_avg_salaire integer;
begin
   select salaire
     into v_salaire
     from employe_table_exo_02
    where nuempl = p_nuempl;

   if v_salaire is null then
      raise_application_error(
         -20002,
         'Employé non trouvé.'
      );
   end if;
   select avg(salaire)
     into v_avg_salaire
     from employe_table_exo_02;

   if v_salaire > v_avg_salaire then
      return 'Bon salaire';
   else
      return 'Salaire faible';
   end if;
end;

declare
   salary_evaluation varchar2(100);
   v_nuempl          varchar2(20) := 'E001'; -- Adjust with actual employee ID
begin
   salary_evaluation := evaluer_salaire(v_nuempl);
   dbms_output.put_line('Salary evaluation for employee '
                        || v_nuempl
                        || ': '
                        || salary_evaluation);
exception
   when others then
      dbms_output.put_line('Error: ' || sqlerrm);
end;
/