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
);



-- la question premiere 
create table personne of t_personne (
   primary key ( personne_id )
);

-- LA QUESTION deuxieme 
insert into personne values ( t_personne('MANEL') );