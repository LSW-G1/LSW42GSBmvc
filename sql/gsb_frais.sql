-- Adminer 4.3.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `gsb_frais`;
CREATE DATABASE `gsb_frais` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `gsb_frais`;

DROP TABLE IF EXISTS `Etat`;
CREATE TABLE `Etat` (
  `id`      CHAR(2) NOT NULL,
  `libelle` VARCHAR(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `Etat` (`id`, `libelle`) VALUES
  ('CL', 'Saisie clôturée'),
  ('CR', 'Fiche créée, saisie en cours'),
  ('RB', 'Remboursée'),
  ('VA', 'Validée et mise en paiement');

DROP TABLE IF EXISTS `FicheFrais`;
CREATE TABLE `FicheFrais` (
  `idVisiteur`      CHAR(4) NOT NULL,
  `mois`            CHAR(6) NOT NULL,
  `nbJustificatifs` INT(11)        DEFAULT NULL,
  `montantValide`   DECIMAL(10, 2) DEFAULT NULL,
  `dateModif`       DATE           DEFAULT NULL,
  `idEtat`          CHAR(2)        DEFAULT 'CR',
  PRIMARY KEY (`idVisiteur`, `mois`),
  KEY `idEtat` (`idEtat`),
  CONSTRAINT `FicheFrais_ibfk_1` FOREIGN KEY (`idEtat`) REFERENCES `Etat` (`id`),
  CONSTRAINT `FicheFrais_ibfk_2` FOREIGN KEY (`idVisiteur`) REFERENCES `Visiteur` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `FicheFrais` (`idVisiteur`, `mois`, `nbJustificatifs`, `montantValide`, `dateModif`, `idEtat`) VALUES
  ('a42', '01', 0, 0.00, '2018-01-14', 'CR');

DROP TABLE IF EXISTS `FraisForfait`;
CREATE TABLE `FraisForfait` (
  `id`      CHAR(3) NOT NULL,
  `libelle` CHAR(20)      DEFAULT NULL,
  `montant` DECIMAL(5, 2) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `FraisForfait` (`id`, `libelle`, `montant`) VALUES
  ('ETP', 'Forfait Etape', 110.00),
  ('KM', 'Frais Kilométrique', 0.62),
  ('NUI', 'Nuitée Hôtel', 80.00),
  ('REP', 'Repas Restaurant', 25.00);

DROP TABLE IF EXISTS `LigneFraisForfait`;
CREATE TABLE `LigneFraisForfait` (
  `idVisiteur`     CHAR(4) NOT NULL,
  `mois`           CHAR(6) NOT NULL,
  `idFraisForfait` CHAR(3) NOT NULL,
  `quantite`       INT(11) DEFAULT NULL,
  PRIMARY KEY (`idVisiteur`, `mois`, `idFraisForfait`),
  KEY `idFraisForfait` (`idFraisForfait`),
  CONSTRAINT `LigneFraisForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`),
  CONSTRAINT `LigneFraisForfait_ibfk_2` FOREIGN KEY (`idFraisForfait`) REFERENCES `FraisForfait` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `LigneFraisForfait` (`idVisiteur`, `mois`, `idFraisForfait`, `quantite`) VALUES
  ('a42', '01', 'ETP', 1),
  ('a42', '01', 'KM', 5),
  ('a42', '01', 'NUI', 2),
  ('a42', '01', 'REP', 1);

DROP TABLE IF EXISTS `LigneFraisHorsForfait`;
CREATE TABLE `LigneFraisHorsForfait` (
  `id`         INT(11) NOT NULL AUTO_INCREMENT,
  `idVisiteur` CHAR(4) NOT NULL,
  `mois`       CHAR(6) NOT NULL,
  `libelle`    VARCHAR(100)     DEFAULT NULL,
  `date`       DATE             DEFAULT NULL,
  `montant`    DECIMAL(10, 2)   DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idVisiteur` (`idVisiteur`, `mois`),
  CONSTRAINT `LigneFraisHorsForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `LigneFraisHorsForfait` (`id`, `idVisiteur`, `mois`, `libelle`, `date`, `montant`) VALUES
  (1, 'a42', '01', 'Restaurant non partenaire', '2017-12-01', 15.00);

DROP TABLE IF EXISTS `Tablette`;
CREATE TABLE `Tablette` (
  `id`            INT(11)        NOT NULL AUTO_INCREMENT,
  `libelle`       VARCHAR(255)   NOT NULL,
  `type`          VARCHAR(255)   NOT NULL,
  `marque`        VARCHAR(255)   NOT NULL,
  `memoireVive`   INT(11)        NOT NULL,
  `memoireDisque` INT(11)        NOT NULL,
  `prix`          DECIMAL(10, 0) NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `Tablette` (`id`, `libelle`, `type`, `marque`, `memoireVive`, `memoireDisque`, `prix`) VALUES
  (1, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (2, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (3, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (4, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (5, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (6, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (7, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (8, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (9, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (10, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (11, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (12, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (13, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (14, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (15, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (16, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (17, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (18, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (19, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (20, 'Apple IPad Pro 64 Go', 'iOS', 'Apple', 3, 64, 739.00),
  (21, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (22, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (23, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (24, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (25, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (26, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (27, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (28, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (29, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (30, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (31, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (32, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (33, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (34, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00),
  (35, 'Google Nexus 9 32 Go', 'Android', 'Google', 3, 32, 390.00);

DROP TABLE IF EXISTS `Visiteur`;
CREATE TABLE `Visiteur` (
  `id`           CHAR(4) NOT NULL,
  `nom`          CHAR(30) DEFAULT NULL,
  `prenom`       CHAR(30) DEFAULT NULL,
  `login`        CHAR(20) DEFAULT NULL,
  `mdp`          CHAR(20) DEFAULT NULL,
  `adresse`      CHAR(30) DEFAULT NULL,
  `cp`           CHAR(5)  DEFAULT NULL,
  `ville`        CHAR(30) DEFAULT NULL,
  `dateEmbauche` DATE     DEFAULT NULL,
  `Tablette`     INT(11)  DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Tablette` (`Tablette`),
  CONSTRAINT `Visiteur_ibfk_1` FOREIGN KEY (`Tablette`) REFERENCES `Tablette` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `Visiteur` (`id`, `nom`, `prenom`, `login`, `mdp`, `adresse`, `cp`, `ville`, `dateEmbauche`, `Tablette`)
VALUES
  ('a131', 'Villechalane', 'Louis', 'lvillachane', 'jux7g', '8 rue des Charmes', '46000', 'Cahors', '2005-12-21', 3),
  ('a17', 'Andre', 'David', 'dandre', 'oppg5', '1 rue Petit', '46200', 'Lalbenque', '1998-11-23', 2),
  ('a55', 'Bedos', 'Christian', 'cbedos', 'gmhxd', '1 rue Peranud', '46250', 'Montcuq', '1995-01-12', 4),
  ('a93', 'Tusseau', 'Louis', 'ltusseau', 'ktp3s', '22 rue des Ternes', '46123', 'Gramat', '2000-05-01', 5),
  ('b13', 'Bentot', 'Pascal', 'pbentot', 'doyw1', '11 allée des Cerises', '46512', 'Bessines', '1992-07-09', 6),
  ('b16', 'Bioret', 'Luc', 'lbioret', 'hrjfs', '1 Avenue gambetta', '46000', 'Cahors', '1998-05-11', 7),
  ('b19', 'Bunisset', 'Francis', 'fbunisset', '4vbnd', '10 rue des Perles', '93100', 'Montreuil', '1987-10-21', 8),
  ('b25', 'Bunisset', 'Denise', 'dbunisset', 's1y1r', '23 rue Manin', '75019', 'paris', '2010-12-05', 9),
  ('b28', 'Cacheux', 'Bernard', 'bcacheux', 'uf7r3', '114 rue Blanche', '75017', 'Paris', '2009-11-12', 10),
  ('b34', 'Cadic', 'Eric', 'ecadic', '6u8dc', '123 avenue de la République', '75011', 'Paris', '2008-09-23', 11),
  ('b4', 'Charoze', 'Catherine', 'ccharoze', 'u817o', '100 rue Petit', '75019', 'Paris', '2005-11-12', 12),
  ('b50', 'Clepkens', 'Christophe', 'cclepkens', 'bw1us', '12 allée des Anges', '93230', 'Romainville', '2003-08-11',
   13),
  ('b59', 'Cottin', 'Vincenne', 'vcottin', '2hoh9', '36 rue Des Roches', '93100', 'Monteuil', '2001-11-18', 14),
  ('c14', 'Daburon', 'François', 'fdaburon', '7oqpv', '13 rue de Chanzy', '9399.990', 'Créteil', '2002-02-11', 15),
  ('c3', 'De', 'Philippe', 'pde', 'gk9kx', '13 rue Barthes', '9399.990', 'Créteil', '2010-12-14', 16),
  ('dev', 'Developper', '', 'root', 'root', '', '', '', '2018-01-01', 1);

-- 2018-01-18 20:01:31