EXERCICE3:

1-CREATE TYPE Adresse_t as object(
    numero_rue INT,        
    nom_rue VARCHAR(100), 
    nom_ville VARCHAR(100) 
);

2- CREATE OR REPLACE TYPE TelephoneList AS VARRAY(3) OF VARCHAR2(15);

3-
CREATE OR REPLACE TYPE OrderType AS OBJECT (
    id_order NUMBER,    
    montant NUMBER      
);

CREATE OR REPLACE TYPE OrdersList AS TABLE OF OrderType;

4-
CREATE OR REPLACE TYPE Adresse_t AS OBJECT (
    numero_rue NUMBER, 
    nom_rue VARCHAR2(100),
    ville VARCHAR2(100)
);


CREATE OR REPLACE TYPE TelephoneList AS VARRAY(3) OF VARCHAR2(15);


CREATE OR REPLACE TYPE Client AS OBJECT (
    id_client NUMBER,          
    nom VARCHAR2(100),       
    adresse Adresse_t,         
    telephones TelephoneList,  
    ville VARCHAR2(100),       
    orders OrdersList          
);

5-   CREATE TABLE Clients OF Client (
    id_client NUMBER PRIMARY KEY,        
    nom VARCHAR2(100),                   
    adresse Adresse_t,                   
    telephones TelephoneList,            
    ville VARCHAR2(50),                  
    orders OrdersList                   
)
NESTED TABLE orders STORE AS table_orders;  

CREATE TABLE clients OF Client;
ou
CREATE TABLE Clients (
    id_client NUMBER PRIMARY KEY,           
    nom VARCHAR2(100),                      
    adresse Adresse_t,                      
    telephones TelephoneList,                
    ville VARCHAR2(50),                      
    orders OrdersList                        
);

6-
INSERT INTO clients (id_client, nom, adresse, telephones, ville, orders)
VALUES (
    1, 
    'Mme. Ghazi', 
    Adresse_t(123, 'Rue USTHB', 'Alger'), 
    TelephoneList('0123456789', '0987654321', '0246802468'), 
    'Alger', 
    OrdersList(
        OrderType(1, 100.50),  
        OrderType(2, 200.00)  
    )
);

7-SELECT c.nom, o.id_order, o.montant
FROM clients c, TABLE(c.orders) o
WHERE c.ville = 'xxx';


8-
CREATE OR REPLACE TYPE Produit AS OBJECT (
    id_produit NUMBER,        
    nom_produit VARCHAR2(100),
    prix NUMBER               
);

9-CREATE TABLE Produits OF Produit;

10-
CREATE TABLE Commandes (
    id_commande NUMBER PRIMARY KEY, 
    ref_produit REF Produit          
);

11-
INSERT INTO Produits VALUES (1, 'Produit A', 50.00);
INSERT INTO Produits VALUES (2, 'Produit B', 75.00);


DECLARE
    p_ref REF Produit;
BEGIN
    
    SELECT REF(p) INTO p_ref FROM Produits p WHERE p.id_produit = 1;
    
   
    INSERT INTO Commandes (id_commande, ref_produit) VALUES (1, p_ref);
END;


12-SELECT c.id_commande, DEREF(c.ref_produit).nom_produit AS produit_nom, DEREF(c.ref_produit).prix AS produit_prix
FROM Commandes c
WHERE c.id_commande = 1;


13-
CREATE OR REPLACE TYPE CompteBancaire AS OBJECT (
    num_compte NUMBER,      
    solde NUMBER,           
    MEMBER FUNCTION obtenir_solde RETURN NUMBER
);

14-
CREATE TABLE comptes OF CompteBancaire;

15-
CREATE OR REPLACE TYPE BODY CompteBancaire AS
    MEMBER FUNCTION obtenir_solde RETURN NUMBER IS
    BEGIN
        RETURN solde;  -- Retourne le solde de l'objet
    END obtenir_solde;
END;

16-
INSERT INTO comptes (num_compte, solde) VALUES (12345, 1500.00);

17-
SELECT c.num_compte, c.obtenir_solde() AS solde
FROM comptes c
WHERE c.num_compte = 12345;


