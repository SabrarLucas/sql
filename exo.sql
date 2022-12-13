-- EXO Hotel
-- 1
SELECT hot_nom, hot_ville
FROM hotel

-- 2
SELECT cli_nom, cli_prenom, cli_adresse
FROM client
WHERE cli_nom = 'White'

-- 3
SELECT sta_nom, sta_altitude
FROM station
WHERE sta_altitude < 1000

-- 4
SELECT cha_numero, cha_capacite
FROM chambre
WHERE cha_capacite > 1

-- 5
SELECT cli_nom, cli_ville
FROM client
WHERE cli_ville != 'Londres'

-- 6
SELECT hot_nom, hot_ville, hot_categorie
FROM hotel
WHERE hot_ville = 'Bretou' AND hot_categorie > 3

-- 7
SELECT sta_nom, hot_nom, hot_categorie, hot_ville
FROM hotel
JOIN station ON station.sta_id = hotel.hot_sta_id

-- 8
SELECT hot_nom, hot_categorie, hot_ville, cha_numero
FROM hotel
JOIN chambre ON chambre.cha_hot_id = hotel.hot_id

-- 9
SELECT hot_nom, hot_categorie, hot_ville, cha_numero, cha_capacite 
FROM hotel
JOIN chambre ON chambre.cha_hot_id = hotel.hot_id
WHERE hot_ville = 'Bretou' and cha_capacite > 1

-- 10
SELECT cli_nom, hot_nom, res_date
FROM client
JOIN reservation ON reservation.res_cli_id = client.cli_id
JOIN chambre ON chambre.cha_id = reservation.res_cha_id
JOIN hotel ON hotel.hot_id = chambre.cha_hot_id

-- 11
SELECT sta_nom, hot_nom, cha_numero, cha_capacite
FROM chambre
JOIN hotel ON hotel.hot_id = chambre.cha_hot_id
JOIN station ON station.sta_id = hotel.hot_sta_id

-- 12
SELECT cli_nom, hot_nom, res_date_debut, DATEDIFF(res_date_fin, res_date_debut) AS duree_sejour
FROM client
JOIN reservation ON reservation.res_cli_id = client.cli_id
JOIN chambre ON chambre.cha_id = reservation.res_cha_id
JOIN hotel ON hotel.hot_id = chambre.cha_hot_id

-- 13
SELECT sta_nom, COUNT(hotel.hot_sta_id) AS 'Nb hotel' 
FROM station
JOIN hotel ON hotel.hot_sta_id  = station.sta_id 
GROUP BY sta_nom

-- 14
SELECT sta_nom, COUNT(chambre.cha_id) AS 'Nb chambre'
FROM station
JOIN hotel ON hotel.hot_sta_id = station.sta_id
JOIN chambre ON chambre.cha_hot_id = hotel.hot_id
GROUP BY sta_nom

-- 15
SELECT sta_nom, COUNT(chambre.cha_id) AS 'Nb chambre'
FROM station
JOIN hotel ON hotel.hot_sta_id = station.sta_id
JOIN chambre ON chambre.cha_hot_id = hotel.hot_id
WHERE cha_capacite > 1
GROUP BY sta_nom

-- 16
SELECT hot_nom, COUNT(reservation.res_cli_id)
FROM reservation
JOIN client ON client.cli_id = reservation.res_cli_id
JOIN chambre ON chambre.cha_id = reservation.res_cha_id
JOIN hotel ON hotel.hot_id = chambre.cha_id
WHERE cli_nom = 'Squire'
GROUP BY hot_nom

-- 17
SELECT sta_nom, AVG(DATEDIFF(res_date_fin, res_date_debut)) AS 'moy res'
FROM station
JOIN hotel ON hotel.hot_sta_id = station.sta_id
JOIN chambre ON chambre.cha_hot_id = hotel.hot_id
JOIN reservation ON reservation.res_cha_id = chambre.cha_id
GROUP BY sta_nom


--Papyrus
-- 1
SELECT numcom
FROM entcom
WHERE numfou = 9120

-- 2
SELECT entcom.numfou
FROM entcom
GROUP BY numfou

-- 3
SELECT COUNT(entcom.numcom) AS 'Nb commande', COUNT(DISTINCT entcom.numfou) AS 'Nb fournisseur' 
FROM entcom

