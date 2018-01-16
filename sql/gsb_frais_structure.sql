-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Lun 04 Juillet 2011 à 14:08
-- Version du serveur: 5.5.8
-- Version de PHP: 5.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `gsb`
--

-- --------------------------------------------------------

--
-- Structure de la table `FraisForfait`
--

CREATE TABLE IF NOT EXISTS `FraisForfait` (
  `id`      CHAR(3) NOT NULL,
  `libelle` CHAR(20)      DEFAULT NULL,
  `montant` DECIMAL(5, 2) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

-- --------------------------------------------------------

--
-- Structure de la table `Etat`
--

CREATE TABLE IF NOT EXISTS `Etat` (
  `id`      CHAR(2) NOT NULL,
  `libelle` VARCHAR(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB;

-- --------------------------------------------------------

--
-- Structure de la table `Visiteur`
--

CREATE TABLE IF NOT EXISTS `Visiteur` (
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
  ENGINE = InnoDB;

-- --------------------------------------------------------

--
-- Structure de la table `FicheFrais`
--

CREATE TABLE IF NOT EXISTS `FicheFrais` (
  `idVisiteur`      CHAR(4) NOT NULL,
  `mois`            CHAR(6) NOT NULL,
  `nbJustificatifs` INT(11)        DEFAULT NULL,
  `montantValide`   DECIMAL(10, 2) DEFAULT NULL,
  `dateModif`       DATE           DEFAULT NULL,
  `idEtat`          CHAR(2)        DEFAULT 'CR',
  PRIMARY KEY (`idVisiteur`, `mois`),
  FOREIGN KEY (`idEtat`) REFERENCES Etat (`id`),
  FOREIGN KEY (`idVisiteur`) REFERENCES Visiteur (`id`)
)
  ENGINE = InnoDB;

-- --------------------------------------------------------

--
-- Structure de la table `LigneFraisForfait`
--

CREATE TABLE IF NOT EXISTS `LigneFraisForfait` (
  `idVisiteur`     CHAR(4) NOT NULL,
  `mois`           CHAR(6) NOT NULL,
  `idFraisForfait` CHAR(3) NOT NULL,
  `quantite`       INT(11) DEFAULT NULL,
  PRIMARY KEY (`idVisiteur`, `mois`, `idFraisForfait`),
  FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES FicheFrais (`idVisiteur`, `mois`),
  FOREIGN KEY (`idFraisForfait`) REFERENCES FraisForfait (`id`)
)
  ENGINE = InnoDB;

-- --------------------------------------------------------

--
-- Structure de la table `LigneFraisHorsForfait`
--

CREATE TABLE IF NOT EXISTS `LigneFraisHorsForfait` (
  `id`         INT(11) NOT NULL AUTO_INCREMENT,
  `idVisiteur` CHAR(4) NOT NULL,
  `mois`       CHAR(6) NOT NULL,
  `libelle`    VARCHAR(100)     DEFAULT NULL,
  `date`       DATE             DEFAULT NULL,
  `montant`    DECIMAL(10, 2)   DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES FicheFrais (`idVisiteur`, `mois`)
)
  ENGINE = InnoDB;
