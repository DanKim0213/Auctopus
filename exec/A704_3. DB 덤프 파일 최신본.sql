DROP DATABASE IF EXISTS `auctopus`;
CREATE DATABASE IF NOT EXISTS `auctopus`;
USE `auctopus`;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `email` VARCHAR(50) NOT NULL,
  `nickname` VARCHAR(20) NOT NULL,
  `user_name` VARCHAR(20) DEFAULT NULL,
  `social` TINYINT DEFAULT '0',
  `bank_code` INT DEFAULT '0',
  `account` VARCHAR(50) DEFAULT NULL,
  `address` VARCHAR(100) DEFAULT NULL,
  `profile_url` VARCHAR(500) DEFAULT NULL,

   PRIMARY KEY(`email`),
   UNIQUE KEY `nickname_UNIQUE` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;


-- -----------------------------------------------------
-- Table `auction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction`;

CREATE TABLE `auction` (
  `auction_seq` INT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(20) NOT NULL,
  `category_seq` INT NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_price` INT NOT NULL DEFAULT '0',
  `bid_unit` INT NOT NULL,
  `link` VARCHAR(500) DEFAULT NULL,
  `like_count` INT NOT NULL DEFAULT '0',
	`state` TINYINT NOT NULL DEFAULT '0',

  PRIMARY KEY(`auction_seq`),
  KEY `auction_useremail_fk_user_email_idx` (`user_email`),
  CONSTRAINT `auction_useremail_fk_user_email_idx` FOREIGN KEY(`user_email`) REFERENCES `user`(`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- -----------------------------------------------------
-- Table `auction_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auction_image`;

CREATE TABLE `auction_image` (
  `auction_image_seq` INT NOT NULL AUTO_INCREMENT,
  `auction_seq` INT NOT NULL,
  `image_url` VARCHAR(500) NOT NULL,

  PRIMARY KEY(`auction_image_seq`),
  KEY `auctionimage_auctionseq_fk_auction_seq_idx` (`auction_seq`),
  CONSTRAINT `auctionimage_auctionseq_fk_auction_seq_idx` FOREIGN KEY(`auction_seq`) REFERENCES `auction`(`auction_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- -----------------------------------------------------
-- Table `live`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `live`;

CREATE TABLE `live` (
  `live_seq` INT NOT NULL,
  `user_email` VARCHAR(20) NOT NULL,
  `start_time` TIMESTAMP NOT NULL,
  `end_time` TIMESTAMP NOT NULL,
  `current_price` INT NOT NULL,
  `bid_unit` INT NOT NULL,
  `top_bidder` VARCHAR(20) NOT NULL,
  `viewer` INT NOT NULL DEFAULT '0',
  `participant` INT NOT NULL DEFAULT '0',

  PRIMARY KEY(`live_seq`),
  KEY `live_liveseq_fk_live_seq_idx` (`live_seq`),
  KEY `live_useremail_fk_user_email_idx` (`user_email`),
	CONSTRAINT `live_liveseq_fk_live_seq_idx` FOREIGN KEY (`live_seq`) REFERENCES `auction` (`auction_seq`),
  CONSTRAINT `live_useremail_fk_user_email_idx` FOREIGN KEY (`user_email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- -----------------------------------------------------
-- Table `live_participant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `live_viewer`;

CREATE TABLE `live_viewer` (
	`viewer_email` VARCHAR(20) NOT NULL,
	`live_seq` INT NOT NULL,
	`auto_price` INT NOT NULL,
	`state` INT NOT NULL, /* 0?????? ????????? ?????????, 1?????? ?????? ????????? */
	
	PRIMARY KEY(`viewer_email`),
	KEY `liveviewer_vieweremail_fk_viewer_email_idx` (`viewer_email`),
	KEY `liveviewer_liveseq_fk_live_seq_idx` (`live_seq`),
	CONSTRAINT `liveviewer_vieweremail_fk_viewer_email_idx` FOREIGN KEY (`viewer_email`) REFERENCES `user` (`email`),
	CONSTRAINT `liveviewer_liveseq_fk_live_seq_idx` FOREIGN KEY (`live_seq`) REFERENCES `live` (`live_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `like_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `like_category`;

CREATE TABLE `like_category` (
  `like_category_seq` INT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(20) NOT NULL,
  `category_seq` INT NOT NULL,

  PRIMARY KEY(`like_category_seq`),
  KEY `likecategory_useremail_fk_user_email_idx` (`user_email`),
  CONSTRAINT `likecategory_useremail_fk_user_email_idx` FOREIGN KEY(`user_email`) REFERENCES `user`(`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- -----------------------------------------------------
-- Table `like_auction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `like_auction`;

CREATE TABLE `like_auction` (
  `like_auction_seq` INT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(20) NOT NULL,
  `auction_seq` INT NOT NULL,

  PRIMARY KEY(`like_auction_seq`),
  KEY `likeauction_useremail_fk_user_email_idx` (`user_email`),
  KEY `likeauction_auctionseq_fk_auction_seq_idx` (`auction_seq`),
  CONSTRAINT `likeauction_useremail_fk_user_email_idx` FOREIGN KEY(`user_email`) REFERENCES `user`(`email`),
  CONSTRAINT `likeauction_auctionseq_fk_auction_seq_idx` FOREIGN KEY(`auction_seq`) REFERENCES `auction`(`auction_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


-- -----------------------------------------------------
-- Table `notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
	`notification_seq` INT NOT NULL AUTO_INCREMENT,
	`user_email` VARCHAR(20) NOT NULL,
	`representative_image_url` VARCHAR(500) NOT NULL,
	`message` VARCHAR(100) NOT NULL,
	
	PRIMARY KEY(`notification_seq`),
	KEY `notification_useremail_fk_user_email_idx` (`user_email`),
	CONSTRAINT `notification_useremail_fk_user_email_idx` FOREIGN KEY(`user_email`) REFERENCES `user`(`email`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_seq` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(20) NOT NULL,

  PRIMARY KEY(`category_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;



-- -----------------------------------------------------
-- Dumping data
-- -----------------------------------------------------

INSERT INTO `category` (`category_seq`, `category_name`) VALUES (1, '????????????');
INSERT INTO `category` (`category_seq`, `category_name`) VALUES (2, '??????/??????');
INSERT INTO `category` (`category_seq`, `category_name`) VALUES (3, '??????/??????');
INSERT INTO `category` (`category_seq`, `category_name`) VALUES (4, '??????/??????');
INSERT INTO `category` (`category_seq`, `category_name`) VALUES (5, '??????/??????');
INSERT INTO `category` (`category_seq`, `category_name`) VALUES (6, '????????????');
INSERT INTO `category` (`category_seq`, `category_name`) VALUES (7, '????????????');
INSERT INTO `category` (`category_seq`, `category_name`) VALUES (8, '??????');

INSERT INTO `user` (`email`, `nickname`, `user_name`, `social`, `bank_code`, `account`, `address`, `profile_url`) VALUES ("wsb1017@naver.com", "????????????", "?????????", 0, 90, "3333-05-8781016", "?????? ???????????????", "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/909.png");
INSERT INTO `user` (`email`, `nickname`, `user_name`, `social`, `bank_code`, `account`, `address`, `profile_url`) VALUES ('vante1230@kakao.com', 'B_B', '?????????', 0, 1, '1234-56-7890', '?????????', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSskkIMth7MDjQj4hBHmIvDJFABsSzj7h3W7wQxlEEbNMSCALNMaspWf-G5g6EUzTurG6g&usqp=CAU');
INSERT INTO `user` (`email`, `nickname`, `user_name`, `social`, `bank_code`, `account`, `address`, `profile_url`) VALUES ('won64312000@naver.com', 'ljw', '?????????', 0, 1, '1234-56-7890', '?????????', 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzAxMDlfMTYg%2FMDAxNjczMjc0OTA2MDY0.4ND3U-Txm9CuQVqaHOnPwR638FTS1hQ_rZhVqtaPCw8g.F0SieytDX7ioUu7HF8-d89eCIw9D3E4FkpQW0Q1xyiYg.PNG.flower9715%2F%25288%2529.PNG&type=a340');
INSERT INTO `user` (`email`, `nickname`, `user_name`, `social`, `bank_code`, `account`, `address`, `profile_url`) VALUES ('thsdpwll@nate.com', 'syj', '?????????', 0, 1, '1234-56-7890', '??????', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFcfenUKQ0feNbp-pxx8hQryvWD4fCDDoKaA&usqp=CAU');
INSERT INTO `user` (`email`, `nickname`, `user_name`, `social`, `bank_code`, `account`, `address`, `profile_url`) VALUES ('jackid1103@gmail.com', 'jsg', '?????????', 0, 1, '1234-56-7890', '??????', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaNPDa0o78XoLPHoUNumPRulv992FpmGnyeg&usqp=CAU');
INSERT INTO `user` (`email`, `nickname`, `user_name`, `social`, `bank_code`, `account`, `address`, `profile_url`) VALUES ('taw4654@gmail.com', 'kkk', '?????????', 0, 1, '1234-56-7890', '??????', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSb1YWZMD3iiXAvGMgkL_BqhP-5Cs0eJlVEcw&usqp=CAU');

INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (1, 100000, 1, 'LG ?????? ????????? ???????????? ????????? ?????? ??? ???????????????!', 5, NULL, 3000000, '2023-02-18 18:00:00.000000', 0, '????????? ??????', 'wsb1017@naver.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (2, 10000000, 2, '????????????????????? X ????????? ?????? ?????? 1 ?????? ??????????????? F&F ??????????????????. ???????????? ????????? ??? ?????????????????????. ???????????????.', 0, NULL, 35000000, '2023-02-19 22:30:00.000000', 0, '????????? ????????????1?????? ???????????????', 'wsb1017@naver.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (3, 100000, 3, '????????? ????????? ?????????????????? ???????????? ??????????????????!', 3, NULL, 1500000, '2023-02-17 10:00:00.000000', 2, '?????????????????? ?????????', 'wsb1017@naver.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (4, 10000, 2, '????????? ??????????????? ?????????????????? ????????? ????????? ????????????', 2, NULL, 200000, '2023-02-23 20:45:00.000000', 0, '??????????????? ?????????', 'wsb1017@naver.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (5, 10000, 8, 'R2 ?????? Team ??????????????????. ?????? ???????????????!', 4, NULL, 120000, '2023-01-10 22:00:00.000000', 0, 'KBL ???????????? ??????', 'vante1230@kakao.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (6, 2000, 4, '????????? 2020 ????????????????????? ??????????????? ????????? ????????????! ?????? ??????????????????', 3, NULL, 30000, '2023-02-17 10:30:00.000000', 2, '????????? ??????????????? ??????', 'vante1230@kakao.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (7, 10000, 8, '?????? 2/26??? 2????????????. vip??? 2???????????????(????????? ????????????) ????????? ????????? ???????????????!', 2, NULL, 320000, '2023-02-19 17:00:00.000000', 0, '????????? ???????????????', 'vante1230@kakao.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (8, 3000, 8, '???????????? ?????? ????????? ??????????????? ????????? ?????? ????????????????????????~', 1, NULL, 15000, '2023-02-17 12:40:00.000000', 0, '?????????????????????!', 'vante1230@kakao.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (9, 10000, 3, '???????????? ?????? ???????????? ???????????? ????????????! ?????? ???????????? ???????????? ??????????????? ???????????????', 5, NULL, 100000, '2023-02-27 19:40:00.000000', 0, '???????????? ?????????', 'thsdpwll@nate.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (10, 5000, 1, '???????????? ???????????????. 2????????? ?????????! ?????? ??????????????? ???????????? ???????????? ?????????!', 4, NULL, 40000, '2023-02-17 10:10:00.000000', 2, '????????? ??????', 'thsdpwll@nate.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (11, 50000, 1, '14??????????????? ???????????? ???????????? ?????????! ????????? ?????? 100%?????????', 3, NULL, 800000, '2023-03-01 14:00:00.000000', 0, '????????? 14 ??????', 'thsdpwll@nate.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (12, 20000, 1, '????????? ??????????????? ???????????? ????????? ????????? ????????? ????????? ??????! ????????? ?????? ?????? ??????!', 0, NULL, 500000, '2023-02-17 09:50:00.000000', 2, '????????? ??????', 'jackid1103@naver.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (13, 1000, 2, '????????? ??????????????????~~ ?????????????????? ?????? ?????? ???????????? 2??? ????????????! ????????? ?????? ????????????!', 3, NULL, 20000, '2023-02-23 21:30:00.000000', 0, '?????? ??????????????? ????????? ??????', 'jackid1103@naver.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (14, 2000, 2, '????????? ?????? ??????????????????! ????????? 13?????? ???????????? ???????????? ????????? ??????????????? 1-2???????????? ????????????! ?????? ????????? ???????????????', 2, NULL, 50000, '2023-02-22 18:00:00.000000', 0, '????????????????????? ?????????', 'jackid1103@naver.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (15, 500, 4, '????????? ???????????????! ????????? ?????? ?????? ?????????! ????????? ?????? ?????? ????????? ?????????', 2, NULL, 7000, '2023-02-24 15:20:00.000000', 0, '????????? ??????', 'jackid1103@naver.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (16, 5000, 4, '???????????? ??? ???????????????! ???????????????????????? ?????? ????????????!', 3, NULL, 20000, '2023-02-17 10:00:00.000000', 2, '????????? ??????', 'taw4654@gmail.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (17, 100000, 1, '?????? ????????? ?????????! ?????? ??????????????? ?????? ??? ???????????????', 0, NULL, 1000000, '2023-03-01 20:00:00.000000', 0, '?????? ?????????', 'taw4654@gmail.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (18, 50000, 1, 'NT761XDA X07/C ???????????? ???????????????! ???????????? ???????????? ?????????????????? ?????????', 0, NULL, 1500000, '2023-02-26 09:00:00.000000', 0, '?????? ????????????', 'taw4654@gmail.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (19, 5000, 1, '?????????S?????????! ?????? ????????????~ ??????????????? ????????????! ?????????,????????? ????????????', 3, NULL, 150000, '2023-02-12 14:00:00.000000', 2, '??????????????? ?????????S', 'thsdpwll@nate.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (21, 4000, 2, '??????????????????! ?????? ????????????~ ?????? ???????????????!! ', 2, NULL, 20000, '2023-02-21 20:00:00.000000', 0, '???????????? ?????????', 'thsdpwll@nate.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (22, 4000, 2, '?????? ?????????????????? ??????????????????, ?????? ???????????????~ ?????? ????????????!', 3, NULL, 20000, '2023-02-21 10:00:00.000000', 0, '?????? ?????????', 'thsdpwll@nate.com');
INSERT INTO `auction` (`auction_seq`, `bid_unit`, `category_seq`, `content`, `like_count`, `link`, `start_price`, `start_time`, `state`, `title`, `user_email`) VALUES (23, 4000, 3, '????????? ?????? ???????????? ???????????? ?????????', 0, NULL, 20000, '2023-02-11 10:00:00.000000', 2, '??????????????? ???', 'thsdpwll@nate.com');

INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (53, 22, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (54, 22, 'vante1230@kakao.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (55, 22, 'wsb1017@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (50, 21, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (51, 21, 'vante1230@kakao.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (52, 21, 'wsb1017@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (46, 19, 'taw4654@gmail.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (47, 19, 'vante1230@kakao.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (43, 16, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (44, 16, 'vante1230@kakao.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (40, 14, 'taw4654@gmail.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (41, 14, 'wsb1017@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (37, 13, 'vante1230@kakao.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (34, 11, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (36, 11, 'taw4654@gmail.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (35, 11, 'vante1230@kakao.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (31, 10, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (32, 10, 'taw4654@gmail.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (33, 10, 'vante1230@kakao.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (30, 10, 'wsb1017@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (25, 9, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (26, 9, 'taw4654@gmail.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (29, 9, 'vante1230@kakao.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (28, 9, 'wsb1017@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (22, 7, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (23, 7, 'wsb1017@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (19, 6, 'taw4654@gmail.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (21, 6, 'wsb1017@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (16, 5, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (18, 5, 'wsb1017@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (10, 3, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (6, 2, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (7, 2, 'taw4654@gmail.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (9, 2, 'vante1230@kakao.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (4, 1, 'jackid1103@naver.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (5, 1, 'taw4654@gmail.com');
INSERT INTO `like_auction` (`like_auction_seq`, `auction_seq`, `user_email`) VALUES (1, 1, 'vante1230@kakao.com');

INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (1, 1, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/1/01dlrjtehxhRldlwlaksrmfoeh+rmfoadlqslek.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (2, 1, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/1/01sbwlstmrmfoadlqslekdlrjsxhRl.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (3, 2, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/2/02ryanchristmastreedlsgudgkswjdvks.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (4, 2, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/2/02wlemforhsgkswjdvkstlsqkf.PNG');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (5, 3, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/3/03dkdldbRhcrkfvldpfvlgkswjdvks.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (6, 3, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/3/03dkdldbRhcrkfvlgkswjdvksdpfvl.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (7, 4, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/4/04gkswjdvksfkspwmvoeldqorapwhdzlcmsp.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (8, 5, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/5/05allstarkblwhktjrvydkssosodnlclsmsdjel.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (9, 5, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/5/05kblallstarwjsxlzptdksso.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (10, 6, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/6/06fkdldjszmfltmaktmxorekfflsrj.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (11, 6, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/6/06ryanchristmastreedlsgudgkswjdvksdd.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (12, 7, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/7/07tmdnlslxhemvhtmxjapdls.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (13, 7, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/7/07tmdnlslxhemwlrmadmsaowls.PNG');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (14, 8, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auctopus_basic.png');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (15, 9, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/9/09slamdunkaksghkcordhksruf.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (16, 9, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/9/09tmffoaejdzmthdxotjqdlqslek.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (17, 9, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/9/09tmffoaejdzmwjdeoaksdlqslek.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (18, 10, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/10/10dodjvktvmfhwndrhrjfodufflsrj.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (19, 10, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/10/10wndrhrjfoekeglsrjdlzpdltmehvhgka.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (20, 11, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/11/11dkdlvhsaortm14qoxjflwksfidghkrdls.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (21, 11, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/11/11dovmfdkdlvhsaortm14vmfh.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (22, 12, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/12/12dpdjvktaortmtlfqjdlqslekdlrjs.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (23, 13, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/13/13alsxmtorslxmdlwpvnawjf.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (24, 13, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/13/13dlrjalsxmtortkdvnadlQmsslxm.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (25, 14, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/14/14shxmqnrdlrjshxmqnr.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (26, 14, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/14/14sxhxmqnrdkQkfrkstorwhtpq.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (27, 15, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/15/15vhckzhzlfldentausdlQmek.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (28, 15, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/15/15vhckzhzlfldEoehdksxka.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (29, 16, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auctopus_basic.png');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (30, 17, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/17/17tkatjdshxmQnrdhelttpdltorj.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (31, 17, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/17/17tkatjdshxmqnrtorjtorj.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (32, 18, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auctopus_basic.png');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (33, 19, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/19/19dlrjsmsdlqnrflejrldlqslek.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (34, 19, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/19/19dlrjsmsdlqnrflejrlzjqjzpdltmdjflsdhkdwk.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (35, 19, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/19/19dlrjsmsdlqnrflejrlzpdltmzjqj.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (36, 21, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/21/20dlrjsmseogksgkdrhdfpelqorghkdlxm.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (37, 21, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/21/20eogksgkdrhdfpelqordnldptjqhstkwlsdlqslek.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (38, 22, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/22/21tmqjrchfhrdlfpelqorrngkrlglaemfa.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (39, 22, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/22/21tmqjrfpelqorchfhrtorWkddlQmek.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (40, 23, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/23/22ajtlsfjsldelqfjsldcordlarjelEkt.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (41, 23, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/23/22tnlqrpqodnsmRepdlxjqnstjrwkfahffk.jpg');
INSERT INTO `auction_image` (`auction_image_seq`, `auction_seq`, `image_url`) VALUES (42, 23, 'https://s3-auctopus.s3.ap-northeast-2.amazonaws.com/auction/23/22vkdlTJsvmfhrmfoaldwkfahfna.jpg');

INSERT INTO `live` (`live_seq`, `user_email`, `start_time`, `end_time`, `current_price`, `bid_unit`, `top_bidder`, `viewer`, `participant`) VALUES (3, 'wsb1017@naver.com', '2023-02-16 10:00:00', "2023-02-16 11:00:00", 2500000, 100000, 'jackid1103@naver.com', 4, 2);
INSERT INTO `live` (`live_seq`, `user_email`, `start_time`, `end_time`, `current_price`, `bid_unit`, `top_bidder`, `viewer`, `participant`) VALUES (6, 'vante1230@kakao.com', '2023-02-16 10:30:00', "2023-02-16 11:30:00", 40000, 2000, 'taw4654@gmail.com', 2, 1);
INSERT INTO `live` (`live_seq`, `user_email`, `start_time`, `end_time`, `current_price`, `bid_unit`, `top_bidder`, `viewer`, `participant`) VALUES (10, 'thsdpwll@nate.com', '2023-02-16 10:10:00', "2023-02-16 11:10:00", 55000, 5000, 'taw4654@gmail.com', 2, 3);
INSERT INTO `live` (`live_seq`, `user_email`, `start_time`, `end_time`, `current_price`, `bid_unit`, `top_bidder`, `viewer`, `participant`) VALUES (12, 'jackid1103@naver.com', '2023-02-16 09:50:00', "2023-02-16 10:50:00", 600000, 20000, 'vante1230@kakao.com', 2, 10);
INSERT INTO `live` (`live_seq`, `user_email`, `start_time`, `end_time`, `current_price`, `bid_unit`, `top_bidder`, `viewer`, `participant`) VALUES (16, 'taw4654@gmail.com', '2023-02-16 10:00:00', "2023-02-16 11:00:00", 35000, 5000, 'wsb1017@naver.com', 1, 12);
INSERT INTO `live` (`live_seq`, `user_email`, `start_time`, `end_time`, `current_price`, `bid_unit`, `top_bidder`, `viewer`, `participant`) VALUES (19, 'taw4654@gmail.com', '2023-02-16 10:00:00', "2023-02-16 11:00:00", 35000, 5000, 'wsb1017@naver.com', 1, 8);
INSERT INTO `live` (`live_seq`, `user_email`, `start_time`, `end_time`, `current_price`, `bid_unit`, `top_bidder`, `viewer`, `participant`) VALUES (23, 'taw4654@gmail.com', '2023-02-16 10:00:00', "2023-02-16 11:00:00", 35000, 5000, 'wsb1017@naver.com', 1, 7);