-- 4
SELECT codart, libart, stkphy, stkale, qteann 
FROM produit
WHERE stkphy <= stkale AND qteann < 1000

-- 5
SELECT posfou, nomfou
FROM fournis
WHERE LEFT (posfou, 2) = '75' OR LEFT (posfou, 2) = '78' OR LEFT (posfou, 2) = '92' OR LEFT (posfou, 2) = '77'
ORDER BY posfou DESC, nomfou ASC

-- 6
SELECT numcom
FROM entcom
WHERE MONTH(datcom) = '03' OR MONTH(datcom) = '04'

-- 7
SELECT numcom, datcom
FROM entcom
WHERE obscom != ''

-- 8
SELECT numcom, SUM(qtecde*priuni) AS 'Total commande'
FROM ligcom
GROUP BY numcom
ORDER BY SUM(qtecde*priuni) DESC 

-- 9
SELECT numcom, SUM(qtecde*priuni) AS 'Total commande'
FROM ligcom	
WHERE qtecde < 1000
GROUP BY numcom
HAVING SUM(qtecde*priuni) > 10000

-- 10
SELECT numcom, nomfou, datcom
FROM entcom
JOIN fournis ON fournis.numfou = entcom.numfou

-- 11
SELECT entcom.numcom, nomfou, libart, SUM(qtecde*priuni) AS 'Total commande'
FROM entcom
JOIN fournis ON fournis.numfou = entcom.numfou
JOIN ligcom ON ligcom.numcom = entcom.numcom
JOIN produit ON produit.codart = ligcom.codart
WHERE obscom LIKE '%urgent%'
GROUP BY entcom.numcom

-- 12/1
SELECT nomfou, COUNT(codart) AS 'code art'
FROM fournis
JOIN vente ON vente.numfou = fournis.numfou
GROUP BY fournis.numfou

-- 12/2


-- 13/1
SELECT numcom, datcom
FROM entcom
WHERE numcom = '70210'
GROUP BY numfou

-- 13/2


-- 14
SELECT libart, prix1
FROM vente
JOIN produit ON produit.codart = vente.codart
WHERE libart LIKE 'R%'

-- 15
SELECT produit.codart, fournis.numfou, nomfou 
FROM fournis
JOIN vente ON vente.numfou = fournis.numfou
JOIN produit ON produit.codart = vente.codart
WHERE  stkphy  <= (stkale * 150 / 100)
ORDER BY produit.codart, fournis.numfou

-- 16
SELECT produit.codart, fournis.numfou, nomfou 
FROM fournis
JOIN vente ON vente.numfou = fournis.numfou
JOIN produit ON produit.codart = vente.codart
WHERE  stkphy  <= (stkale * 150 / 100) and vente.delliv < 31
ORDER BY produit.codart, fournis.numfou

-- 17
SELECT fournis.numfou, vente.codart, nomfou, sum(stkphy) AS 'total stocks'
FROM fournis
JOIN vente ON vente.numfou = fournis.numfou
JOIN produit ON produit.codart = vente.codart
WHERE vente.delliv  < 31 and  stkphy  <= (stkale * 150 / 100)
GROUP BY fournis.numfou, vente.codart, nomfou
ORDER BY sum(stkphy) desc

-- 18
SELECT ligcom.codart, SUM(qtecde)
FROM ligcom
JOIN produit ON produit.codart = ligcom.codart
WHERE qtecde >= (qteann * 90 / 100)
GROUP BY codart

-- 19
SELECT fournis.numfou, nomfou, SUM(qtecde * priuni * 1.2)   
FROM fournis
JOIN entcom ON entcom.numfou = fournis.numfou
JOIN ligcom ON ligcom.numcom = entcom.numcom
WHERE YEAR (datcom) = '2018'
GROUP BY fournis.numfou, nomfou


-- Papyrus II
-- 1
UPDATE vente
SET prix1 = prix1 * 1.04,
    prix2 = prix2 *1.02
WHERE numfou = 9180

-- 2
UPDATE vente
SET prix2 = prix1
WHERE prix2 = 0

-- 3
UPDATE entcom
SET obscom = '*****'
JOIN fournis ON fournis.numfou = entcom.numfou
WHERE satisf < 5

-- 4
DELETE FROM produit
WHERE codart = 'I110'