CREATE TABLE `aas_callservices`
(
`id` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
`userId` VARCHAR(128),
`name` VARCHAR(128),
`idType` INTEGER,
`contactNumber` VARCHAR(128),
`carMake` VARCHAR(128),
`carModel` VARCHAR(128),
`carColor` VARCHAR(128),
`carNumber` VARCHAR(128),
`address` TEXT,
`NOTE` TEXT,
`lat` FLOAT,
`lng` FLOAT,
`submit_time` DATETIME,
`comment` TEXT,
`status` INTEGER,
`rec_id` VARCHAR(128)
) ENGINE = InnoDB;