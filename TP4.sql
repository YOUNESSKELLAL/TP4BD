SQL> create table Usine (
  2  nu int primary key,
  3  NomU VARCHAR2(255),
  4  Ville VARCHAR2(255)
  5  );

Table crÚÚe.

SQL> CREATE TABLE Produit (
  2      NP NUMBER PRIMARY KEY,
  3      NomP VARCHAR2(255),
  4      Couleur VARCHAR2(255),
  5      Poids NUMBER
  6  );

Table crÚÚe.

SQL> CREATE TABLE Fournisseur (
  2      NF NUMBER PRIMARY KEY,
  3      NomF VARCHAR2(255),
  4      Statut VARCHAR2(255),
  5      Ville VARCHAR2(255)
  6  );

  SQL> CREATE TABLE Livraison (
  2      NP NUMBER,
  3      NU NUMBER,
  4      NF NUMBER,
  5      quantite NUMBER,
  6      FOREIGN KEY (NP) REFERENCES Produit(NP) ON DELETE CASCADE,
  7      FOREIGN KEY (NU) REFERENCES Usine(NU) ON DELETE CASCADE,
  8      FOREIGN KEY (NF) REFERENCES Fournisseur(NF) ON DELETE CASCADE,
  9      PRIMARY KEY (NP, NU, NF)
 10  );

 SQL> insert into Usine (NU, NomU, Ville) VALUES
  2  (1,'Usine 1','Casablanca'),
  3  (2,'Usine 2','Agadir'),
  4  (3,'Usine 3', Taroudant);

// insertion Produit

  INSERT INTO Produit (NP, NomP, Couleur, Poids) VALUES
(101, 'Produit 1', 'Rouge', 10);

INSERT INTO Produit (NP, NomP, Couleur, Poids) VALUES
(102, 'Produit 2', 'Bleu', 15);

INSERT INTO Produit (NP, NomP, Couleur, Poids) VALUES
(103, 'Produit 3', 'Vert', 8);

//insertion fournisseur

INSERT INTO Fournisseur (NF, NomF, Statut, Ville) VALUES
(201, 'Fournisseur 1', 'Actif', 'Agadir');

INSERT INTO Fournisseur (NF, NomF, Statut, Ville) VALUES
(202, 'Fournisseur 2', 'Inactif', 'Casablanca');

INSERT INTO Fournisseur (NF, NomF, Statut, Ville) VALUES
(203, 'Fournisseur 3', 'Actif', 'Taroudant');

// insertion Livraison

INSERT INTO Livraison (NP, NU, NF, quantite) VALUES
(101, 1, 201, 50);

INSERT INTO Livraison (NP, NU, NF, quantite) VALUES
(102, 2, 202, 30);

INSERT INTO Livraison (NP, NU, NF, quantite) VALUES
(103, 3, 203, 20);


 SELECT NU, NomU, Ville
 2  FROM Usine
 3  WHERE UPPER(NomU) LIKE '%PLAST%';


  select distinct NF
  2  from livraison
  3  where NU=1;


SQL> SELECT DISTINCT Fournisseur.NomF
  2  FROM Livraison
  3  JOIN Fournisseur ON Livraison.NF = Fournisseur.NF
  4  WHERE Livraison.NU = 1 AND Livraison.NP = 1;


SQL> select distinct NF
  2  from Livraison
  3  where NU=1 OR NU=2;


  SQL> select L.NU
  2  from Livraison L
  3  join Fournisseur on L.NF = Fournisseur.NF
  4  where NomF <>'Fournisseur 1';


SQL> select NU
  2  from Livraison
  3  where NF<>201;


  SQL> select NU
  2  from Livraison
  3  where NF=204;


  SQL> SELECT DISTINCT Livraison.NF
  2  FROM Livraison
  3  WHERE Livraison.NP IN (
  4      SELECT NP
  5      FROM Livraison
  6      WHERE NF = 1
  7  );


  SQL> select NU
  2  from Livraison
  3  where NF=203;


SQL> SELECT NU
  2  FROM Livraison L1
  3  WHERE L1.NF = 3
  4  AND NOT EXISTS (
  5      SELECT 1
  6      FROM Livraison L2
  7      WHERE L2.NU = L1.NU
  8        AND L2.NF <> 3
  9  );


  SQL> SELECT Fournisseur.NF, Fournisseur.NomF, COUNT(DISTINCT Livraison.NU) AS NombreUsines
  2  FROM Fournisseur
  3  LEFT JOIN Livraison ON Fournisseur.NF = Livraison.NF
  4  GROUP BY Fournisseur.NF, Fournisseur.NomF
  5  ORDER BY NombreUsines DESC;


  SQL> select F.NomF , count(L.NU) as numU
  2  from Fournisseur F
  3  join Livraison L on F.NF=L.NF
  4  having count(L.NU)>4
  5  GROUP BY F.NomF;


SQL> SELECT Produit.NomP
  2  FROM Produit
  3  JOIN Livraison ON Produit.NP = Livraison.NP
  4  JOIN Usine ON Livraison.NU = Usine.NU
  5  WHERE Usine.Ville = 'Agadir'
  6  GROUP BY Produit.NomP
  7  HAVING COUNT(DISTINCT Livraison.NU) > 4;

  SQL> SELECT
  2      INITCAP(SUBSTR(Produit.NomP, 1, 1)) AS InitialNomP,
  3      SUM(Livraison.quantite) AS QuantiteTotaleFournie
  4  FROM
  5      Produit
  6  JOIN
  7      Livraison ON Produit.NP = Livraison.NP
  8  GROUP BY
  9      Produit.NP, INITCAP(SUBSTR(Produit.NomP, 1, 1))
 10  ORDER BY
 11      QuantiteTotaleFournie DESC;


 SQL> SELECT F.NomF, COUNT(U.NU) AS nn, L.NF
  2  FROM Livraison L
  3  JOIN Fournisseur F ON L.NF = F.NF
  4  JOIN Usine U ON L.NU = U.NU
  5  GROUP BY F.NomF, L.NF
  6  HAVING COUNT(U.NU) = COUNT(L.NU)
  7  ORDER BY F.NomF;






