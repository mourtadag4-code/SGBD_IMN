# 🗄️ Gestion des formations d'un institut privé

Conception et implémentation d'une base de données relationnelle pour la gestion complète des formations d'un institut privé : cours, animateurs, participants et sessions.

Projet académique réalisé dans le cadre du cours de **Base de Données** — Master Ingénierie Mathématique et Numérique (FST/UCAD), sous la supervision de **M. Martial Kouleye**.

## 📌 Contexte

Un institut privé propose des formations organisées en sessions, animées par des intervenants et suivies par des participants (individuels ou envoyés par une entreprise). L'objectif est de modéliser ce système d'information de bout en bout : de l'analyse du besoin métier au schéma relationnel normalisé, jusqu'aux requêtes d'exploitation.

## 🗂️ Modélisation

- **Modèle Conceptuel de Données (MCD)** : 5 entités (Étudiant/Participant, Classe, Cours, Animateur, Session) reliées par des associations porteuses de cardinalités
- **Modèle Logique de Données (MLD)** : traduction en 6 tables relationnelles normalisées

### Structure des tables

| Table | Champs | Rôle |
|---|---|---|
| `ANIMATEUR` | NOANI, NOMA, ADRA | Intervenants formateurs |
| `COURS` | NOCOURS, LIBELLE, DUREE, TYPE | Catalogue des cours proposés |
| `SESSION` | NOSES, DATE_DEBUT, PRIX, NOCOURS, NOANI | Instances programmées d'un cours |
| `PARTICIPANT` | NOPAR, NOMP, ADRP, NOMEN, ADREN | Personnes suivant les formations (à titre individuel ou via une entreprise) |
| `ANIMER` | NOANI, NOSES, NBH | Association animateur ↔ session, avec nombre d'heures |
| `PARTICIPER` | NOSES, NOPAR | Association session ↔ participant (inscriptions) |

*(Convention Merise : NO = Numéro/identifiant, NOMA = Nom Animateur, ADRA = Adresse Animateur, NOMP = Nom Participant, ADRP = Adresse Participant, NOMEN = Nom Entreprise, ADREN = Adresse Entreprise, NBH = Nombre d'Heures)*

**Jeu de données** : 100 animateurs, 100 cours, 100 sessions (2020–2025), 100 participants, avec relations d'animation et d'inscription peuplées de façon cohérente.

## 📊 Exemples de requêtes d'analyse

```sql
-- Nombre de sessions coûteuses en 2021 (prix > 150 000 FCFA)
SELECT COUNT(*) AS nb_sessions_cheres_2021
FROM SESSION
WHERE YEAR(DATE_DEBUT) = 2021
  AND PRIX > 150000;

-- Animateurs ayant animé plus de 200 heures de sessions
SELECT a.NOANI, a.NOMA, a.ADRA, SUM(an.NBH) AS total_heures
FROM ANIMATEUR a
JOIN ANIMER an ON a.NOANI = an.NOANI
GROUP BY a.NOANI, a.NOMA, a.ADRA
HAVING SUM(an.NBH) > 200
ORDER BY total_heures DESC;

-- Les trois sessions les plus chères, avec leur intitulé de cours
SELECT s.NOSES, c.LIBELLE, s.PRIX
FROM SESSION s
JOIN COURS c ON s.NOCOURS = c.NOCOURS
ORDER BY PRIX DESC
LIMIT 3;
```

## 📁 Contenu du repo

```
SGBD_IMN/
├── Base_de_donne(Institut_prive).sql   # Script complet : création des tables + insertion des données
├── Requete_SQL.sql                     # Requêtes d'analyse (agrégations, jointures, tri)
├── Modele_Conceptuel.loo                # Fichier source du MCD (LibreOffice Draw)
└── Nom_des_membres.docx
```

## 🚀 Reproduire

```bash
mysql -u root -p < "Base_de_donne(Institut_prive).sql"
mysql -u root -p institut_prive < Requete_SQL.sql
```

## 💡 Ce que ce projet démontre

Une maîtrise de la modélisation relationnelle de bout en bout — de l'analyse du besoin métier à sa traduction en schéma normalisé, puis en requêtes d'exploitation (agrégations, jointures multi-tables, tri). Une compétence transversale à tout poste manipulant des données structurées.

## 🛠️ Stack technique

`SQL` · `MySQL` · `Modélisation Merise (MCD/MLD)`

## 👤 Auteur

Mouhamadoul Mourtadha Gueye — [LinkedIn](https://www.linkedin.com/in/mouhamadoul-mourtadha-gueye/) · [GitHub](https://github.com/mourtadag4-code)
