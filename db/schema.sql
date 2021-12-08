-- ---
-- Globals
-- ---

-- \c products_api

-- VARCHAR might take up too much space.
DROP TABLE IF EXISTS Products CASCADE;

CREATE TABLE Products (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  product_name VARCHAR(255) NULL DEFAULT NULL,
  slogan VARCHAR(255) NULL DEFAULT NULL,
  product_description TEXT NULL DEFAULT NULL,
  category_id VARCHAR(255) NULL DEFAULT NULL,
  default_price INTEGER NULL DEFAULT NULL
);


DROP TABLE IF EXISTS Styles CASCADE;

CREATE TABLE Styles (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  product_id INTEGER REFERENCES Products(id),
  style_name VARCHAR(1024) NULL DEFAULT NULL,
  sale_price VARCHAR(1024) NULL DEFAULT NULL,
  original_price VARCHAR(1024) NULL DEFAULT NULL,
  default_style BOOLEAN
);


DROP TABLE IF EXISTS Skus CASCADE;

CREATE TABLE Skus (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  styles_id INTEGER REFERENCES Styles(id),
  size VARCHAR(255) NULL DEFAULT NULL,
  quantity INTEGER NULL DEFAULT NULL
);



DROP TABLE IF EXISTS Features CASCADE;

CREATE TABLE Features (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  product_id INTEGER REFERENCES Products(id),
  feature VARCHAR(255) NULL DEFAULT NULL,
  feature_value VARCHAR(255) NULL DEFAULT NULL
);


DROP TABLE IF EXISTS Photos CASCADE;

CREATE TABLE Photos (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  styles_id INTEGER REFERENCES Styles(id),
  photo_url TEXT NULL DEFAULT NULL,
  thumbnail_url TEXT NULL DEFAULT NULL
);


DROP TABLE IF EXISTS Related CASCADE;

CREATE TABLE Related (
  id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
  current_product_id INTEGER REFERENCES Products(id),
  related_product_id INTEGER REFERENCES Products(id)
);


CREATE INDEX id_idx ON Products (id);
CREATE INDEX id2_idx ON Styles (id);
CREATE INDEX product_id_idx ON Styles (product_id);
CREATE INDEX photos_id_idx ON PHOTOS (styles_id);
CREATE INDEX current_product_id_idx ON Related (current_product_id);
CREATE INDEX skus_id_idx ON Skus (styles_id);
CREATE INDEX features_product_idx ON Features (product_id);
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