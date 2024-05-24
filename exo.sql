create database vente_en_ligne;

\c vente_en_ligne;

CREATE TABLE "user"(
        id_user     Varchar (25) NOT NULL ,
        nom_user    Varchar (150) ,
        prenom_user Varchar (150) ,
        telephone   Int
	,CONSTRAINT User_PK PRIMARY KEY (id_user)
);


CREATE TABLE Mode_payment(
        id_credit  Int NOT NULL ,
        nom_credit Varchar (150)
	,CONSTRAINT Mode_payment_PK PRIMARY KEY (id_credit)
);

CREATE TABLE Article(
        reference Varchar (25) NOT NULL ,
        nom       Varchar (150) ,
        prix      DECIMAL (15,3)  ,
        type      Varchar (150) ,
        id_credit Int NOT NULL
	,CONSTRAINT Article_PK PRIMARY KEY (reference)
	,CONSTRAINT Article_Mode_payment_FK FOREIGN KEY (id_credit) REFERENCES Mode_payment(id_credit)
);

CREATE TABLE Acheter(
        reference  Varchar (25) NOT NULL ,
        id_user    Varchar (25) NOT NULL ,
        date_achat TimeStamp ,
        quantite   Int
	,CONSTRAINT Acheter_PK PRIMARY KEY (reference,id_user)
	,CONSTRAINT Acheter_Article_FK FOREIGN KEY (reference) REFERENCES Article(reference)
	,CONSTRAINT Acheter_User0_FK FOREIGN KEY (id_user) REFERENCES "user"(id_user)
);



INSERT INTO Mode_payment 
VALUES (1, 'MVola'),(2, 'Espece');

INSERT INTO Article 
VALUES ('A001', 'Yogurt', 1500, 'Food', 1),('M001', 'Souris', 5000, 'Informatique', 2),('M002', 'Pc', 12000000, 'Informatique', 2);

INSERT INTO Acheter 
VALUES ('A001', '001', '2023-05-24 15:30:00', 5);



---------------- Question 2-------------------
INSERT INTO "user" 
VALUES ('001', 'Rakoto', 'Rabe', 0341245612);

---------------- Question 3a-------------------
SELECT COUNT(*) AS articles 
FROM Article;

---------------- Question 3b-------------------
SELECT type, 
       MIN(prix) AS min, 
       MAX(prix) AS max 
FROM Article 
GROUP BY type;

---------------- Question 3c-------------------
SELECT A.reference, A.nom, AC.date_achat, AC.quantite, (AC.quantite * A.prix) AS total 
FROM Acheter AC
INNER JOIN Article A ON AC.reference = A.reference
INNER JOIN "user" U ON AC.id_user = U.id_user
WHERE U.nom_user = 'Rakoto';

---------------- Question 3d-------------------
SELECT A.nom, SUM(AC.quantite) AS total
FROM Acheter AC
INNER JOIN Article A ON AC.reference = A.reference
GROUP BY A.nom
ORDER BY total_sold DESC;


