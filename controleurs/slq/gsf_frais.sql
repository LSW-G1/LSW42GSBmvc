-- Adminer 4.3.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE DATABASE `gsb_frais` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `gsb_frais`;

DROP TABLE IF EXISTS `Etat`;
CREATE TABLE `Etat` (
  `id` char(2) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Etat` (`id`, `libelle`) VALUES
  ('CL',	'Saisie clôturée'),
  ('CR',	'Fiche créée, saisie en cours'),
  ('RB',	'Remboursée'),
  ('VA',	'Validée et mise en paiement');

DROP TABLE IF EXISTS `FicheFrais`;
CREATE TABLE `FicheFrais` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `nbJustificatifs` int(11) DEFAULT NULL,
  `montantValide` decimal(10,2) DEFAULT NULL,
  `dateModif` date DEFAULT NULL,
  `idEtat` char(2) DEFAULT 'CR',
  PRIMARY KEY (`idVisiteur`,`mois`),
  KEY `idEtat` (`idEtat`),
  CONSTRAINT `FicheFrais_ibfk_1` FOREIGN KEY (`idEtat`) REFERENCES `Etat` (`id`),
  CONSTRAINT `FicheFrais_ibfk_2` FOREIGN KEY (`idVisiteur`) REFERENCES `Visiteur` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `FicheFrais` (`idVisiteur`, `mois`, `nbJustificatifs`, `montantValide`, `dateModif`, `idEtat`) VALUES
  ('a42',	'01',	0,	0.00,	'2018-01-14',	'CR');

DROP TABLE IF EXISTS `FraisForfait`;
CREATE TABLE `FraisForfait` (
  `id` char(3) NOT NULL,
  `libelle` char(20) DEFAULT NULL,
  `montant` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `FraisForfait` (`id`, `libelle`, `montant`) VALUES
  ('ETP',	'Forfait Etape',	110.00),
  ('KM',	'Frais Kilométrique',	0.62),
  ('NUI',	'Nuitée Hôtel',	80.00),
  ('REP',	'Repas Restaurant',	25.00);

DROP TABLE IF EXISTS `LigneFraisForfait`;
CREATE TABLE `LigneFraisForfait` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `idFraisForfait` char(3) NOT NULL,
  `quantite` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVisiteur`,`mois`,`idFraisForfait`),
  KEY `idFraisForfait` (`idFraisForfait`),
  CONSTRAINT `LigneFraisForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`),
  CONSTRAINT `LigneFraisForfait_ibfk_2` FOREIGN KEY (`idFraisForfait`) REFERENCES `FraisForfait` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `LigneFraisForfait` (`idVisiteur`, `mois`, `idFraisForfait`, `quantite`) VALUES
  ('a42',	'01',	'ETP',	1),
  ('a42',	'01',	'KM',	5),
  ('a42',	'01',	'NUI',	2),
  ('a42',	'01',	'REP',	1);

DROP TABLE IF EXISTS `LigneFraisHorsForfait`;
CREATE TABLE `LigneFraisHorsForfait` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `libelle` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `montant` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idVisiteur` (`idVisiteur`,`mois`),
  CONSTRAINT `LigneFraisHorsForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

INSERT INTO `LigneFraisHorsForfait` (`id`, `idVisiteur`, `mois`, `libelle`, `date`, `montant`) VALUES
  (1,	'a42',	'01',	'Restaurant non partenaire',	'2017-12-01',	15.00);

DROP TABLE IF EXISTS `Tablette`;
CREATE TABLE `Tablette` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `marque` varchar(255) NOT NULL,
  `memoireVive` int(11) NOT NULL,
  `memoireDisque` int(11) NOT NULL,
  `prix` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;

