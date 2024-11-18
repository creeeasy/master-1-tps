-- 1. Afficher tous les clients VIP
select clt_nom,
       clt_email
  from client
 where clt_vip = 1;

-- 2. Afficher toutes les voitures actuellement en réparation
select v.matricule
  from voiture v
  join maintenance m
on v.matricule = m.matricule
 where m.etat_reparation = 1;

-- 3. Afficher le nom et l'e-mail des clients rouges
select c.clt_nom,
       c.clt_email
  from client c
  join clientrouge cr
on c.clt_id = cr.clt_id;

-- 4. Afficher le nom du client et son matricule de toutes les réservations effectuées en juillet 2020
select c.clt_nom,
       r.matricule
  from client c
  join reserver r
on c.clt_id = r.clt_id
 where extract(month from r.date_res) = 7
   and extract(year from r.date_res) = 2020;

-- 5. Afficher les noms des clients et le nombre de voitures réservées pour chaque client en juillet 2020
select c.clt_nom,
       count(r.matricule) as nb_voitures_reservees
  from client c
  join reserver r
on c.clt_id = r.clt_id
 where extract(month from r.date_res) = 7
   and extract(year from r.date_res) = 2020
 group by c.clt_nom;

-- 6. Fonction nb_reservation(client) qui renvoie le nombre de voitures réservées du client spécifié
create or replace function nb_reservation (
   p_client_id in integer
) return integer is
   v_count integer;
begin
   select count(*)
     into v_count
     from reserver
    where clt_id = p_client_id;
   return v_count;
end;

-- Example: Get the number of reservations for a client with `clt_id = 1`
declare
   v_count integer;
begin
   v_count := nb_reservation(1);
   dbms_output.put_line('Number of reservations: ' || v_count);
end;


-- 7. Fonction enMaintenance(voiture) qui retourne TRUE si la voiture est en réparation
create or replace function enmaintenance (
   p_matricule in varchar2
) return boolean is
   v_count integer;
begin
   select count(*)
     into v_count
     from maintenance
    where matricule = p_matricule
      and etat_reparation = 1;
   return v_count > 0;
end;

declare
   v_under_maintenance boolean;
begin
   v_under_maintenance := enmaintenance('ABC123');
   if v_under_maintenance then
      dbms_output.put_line('La voiture est en maintenance.');
   else
      dbms_output.put_line('La voiture n''est pas en maintenance.');
   end if;
end;

-- 8. Procédure inserer_client(clt_id, raison) qui insère dans ClientRouge un nouvel enregistrement
create or replace procedure inserer_client (
   p_clt_id in integer,
   p_raison in varchar2
) is
begin
   insert into clientrouge (
      clt_id,
      date_ajout,
      raison_ban
   ) values ( p_clt_id,
              sysdate,
              p_raison );
   commit;
end;
-- Example: Insert a client with `clt_id = 3` and a reason for banning
begin
   inserer_client(
      3,
      'Repeated cancellations'
   );
   dbms_output.put_line('Client inserted into ClientRouge.');
end;




-- creer un trigger alert vidange qui interdit
--  la reservation des voitures dans le kilo >
--   100 000 km de plus de 4 jours. 


create or replace trigger alert_vidange before
   insert on reserver
   for each row
declare
   number_jours_reserved integer;
   kilo                  number;
begin
   select kilom
     into kilo
     from voiture
    where matricule = :new.matricule;
   number_jours_reserved := :new.number_jours_reserved;
   if
      kilo > 100000
      and number_jours_reserved > 4
   then
      raise_application_error(
         -20001,
         'Il est interdit de reserver cette voiture car nb reservation > 4.'
      );
   end if;
end;
/

create or replace trigger alert_vidange before
   insert on reserver
   for each row
declare
   v_kilom_voiture voiture.kilom%type;
   v_nb_jours      reserver.nb_jours%type;
begin
   select kilom
     into v_kilom_voiture
     from voiture
    where matricule = :new.matricule;

   v_nb_jours := :new.nb_jours;
   if
      v_kilom_voiture > 100000
      and v_nb_jours > 4
   then
      raise_application_error(
         -20001,
         'ERROR DE RESERVATION CAR > 4.'
      );
   end if;
end;
/