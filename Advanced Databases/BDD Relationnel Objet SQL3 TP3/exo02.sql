-- drop type t_personne force ;

create type t_personne;
create type t_set_tag as
   table of varchar2(20);
create type t_message as object (
      text      varchar2(500),
      dateecrit date,
      tags      t_set_tag
)
create type t_set_message as
   table of t_message;
create type t_contact as object (
      p      ref t_personne,
      depuis date
)

create type t_set_contact as
   table of t_contact;
create or replace type t_personne as object (
      prenom varchar2(30),
      suit   t_set_contact,
      ecrit  t_set_message
) not final;



-- la question premiere 
create table personne_table of t_personne (
   primary key ( prenom )
)
   nested table suit store as suit_table,
   nested table ecrit store as ecrit_table (
      nested table tags store as table_tags
   );



-- LA QUESTION deuxieme 

insert into personne_table values ( t_personne(
   'Manel',
   t_set_contact(t_contact(
      (
         select ref(p)
           from personne p
          where p.prenom = 'Amel'
      ),
      '11/06/2017'
   )),
   t_set_message(t_message(
      'Oran candidat aux jeux Méditerranéens 2022',
      '
01/06/2018',
      t_set_tag('JM2022')
   ))
) );


-- LA TROISEME QUESTION :
update personne p
   set
   suit = set(
      suit,
      t_contact(
           (
              select ref(b)
                from personne b
               where b.prenom = 'Badis'
           ),
           date '2018-06-01'
        )
   )
 where p.prenom = 'Manel';
-- LA QUATRIEME QUESTION
-- a  
select distinct c.p.prenom
  from personne a,
       table ( a.suit ) c,
       table ( c.p.ecrit ) m
 where a.prenom = 'Amel'
   and c.depuis <= date '2018-06-01'
   and 'JM2022' member of m.tags;

-- b
select m.dateecrit,
       p
  from personne p,
       table ( p.ecrit ) m
 where m.dateecrit in (
   select a.dateecrit
     from personne a,
          table ( a.ecrit ) am
    where a.prenom = 'Amel'
)
 order by m.dateecrit asc;

-- c
select t.column_value as tag,
       count(distinct p.prenom) as nb_personnes
  from personne p,
       table ( p.ecrit ) m,
       table ( m.tags ) t
 group by t.column_value;

-- LA CINQIEME QUESTION
create or replace type body t_personne as
   member function mestags return t_set_tag is
      result_tags t_set_tag := t_set_tag();
   begin
      for message in (
         select tags
           from table ( ecrit )
      ) loop
         for tag in (
            select column_value
              from table ( message.tags )
         ) loop
            if not result_tags.exists(tag) then
               result_tags.extend;
               result_tags(result_tags.last) := tag;
            end if;
         end loop;
      end loop;
      return result_tags;
   end;
end;
/