-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  mer. 26 jan. 2022 à 10:50
-- Version du serveur :  10.4.8-MariaDB
-- Version de PHP :  7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `flutter_cnss`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_entreprise` (IN `nom` VARCHAR(200), IN `siege` VARCHAR(200))  NO SQL
BEGIN
IF NOT EXISTS(SELECT * FROM t_entreprise WHERE DesignationEntreprise=nom AND SiegeEntreprise=siege) THEN
INSERT INTO t_entreprise(DesignationEntreprise, SiegeEntreprise) VALUES (nom,siege);
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_membre` (IN `nom` VARCHAR(50), IN `postnom` VARCHAR(50), IN `prenom` VARCHAR(50), IN `salaire` FLOAT, IN `lieunaiss` VARCHAR(50), IN `nomconjoint` VARCHAR(50), IN `postnomconjoint` VARCHAR(50), IN `entreprise` VARCHAR(5))  NO SQL
BEGIN
IF NOT EXISTS(SELECT * FROM t_membre WHERE NomMembre=nom AND PostnomMembre=postnom AND PrenomMembre=prenom) THEN
INSERT INTO t_membre(NomMembre, PostnomMembre, PrenomMembre, LieuNaissance, SalaireMembre, NomConjoint, PostnomConjoint, CodeEntreprise) VALUES (nom,postnom,prenom,lieunaiss,salaire,nomconjoint,postnomconjoint,entreprise);
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cotiser_montant` (IN `montant` FLOAT, IN `membre` INT)  NO SQL
BEGIN
DECLARE val1 float;
DECLARE val2 float;
DECLARE val3 float;

SET val1 = func_solde(membre);
SET val2 = val1+montant;
SET val3 = func_reduction_salaire(membre);

IF(montant>0 AND montant<=val3) THEN

UPDATE t_membre SET Solde=val2 WHERE CodeMembre=membre;

INSERT INTO t_contribution(Montant, CodeMembre) 
VALUES (montant,membre);

END IF;
END$$

--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `func_reduction_salaire` (`membre` INT) RETURNS FLOAT NO SQL
BEGIN
DECLARE valeur float;
SET valeur = (SELECT SalaireMembre FROM t_membre WHERE CodeMembre=membre ORDER BY CodeMembre DESC LIMIT 0,1)*0.03;
RETURN valeur;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `func_solde` (`membre` INT) RETURNS FLOAT NO SQL
BEGIN
DECLARE valeur float;
SET valeur = (SELECT Solde FROM t_membre WHERE CodeMembre=membre ORDER BY CodeMembre DESC LIMIT 0,1);
RETURN valeur;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_contribution`
--

