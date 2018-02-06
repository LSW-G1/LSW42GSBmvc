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
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `Visiteur` (`id`, `nom`, `prenom`, `login`, `mdp`, `adresse`, `cp`, `ville`, `dateEmbauche`) VALUES
  ('a131', 'Villechalane', 'Louis', 'lvillachane', 'jux7g', '8 rue des Charmes', '46000', 'Cahors', '2005-12-21'),
  ('a17', 'Andre', 'David', 'dandre', 'oppg5', '1 rue Petit', '46200', 'Lalbenque', '1998-11-23'),
  ('a55', 'Bedos', 'Christian', 'cbedos', 'gmhxd', '1 rue Peranud', '46250', 'Montcuq', '1995-01-12'),
  ('a93', 'Tusseau', 'Louis', 'ltusseau', 'ktp3s', '22 rue des Ternes', '46123', 'Gramat', '2000-05-01'),
  ('b13', 'Bentot', 'Pascal', 'pbentot', 'doyw1', '11 allée des Cerises', '46512', 'Bessines', '1992-07-09'),
  ('b16', 'Bioret', 'Luc', 'lbioret', 'hrjfs', '1 Avenue gambetta', '46000', 'Cahors', '1998-05-11'),
  ('b19', 'Bunisset', 'Francis', 'fbunisset', '4vbnd', '10 rue des Perles', '93100', 'Montreuil', '1987-10-21'),
  ('b25', 'Bunisset', 'Denise', 'dbunisset', 's1y1r', '23 rue Manin', '75019', 'paris', '2010-12-05'),
  ('b28', 'Cacheux', 'Bernard', 'bcacheux', 'uf7r3', '114 rue Blanche', '75017', 'Paris', '2009-11-12'),
  ('b34', 'Cadic', 'Eric', 'ecadic', '6u8dc', '123 avenue de la République', '75011', 'Paris', '2008-09-23'),
  ('b4', 'Charoze', 'Catherine', 'ccharoze', 'u817o', '100 rue Petit', '75019', 'Paris', '2005-11-12'),
  ('b50', 'Clepkens', 'Christophe', 'cclepkens', 'bw1us', '12 allée des Anges', '93230', 'Romainville', '2003-08-11'),
  ('b59', 'Cottin', 'Vincenne', 'vcottin', '2hoh9', '36 rue Des Roches', '93100', 'Monteuil', '2001-11-18'),
  ('c14', 'Daburon', 'François', 'fdaburon', '7oqpv', '13 rue de Chanzy', '94000', 'Créteil', '2002-02-11'),
  ('c3', 'De', 'Philippe', 'pde', 'gk9kx', '13 rue Barthes', '94000', 'Créteil', '2010-12-14'),
  ('c54', 'Debelle', 'Michel', 'mdebelle', 'od5rt', '181 avenue Barbusse', '93210', 'Rosny', '2006-11-23'),
  ('d13', 'Debelle', 'Jeanne', 'jdebelle', 'nvwqq', '134 allée des Joncs', '44000', 'Nantes', '2000-05-11'),
  ('d51', 'Debroise', 'Michel', 'mdebroise', 'sghkb', '2 Bld Jourdain', '44000', 'Nantes', '2001-04-17'),
  ('e22', 'Desmarquest', 'Nathalie', 'ndesmarquest', 'f1fob', '14 Place d Arc', '45000', 'Orléans', '2005-11-12'),
  ('e24', 'Desnost', 'Pierre', 'pdesnost', '4k2o5', '16 avenue des Cèdres', '23200', 'Guéret', '2001-02-05'),
  ('e39', 'Dudouit', 'Frédéric', 'fdudouit', '44im8', '18 rue de l église', '23120', 'GrandBourg', '2000-08-01'),
  ('e49', 'Duncombe', 'Claude', 'cduncombe', 'qf77j', '19 rue de la tour', '23100', 'La souteraine', '1987-10-10'),
  ('e5', 'Enault-Pascreau', 'Céline', 'cenault', 'y2qdu', '25 place de la gare', '23200', 'Gueret', '1995-09-01'),
  ('e52', 'Eynde', 'Valérie', 'veynde', 'i7sn3', '3 Grand Place', '13015', 'Marseille', '1999-11-01'),
  ('f21', 'Finck', 'Jacques', 'jfinck', 'mpb3t', '10 avenue du Prado', '13002', 'Marseille', '2001-11-10'),
  ('f39', 'Frémont', 'Fernande', 'ffremont', 'xs5tq', '4 route de la mer', '13012', 'Allauh', '1998-10-01'),
  ('f4', 'Gest', 'Alain', 'agest', 'dywvt', '30 avenue de la mer', '13025', 'Berre', '1985-11-01'),
  ('dev', 'Developper', '', 'root', 'root', '', '', '', '2018-01-01');


DROP TABLE IF EXISTS `Client`;
CREATE TABLE `Client` (
  `idClient` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `dateVisite` date NOT NULL,
  `idTypeClient` int(11) NOT NULL,
  PRIMARY KEY (`idClient`),
  KEY `idTypeClient` (`idTypeClient`),
  CONSTRAINT `Client_ibfk_1` FOREIGN KEY (`idTypeClient`) REFERENCES `TypeClient` (`idTypeClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `CompteRendu`;
CREATE TABLE `CompteRendu` (
  `numeroOrdre` int(11) NOT NULL,
  `idVisiteur` char(4) NOT NULL,
  `contenu` text NOT NULL,
  `note` int(11) NOT NULL,
  `dateVisite` date NOT NULL,
  `idClient` int(11) NOT NULL,
  PRIMARY KEY (`numeroOrdre`,`idVisiteur`),
  KEY `idVisiteur` (`idVisiteur`),
  KEY `idClient` (`idClient`),
  CONSTRAINT `CompteRendu_ibfk_1` FOREIGN KEY (`idVisiteur`) REFERENCES `Visiteur` (`id`),
  CONSTRAINT `CompteRendu_ibfk_2` FOREIGN KEY (`idClient`) REFERENCES `Client` (`idClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `TypeClient`;
CREATE TABLE `TypeClient` (
  `idTypeClient` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) NOT NULL,
  PRIMARY KEY (`idTypeClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 2018-01-18 19:51:22
