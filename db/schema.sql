-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'products'
---- ---

-- DROP TABLE IF EXISTS `products`;

-- CREATE TABLE `products` (
--   `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
--   `name` VARCHAR NULL DEFAULT NULL,
--   `slogan` VARCHAR NULL DEFAULT NULL,
--   `description` VARCHAR NULL DEFAULT NULL,
--   `category_id` INTEGER NULL DEFAULT NULL,
--   `default_price` INTEGER NULL DEFAULT NULL,
--   `features_id` INTEGER NULL DEFAULT NULL,
--   `created_at` TIMESTAMP NULL DEFAULT NULL,
--   `updated_at` TIMESTAMP NULL DEFAULT NULL,
--   PRIMARY KEY (`id`)
-- );

-- \c products_api

DROP TABLE IF EXISTS Products CASCADE;

CREATE TABLE Products (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  product_name VARCHAR(255) NULL DEFAULT NULL,
  slogan VARCHAR(255) NULL DEFAULT NULL,
  product_description TEXT NULL DEFAULT NULL,
  category_id VARCHAR(255) NULL DEFAULT NULL,
  default_price INTEGER NULL DEFAULT NULL
);


-- ---
-- Table 'styles'
--
-- ---

DROP TABLE IF EXISTS Styles CASCADE;

CREATE TABLE Styles (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  product_id INTEGER REFERENCES Products(id),
  style_name VARCHAR(1024) NULL DEFAULT NULL,
  sale_price VARCHAR(1024) NULL DEFAULT NULL,
  original_price VARCHAR(1024) NULL DEFAULT NULL,
  default_style BOOLEAN
);


-- DROP TABLE IF EXISTS `styles`;

-- CREATE TABLE `styles` (
--   `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
--   `product_id` INTEGER NULL DEFAULT NULL,
--   `name` VARCHAR NULL DEFAULT NULL,
--   `original_price` INTEGER NULL DEFAULT NULL,
--   `sale_price` INTEGER NULL DEFAULT NULL,
--   default_style BOOLEAN,
--   PRIMARY KEY (`id`)
-- );

-- ---
-- Table 'skus'
--
-- ---

DROP TABLE IF EXISTS Skus CASCADE;

CREATE TABLE Skus (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  styles_id INTEGER REFERENCES Styles(id),
  size VARCHAR(255) NULL DEFAULT NULL,
  quantity INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'category'
--
-- ---

-- DROP TABLE IF EXISTS Categories CASCADE;

-- CREATE TABLE Categories (
--   id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
--   category_name VARCHAR(255) NULL DEFAULT NULL
-- );

-- ---
-- Table 'features'
--
-- ---

DROP TABLE IF EXISTS Features CASCADE;

CREATE TABLE Features (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  product_id INTEGER REFERENCES Products(id),
  feature VARCHAR(255) NULL DEFAULT NULL,
  feature_value VARCHAR(255) NULL DEFAULT NULL
);

-- ---
-- Table 'photos'
--
-- ---

DROP TABLE IF EXISTS Photos CASCADE;

CREATE TABLE Photos (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  styles_id INTEGER REFERENCES Styles(id),
  photo_url TEXT NULL DEFAULT NULL,
  thumbnail_url TEXT NULL DEFAULT NULL
);

-- ---
-- Table 'related_products'
--
-- ---

DROP TABLE IF EXISTS Related CASCADE;

CREATE TABLE Related (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  current_product_id INTEGER REFERENCES Products(id),
  related_product_id INTEGER REFERENCES Products(id)
);

-- ---
-- Table 'reviews'
--
-- ---

-- DROP TABLE IF EXISTS Reviews CASCADE;

-- CREATE TABLE Reviews (
--   id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
--   product_id INTEGER REFERENCES Products(id),
--   reviews_list SET NULL DEFAULT NULL,
--   meta SET NULL DEFAULT NULL
-- );

-- ---
-- Table 'questions'
--
-- ---

-- DROP TABLE IF EXISTS Questions CASCADE;

-- CREATE TABLE Questions (
--   id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
--   product_id INTEGER REFERENCES Products(id),
--   question VARCHAR(255) NULL DEFAULT NULL,
--   answer VARCHAR(255) NULL DEFAULT NULL
-- );
-- ---
-- Table Properties
-- ---

-- ALTER TABLE `products` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `styles` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `skus` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `features` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `photos` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `related_products` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `reviews` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `questions` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `products` (`id`,`name`,`slogan`,`description`,`category_id`,`default_price`,`features_id`,`created_at`,`updated_at`) VALUES
-- ('','','','','','','','','');
-- INSERT INTO `styles` (`id`,`product_id`,`name`,`original_price`,`sale_price`,`default?`) VALUES
-- ('','','','','','');
-- INSERT INTO `skus` (`id`,`quantity`,`size`,`styles_id`) VALUES
-- ('','','','');
-- INSERT INTO `category` (`id`,`name`) VALUES
-- ('','');
-- INSERT INTO `features` (`id`,`feature`,`value`) VALUES
-- ('','','');
-- INSERT INTO `photos` (`id`,`styles_id`,`thumbnail_url`,`url`) VALUES
-- ('','','','');
-- INSERT INTO `related_products` (`id`,`product_id`,`related_product_id`) VALUES
-- ('','','');
-- INSERT INTO `reviews` (`id`,`product_id`,`reviews_list`,`meta`) VALUES
-- ('','','','');
-- INSERT INTO `questions` (`id`,`product_id`,`question`,`answer`) VALUES
-- ('','','','');