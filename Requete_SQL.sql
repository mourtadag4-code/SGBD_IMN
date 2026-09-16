#a_Le nombre de sessions de cours organisés en 2021 ayant un prix supérieur à 150 000 francs

SELECT COUNT(*) AS nb_sessions_cheres_2021
FROM SESSION
WHERE YEAR(DATE_DEBUT) = 2021
  AND PRIX > 150000;

#b_Les animateurs qui ont animé plus de 200 heures de sessions de cours 
SELECT a.NOANI, a.NOMA, a.ADRA, SUM(an.NBH) AS total_heures
FROM ANIMATEUR a
JOIN ANIMER an ON a.NOANI = an.NOANI
GROUP BY a.NOANI, a.NOMA, a.ADRA
HAVING SUM(an.NBH) > 200
ORDER BY total_heures DESC;

#c_Les trois sessions les plus chères 

SELECT s.NOSES,c.LIBELLE , s.PRIX
FROM SESSION s 
JOIN COURS c ON s.NOCOURS=c.NOCOURS
ORDER BY PRIX DESC 
LIMIT 3;


