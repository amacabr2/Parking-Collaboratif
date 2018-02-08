DROP TABLE IF EXISTS `parking`;

CREATE TABLE IF NOT EXISTS `parking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prix_horaire` float NOT NULL,
  `surveille` tinyint(1) NOT NULL,
  `souterrain` tinyint(1) NOT NULL,
  `disponible` tinyint(1) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

INSERT INTO `parking` (`id`, `prix_horaire`, `surveille`, `souterrain`, `disponible`, `adresse`) VALUES
(NULL, 12.2, 1, 0, 1, 'France, Paris, 124 Rue de Belleville'),
(NULL, 2.45, 0, 0, 1, 'France, Paris, 71 Rue Didot'),
(NULL, 12.1, 1, 0, 1, 'France, Paris, 26 Avenue de Wagram'),
(NULL, 12.9, 1, 1, 0, 'France, Paris, 12 Rue Daru'),
(NULL, 11.3, 1, 0, 1, 'France, Paris, 8 Avenue César Caire'),
(NULL, 11, 0, 1, 1, 'France, Paris, 13 Avenue du Président Wilson');
