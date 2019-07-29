-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.15 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for music_store
CREATE DATABASE IF NOT EXISTS `music_store` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `music_store`;

-- Dumping structure for table music_store.address
CREATE TABLE IF NOT EXISTS `address` (
  `musician_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `musician_phone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`musician_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.address: ~10 rows (approximately)
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT IGNORE INTO `address` (`musician_id`, `country_id`, `musician_phone`) VALUES
	(1, 3, '123456868'),
	(2, 3, '232352355'),
	(3, 3, '523463463'),
	(4, 2, '112351255'),
	(5, 2, '112351255'),
	(6, 2, '234623461'),
	(7, 1, '136136136'),
	(8, 1, '236236236'),
	(9, 1, '124124124'),
	(10, 6, '322352351');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;

-- Dumping structure for table music_store.album
CREATE TABLE IF NOT EXISTS `album` (
  `album_id` int(11) NOT NULL,
  `album_name` varchar(45) NOT NULL,
  `album_startRecDate` date DEFAULT NULL,
  `album_finishRecDate` date DEFAULT NULL,
  `album_songsNum` int(11) NOT NULL,
  `musician_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  UNIQUE KEY `album_id_UNIQUE` (`album_id`),
  KEY `fk_musician_id` (`musician_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.album: ~10 rows (approximately)
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT IGNORE INTO `album` (`album_id`, `album_name`, `album_startRecDate`, `album_finishRecDate`, `album_songsNum`, `musician_id`) VALUES
	(1, 'Netsky', '2009-10-05', '2010-01-06', 14, 1),
	(2, '2', '2011-04-05', '2012-06-25', 15, 1),
	(3, '3', '2013-01-01', '2016-06-03', 12, 1),
	(4, 'Immersion', '2008-03-01', '2010-05-21', 15, 5),
	(5, 'The Reworks', '2000-01-01', '2018-06-29', 13, 5),
	(6, 'In Silico', '2007-05-05', '2008-05-12', 10, 5),
	(7, 'Hold Your Colour', '2003-02-02', '2005-07-25', 14, 5),
	(8, 'Endless', '2013-05-05', '2013-06-06', 1, 6),
	(9, 'No Fox Given', '2016-06-05', '2016-05-01', 1, 6),
	(10, 'Go Like', '2019-05-05', '2016-05-05', 1, 6);
/*!40000 ALTER TABLE `album` ENABLE KEYS */;

-- Dumping structure for table music_store.country
CREATE TABLE IF NOT EXISTS `country` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(45) NOT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `country_name_UNIQUE` (`country_name`),
  UNIQUE KEY `country_id_UNIQUE` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.country: ~10 rows (approximately)
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT IGNORE INTO `country` (`country_id`, `country_name`) VALUES
	(10, 'Austria'),
	(4, 'Belgium'),
	(6, 'China'),
	(3, 'Irlands'),
	(5, 'Israel'),
	(9, 'Italy'),
	(7, 'North Korea'),
	(8, 'Russia'),
	(2, 'UK'),
	(1, 'USA');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;

-- Dumping structure for table music_store.genre
CREATE TABLE IF NOT EXISTS `genre` (
  `genre_id` int(11) NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(45) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE KEY `genre_id_UNIQUE` (`genre_id`),
  UNIQUE KEY `genre_name_UNIQUE` (`genre_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.genre: ~10 rows (approximately)
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT IGNORE INTO `genre` (`genre_id`, `genre_name`) VALUES
	(10, 'Ambient'),
	(1, 'Bass'),
	(8, 'Blues'),
	(5, 'Classic'),
	(4, 'Electronic'),
	(9, 'Hip-hop'),
	(6, 'Jazz'),
	(7, 'Metal'),
	(3, 'Pop'),
	(2, 'Rock');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;

-- Dumping structure for table music_store.instrument
CREATE TABLE IF NOT EXISTS `instrument` (
  `instrument_id` int(11) NOT NULL,
  `instrument_name` varchar(45) NOT NULL,
  `manufacturer_id` int(11) NOT NULL,
  UNIQUE KEY `instrument_id_UNIQUE` (`instrument_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.instrument: ~10 rows (approximately)
/*!40000 ALTER TABLE `instrument` DISABLE KEYS */;
INSERT IGNORE INTO `instrument` (`instrument_id`, `instrument_name`, `manufacturer_id`) VALUES
	(1, 'Piano', 1),
	(2, 'Guitar', 1),
	(3, 'Bass Guitar', 1),
	(4, 'Drums', 1),
	(5, 'Violin', 1),
	(6, 'Mixer', 2),
	(7, 'Saxophone', 3),
	(8, 'Cello', 4),
	(9, 'Trumpet', 5),
	(10, 'Vocal', 1);
/*!40000 ALTER TABLE `instrument` ENABLE KEYS */;

-- Dumping structure for table music_store.manufacturer
CREATE TABLE IF NOT EXISTS `manufacturer` (
  `manufacturer_id` int(11) NOT NULL,
  `manufacturer_name` varchar(45) NOT NULL,
  PRIMARY KEY (`manufacturer_id`),
  UNIQUE KEY `instrument_manufacturer_id_UNIQUE` (`manufacturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.manufacturer: ~10 rows (approximately)
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
INSERT IGNORE INTO `manufacturer` (`manufacturer_id`, `manufacturer_name`) VALUES
	(1, 'Yamaha'),
	(2, 'Sony'),
	(3, 'Philips'),
	(4, 'JVC'),
	(5, 'Sanyo'),
	(6, 'Gibson'),
	(7, 'Seagull'),
	(8, 'Martin'),
	(9, 'Taylor'),
	(10, 'Ovation');
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;

-- Dumping structure for table music_store.musician
CREATE TABLE IF NOT EXISTS `musician` (
  `musician_id` int(11) NOT NULL,
  `musician_name` varchar(45) NOT NULL,
  `musician_address_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`musician_id`),
  UNIQUE KEY `fk_musician_id` (`musician_id`),
  KEY `fk_musician_address_id` (`musician_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.musician: ~10 rows (approximately)
/*!40000 ALTER TABLE `musician` DISABLE KEYS */;
INSERT IGNORE INTO `musician` (`musician_id`, `musician_name`, `musician_address_id`) VALUES
	(1, 'Netsky', '10'),
	(2, 'Sia', '9'),
	(3, 'Dardust', '8'),
	(4, 'Chopen', '7'),
	(5, 'Pendulum', '6'),
	(6, 'Fox Stevenson', '5'),
	(7, 'Mozart', '4'),
	(8, 'Wan Lolen', '3'),
	(9, 'Madeon', '2'),
	(10, 'Queen', '1');
/*!40000 ALTER TABLE `musician` ENABLE KEYS */;

-- Dumping structure for table music_store.song
CREATE TABLE IF NOT EXISTS `song` (
  `song_id` int(11) NOT NULL AUTO_INCREMENT,
  `song_name` varchar(45) DEFAULT NULL,
  `song_time` int(11) NOT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `song_date` date DEFAULT NULL,
  `album_id` int(11) NOT NULL,
  `song_type_id` int(11) DEFAULT NULL,
  `instrument_id` varchar(45) DEFAULT NULL,
  `song_tech_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`song_id`),
  UNIQUE KEY `song_id_UNIQUE` (`song_id`),
  KEY `fx_genre_id` (`genre_id`),
  CONSTRAINT `fx_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.song: ~10 rows (approximately)
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT IGNORE INTO `song` (`song_id`, `song_name`, `song_time`, `genre_id`, `song_date`, `album_id`, `song_type_id`, `instrument_id`, `song_tech_id`) VALUES
	(1, 'Escape', 358, 4, '2010-05-31', 1, 1, '1', '8'),
	(2, 'Iron Heart', 356, 4, '2010-05-31', 1, 1, '2', '8'),
	(3, 'Moving with You', 315, 4, '2010-05-31', 1, 1, '3', '8'),
	(4, 'Secret Agent', 335, 1, '2010-05-31', 1, 1, '1', '8'),
	(5, 'Crush', 253, 1, '2010-05-31', 4, 5, '1', '8'),
	(6, 'Blood Sugar', 215, 1, '2018-05-01', 5, 5, '1', '8'),
	(7, 'Prelude', 52, 1, '2007-01-01', 7, 4, '4', '8'),
	(8, 'Out Here', 512, 7, '2007-02-02', 7, 8, '2', '8'),
	(9, 'Tarantula', 351, 6, '2007-02-02', 7, 3, '5', '9'),
	(10, 'Still Grey', 655, 3, '2007-02-02', 7, 2, '10', '9');
/*!40000 ALTER TABLE `song` ENABLE KEYS */;

-- Dumping structure for table music_store.song_type
CREATE TABLE IF NOT EXISTS `song_type` (
  `song_type_id` int(11) NOT NULL,
  `song_type_name` varchar(45) NOT NULL,
  UNIQUE KEY `song_type_id_UNIQUE` (`song_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.song_type: ~10 rows (approximately)
/*!40000 ALTER TABLE `song_type` DISABLE KEYS */;
INSERT IGNORE INTO `song_type` (`song_type_id`, `song_type_name`) VALUES
	(1, 'Electronic'),
	(2, 'Vocal'),
	(3, 'Instrumental'),
	(4, 'Opera'),
	(5, 'Bass'),
	(6, 'MSRM'),
	(7, 'Beat'),
	(8, 'Drums'),
	(9, 'Piano'),
	(10, 'Horn');
/*!40000 ALTER TABLE `song_type` ENABLE KEYS */;

-- Dumping structure for table music_store.song_with
CREATE TABLE IF NOT EXISTS `song_with` (
  `song_id` int(11) NOT NULL,
  `musician_id` int(11) NOT NULL,
  PRIMARY KEY (`musician_id`,`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table music_store.song_with: ~9 rows (approximately)
/*!40000 ALTER TABLE `song_with` DISABLE KEYS */;
INSERT IGNORE INTO `song_with` (`song_id`, `musician_id`) VALUES
	(6, 1),
	(6, 2),
	(6, 3),
	(6, 4),
	(1, 5),
	(2, 5),
	(1, 6),
	(2, 6),
	(1, 7);
/*!40000 ALTER TABLE `song_with` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