INSERT INTO `Tablette` (`id`, `libelle`, `type`, `marque`, `memoireVive`, `memoireDisque`, `prix`) VALUES
  (1,	'Archos Neon',	'Android',	'Archos',	2,	32,	90),
  (2,	'Apple IPad 7\"',	'iOS',	'Apple',	2,	32,	300),
  (3,	'Archos Neon',	'Android',	'Archos',	2,	32,	90),
  (4,	'Archos Tablette',	'Android',	'Archos',	1,	16,	50),
  (5,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (6,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (7,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (8,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (9,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (10,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (11,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (12,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (13,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (14,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (15,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (16,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (17,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (18,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (19,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (20,	'Apple Tablette 10.1',	'iOS',	'Apple',	3,	32,	400),
  (21,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (22,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (23,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (24,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (25,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (26,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (27,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (28,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (29,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (30,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (31,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (32,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (33,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (34,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300),
  (35,	'Samsung Galaxy Tab 3',	'Android',	'Samsung',	3,	32,	300);

DROP TABLE IF EXISTS `Visiteur`;
CREATE TABLE `Visiteur` (
  `id` char(4) NOT NULL,
  `nom` char(30) DEFAULT NULL,
  `prenom` char(30) DEFAULT NULL,
  `login` char(20) DEFAULT NULL,
  `mdp` char(20) DEFAULT NULL,
  `adresse` char(30) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `ville` char(30) DEFAULT NULL,
  `dateEmbauche` date DEFAULT NULL,
  `Tablette` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Tablette` (`Tablette`),
  CONSTRAINT `Visiteur_ibfk_1` FOREIGN KEY (`Tablette`) REFERENCES `Tablette` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Visiteur` (`id`, `nom`, `prenom`, `login`, `mdp`, `adresse`, `cp`, `ville`, `dateEmbauche`, `Tablette`) VALUES
  ('a131',	'Villechalane',	'Louis',	'lvillachane',	'jux7g',	'8 rue des Charmes',	'46000',	'Cahors',	'2005-12-21',	3),
  ('a17',	'Andre',	'David',	'dandre',	'oppg5',	'1 rue Petit',	'46200',	'Lalbenque',	'1998-11-23',	2),
  ('a42',	'Tartiere',	'Kevin',	'username',	'password',	'24 Rue Léon Blum',	'42000',	'Saint-Etienne',	'2018-01-01',	1),
  ('a55',	'Bedos',	'Christian',	'cbedos',	'gmhxd',	'1 rue Peranud',	'46250',	'Montcuq',	'1995-01-12',	4),
  ('a93',	'Tusseau',	'Louis',	'ltusseau',	'ktp3s',	'22 rue des Ternes',	'46123',	'Gramat',	'2000-05-01',	5),
  ('b13',	'Bentot',	'Pascal',	'pbentot',	'doyw1',	'11 allée des Cerises',	'46512',	'Bessines',	'1992-07-09',	6),
  ('b16',	'Bioret',	'Luc',	'lbioret',	'hrjfs',	'1 Avenue gambetta',	'46000',	'Cahors',	'1998-05-11',	7),
  ('b19',	'Bunisset',	'Francis',	'fbunisset',	'4vbnd',	'10 rue des Perles',	'93100',	'Montreuil',	'1987-10-21',	8),
  ('b25',	'Bunisset',	'Denise',	'dbunisset',	's1y1r',	'23 rue Manin',	'75019',	'paris',	'2010-12-05',	9),
  ('b28',	'Cacheux',	'Bernard',	'bcacheux',	'uf7r3',	'114 rue Blanche',	'75017',	'Paris',	'2009-11-12',	10),
  ('b34',	'Cadic',	'Eric',	'ecadic',	'6u8dc',	'123 avenue de la République',	'75011',	'Paris',	'2008-09-23',	11),
  ('b4',	'Charoze',	'Catherine',	'ccharoze',	'u817o',	'100 rue Petit',	'75019',	'Paris',	'2005-11-12',	12),
  ('b50',	'Clepkens',	'Christophe',	'cclepkens',	'bw1us',	'12 allée des Anges',	'93230',	'Romainville',	'2003-08-11',	13),
  ('b59',	'Cottin',	'Vincenne',	'vcottin',	'2hoh9',	'36 rue Des Roches',	'93100',	'Monteuil',	'2001-11-18',	14),
  ('c14',	'Daburon',	'François',	'fdaburon',	'7oqpv',	'13 rue de Chanzy',	'94000',	'Créteil',	'2002-02-11',	15),
  ('c3',	'De',	'Philippe',	'pde',	'gk9kx',	'13 rue Barthes',	'94000',	'Créteil',	'2010-12-14',	16);

-- 2018-01-16 19:06:16
