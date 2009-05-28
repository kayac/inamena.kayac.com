CREATE TABLE keyword (
       id INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
       keyword VARCHAR(255) NOT NULL,
       created_date DATETIME NOT NULL,
       index (keyword)
) ENGINE=InnoDB;

CREATE TABLE message (
       id INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
       keyword INTEGER UNSIGNED NOT NULL, -- keyword.id
       message TEXT NOT NULL,
       created_date DATETIME NOT NULL,
       index (keyword)
) ENGINE=InnoDB;

