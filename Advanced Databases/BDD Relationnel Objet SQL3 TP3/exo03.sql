create type adresse_t as object (
      numero_rue integer,
      nom_rue    varchar2(50),
      nom_ville  varchar2(50)
);
create type telephonelist as
   varray(3) of varchar2(15);


create type orderslist_t as object (
      id_order integer,
      montant  integer
);


create type client_t as object (
      id_client  integer,
      nom        varchar2(100),
      adresse    adresse_t,
      telephones telephonelist,
      ville      varchar2(100),
      orders     orderslist_t
)
create table clients of client_t (
   primary key ( id_client )
)
nested table orderslist_t store as orderslist_table;