CREATE TABLE `t_contribution` (
  `CodeContribution` int(11) NOT NULL,
  `Montant` float NOT NULL,
  `DateContribution` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CodeMembre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `t_contribution`
--

INSERT INTO `t_contribution` (`CodeContribution`, `Montant`, `DateContribution`, `CodeMembre`) VALUES
(5, 20, '2021-10-09 15:08:49', 50),
(6, 1, '2021-10-09 15:09:27', 51),
(7, 80, '2021-10-09 15:19:48', 50),
(8, 80, '2021-10-09 15:21:10', 50),
(9, 30, '2021-10-09 15:21:19', 50),
(10, 100, '2021-10-09 15:21:27', 51),
(12, 200, '2021-10-09 15:22:59', 51),
(16, 100, '2021-10-09 20:01:46', 51),
(17, 25, '2021-10-09 20:52:11', 56),
(18, 29, '2021-10-09 20:52:36', 56),
(19, 30, '2021-10-09 20:53:20', 56),
(20, 20, '2021-10-09 21:05:25', 57),
(21, 15, '2021-10-10 06:30:54', 61),
(22, 15, '2021-10-10 06:31:20', 61),
(23, 10, '2021-10-10 06:56:24', 62),
(24, 30, '2021-10-10 07:21:13', 63),
(25, 20, '2021-10-10 07:21:31', 63);

-- --------------------------------------------------------

--
-- Structure de la table `t_entreprise`
--

CREATE TABLE `t_entreprise` (
  `CodeEntreprise` int(11) NOT NULL,
  `DesignationEntreprise` varchar(200) NOT NULL,
  `SiegeEntreprise` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `t_entreprise`
--

INSERT INTO `t_entreprise` (`CodeEntreprise`, `DesignationEntreprise`, `SiegeEntreprise`) VALUES
(1, 'BCC', 'Goma'),
(2, 'ISIG-GOMA', 'Goma'),
(3, 'ISC', 'Goma'),
(4, 'UNIGOM', 'Goma'),
(5, 'LA SAPIENTIA ', 'Goma'),
(6, 'BIAC', 'Goma'),
(7, 'SEPCONGO', 'kin'),
(10, 'CADECO', 'kin'),
(11, 'KIVUNET', 'goma'),
(12, 'ULPGL', 'goma'),
(13, 'UCNDK', 'Goma'),
(14, 'ok', 'ok'),
(15, 'RAWBANK', 'Kinshasa'),
(16, 'MONUSCO', 'Kinshasa '),
(18, 'BCDC', 'goma'),
(19, 'BCCC', 'goma'),
(20, 'VIRUNGA sarl', 'Goma/ RDC'),
(21, 'UB-FM', 'goma'),
(24, 'HOLYDAY', 'goma'),
(25, 'BIGEGA Software', 'Goma'),
(26, 'TEST', 'Goma '),
(27, 'FOUND SOLUTION ', 'Goma');

-- --------------------------------------------------------

--
-- Structure de la table `t_membre`
--

CREATE TABLE `t_membre` (
  `CodeMembre` int(11) NOT NULL,
  `NomMembre` varchar(50) NOT NULL,
  `PostnomMembre` varchar(50) NOT NULL,
  `PrenomMembre` varchar(50) NOT NULL,
  `Username` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Solde` float NOT NULL,
  `SexeMembre` varchar(10) NOT NULL,
  `DateNaissance` date NOT NULL,
  `LieuNaissance` varchar(100) NOT NULL,
  `PhotoMembre` text NOT NULL,
  `SalaireMembre` float NOT NULL,
  `NomConjoint` varchar(50) NOT NULL,
  `PostnomConjoint` varchar(50) NOT NULL,
  `CodeEntreprise` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `t_membre`
--

INSERT INTO `t_membre` (`CodeMembre`, `NomMembre`, `PostnomMembre`, `PrenomMembre`, `Username`, `Password`, `Solde`, `SexeMembre`, `DateNaissance`, `LieuNaissance`, `PhotoMembre`, `SalaireMembre`, `NomConjoint`, `PostnomConjoint`, `CodeEntreprise`) VALUES
(50, 'Baraka', 'Bigega', 'Espoir', 'EspoirBaraka03', '1234', 210, '', '0000-00-00', 'Goma', '', 100, 'Xx', 'yy', 2),
(51, 'Siwa', 'Mumbere', 'Carin', 'CarinSiwa26', '1234', 401, '', '0000-00-00', 'Goma', '', 400, 'jj', 'jj', 5),
(54, 'Espoir', 'Useni', 'Espoir', 'EspoirEspoir05', '1234', 0, '', '0000-00-00', 'Goma', '', 200, 'hhh', 'jjj', 15),
(56, 'Akilimali', 'Baraka', 'Michael', 'MichaelAkilimali17', '1234', 84, '', '0000-00-00', 'Goma', '', 1000, 'hh', 'hh', 2),
(57, 'Elizabeth', 'Kahindo', 'Hadassa', 'HadassaElizabeth55', '1234', 20, '', '0000-00-00', 'Goma', '', 800, 'hhh', 'jh', 10),
(58, 'Salem', 'Baraka', 'Martha', 'MarthaSalem14', '1234', 0, '', '0000-00-00', 'Goma', '', 700, 'yey', 'hh', 4),
(59, 'Baraka', 'Bigega', 'Francois', 'FrancoisBaraka46', '1234', 0, '', '0000-00-00', 'Goma', '', 5000, 'uu', 'ii', 6),
(60, 'Michael', 'djo', 'Mick', 'MickMichael53', '1234', 0, '', '0000-00-00', 'Goma', '', 800, 'hh', 'kk', 13),
(61, 'Provi', 'Baraka', 'Provi', 'ProviProvi23', '1234', 30, '', '0000-00-00', 'Goma', '', 600, 'hhh', 'hhh', 25),
(62, 'Muderhwa', 'safari', 'andre', 'andreMuderhwa03', '1234', 10, '', '0000-00-00', 'goma', '', 400, 'Lydie ', 'nsimire', 26),
(63, 'Steven', 'Zambali', 'Lukunja', 'LukunjaSteven17', '1234', 50, '', '0000-00-00', 'Goma', '', 1000, 'yyy', 'hhh', 27);

--
-- Déclencheurs `t_membre`
--
DELIMITER $$
CREATE TRIGGER `before_insert_membre` BEFORE INSERT ON `t_membre` FOR EACH ROW BEGIN
SET NEW.Username=CONCAT(New.PrenomMembre,New.NomMembre, SUBSTRING(CAST(NOW() AS CHAR),18,2));
SET NEW.Password='1234';
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_user`
--

CREATE TABLE `t_user` (
  `CodeUser` int(11) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `Photo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `t_user`
--

INSERT INTO `t_user` (`CodeUser`, `Username`, `Password`, `Photo`) VALUES
(1, 'espoir', 'admin', ''),
(13, 'steven', '1234', ''),
(14, 'nicole', 'admin', ''),
(15, 'andre', 'admin', '');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `t_contribution`
--
ALTER TABLE `t_contribution`
  ADD PRIMARY KEY (`CodeContribution`),
  ADD KEY `fk_contribution_membre` (`CodeMembre`);

--
-- Index pour la table `t_entreprise`
--
ALTER TABLE `t_entreprise`
  ADD PRIMARY KEY (`CodeEntreprise`);

--
-- Index pour la table `t_membre`
--
ALTER TABLE `t_membre`
  ADD PRIMARY KEY (`CodeMembre`),
  ADD KEY `fk_membre_entreprise` (`CodeEntreprise`);

--
-- Index pour la table `t_user`
--
ALTER TABLE `t_user`
  ADD PRIMARY KEY (`CodeUser`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `t_contribution`
--
ALTER TABLE `t_contribution`
  MODIFY `CodeContribution` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `t_entreprise`
--
ALTER TABLE `t_entreprise`
  MODIFY `CodeEntreprise` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pour la table `t_membre`
--
ALTER TABLE `t_membre`
  MODIFY `CodeMembre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT pour la table `t_user`
--
ALTER TABLE `t_user`
  MODIFY `CodeUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `t_contribution`
--
ALTER TABLE `t_contribution`
  ADD CONSTRAINT `fk_contribution_membre` FOREIGN KEY (`CodeMembre`) REFERENCES `t_membre` (`CodeMembre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `t_membre`
--
ALTER TABLE `t_membre`
  ADD CONSTRAINT `fk_membre_entreprise` FOREIGN KEY (`CodeEntreprise`) REFERENCES `t_entreprise` (`CodeEntreprise`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
