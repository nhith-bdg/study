-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/pzL8pG
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE DATABASE island_rooster;
USE island_rooster;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS recipe;
DROP TABLE IF EXISTS rota;
DROP TABLE IF EXISTS shift;
DROP TABLE IF EXISTS staff;

CREATE TABLE `orders` (
    `row_id` int  NOT NULL ,
    `order_id` varchar(10)  NOT NULL ,
    `created_at` datetime  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    `cust_id` int  NOT NULL ,
    `delivery` boolean  NOT NULL ,
    `add_id` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`, `created_at`
    )
);

CREATE TABLE `customers` (
    `cust_id` int  NOT NULL ,
    `cust_firstname` varchar(50)  NOT NULL ,
    `cust_lastname` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `cust_id`
    )
);

CREATE TABLE `address` (
    `add_id` int  NOT NULL ,
    `delivery_address1` varchar(200)  NOT NULL ,
    `delivery_address2` varchar(200)  NULL ,
    `delivery_city` varchar(50)  NOT NULL ,
    `delivery_zipcode` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `add_id`
    )
);

CREATE TABLE `item` (
    `item_id` varchar(10)  NOT NULL ,
    `sku` varchar(20)  NOT NULL ,
    `item_name` varchar(100)  NOT NULL ,
    `item_cat` varchar(100)  NOT NULL ,
    `item_size` varchar(10)  NOT NULL ,
    `item_price` decimal(10,2)  NOT NULL ,
    PRIMARY KEY (
        `item_id`
    )
);

CREATE TABLE `ingredient` (
    `ing_id` varchar(10)  NOT NULL ,
    `ing_name` varchar(200)  NOT NULL ,
    `ing_weight` int  NOT NULL ,
    `ing_meas` varchar(20)  NOT NULL ,
    `ing_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `ing_id`
    )
);

CREATE TABLE `recipe` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(20)  NOT NULL ,
    `ing_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `inventory` (
    `inv_id` int  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inv_id`
    )
);

CREATE TABLE `staff` (
    `staff_id` varchar(20)  NOT NULL ,
    `first_name` varchar(50)  NOT NULL ,
    `last_name` varchar(50)  NOT NULL ,
    `position` varchar(100)  NOT NULL ,
    `hourly_rate` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

CREATE TABLE `shift` (
    `shift_id` varchar(20)  NOT NULL ,
    `day_of_week` varchar(10)  NOT NULL ,
    `start_time` time  NOT NULL ,
    `end_time` time  NOT NULL ,
    PRIMARY KEY (
        `shift_id`
    )
);

CREATE TABLE `rota` (
    `row_id` int  NOT NULL ,
    `rota_id` varchar(20)  NOT NULL ,
    `date` datetime  NOT NULL ,
    `shift_id` varchar(20)  NOT NULL ,
    `staff_id` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);


ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_item_id` FOREIGN KEY(`item_id`)
REFERENCES `item` (`item_id`);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_cust_id` FOREIGN KEY(`cust_id`)
REFERENCES `customers` (`cust_id`);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_add_id` FOREIGN KEY(`add_id`)
REFERENCES `address` (`add_id`);

ALTER TABLE recipe ADD CONSTRAINT FK_recipe_ing_id FOREIGN KEY (ing_id) 
REFERENCES ingredient(ing_id);
-- ALTER TABLE `recipe` ADD CONSTRAINT `fk_recipe_ing_id` FOREIGN KEY(`ing_id`) REFERENCES `ingredient` (`ing_id`);

ALTER TABLE `inventory` ADD CONSTRAINT `fk_inventory_item_id` FOREIGN KEY(`item_id`)
REFERENCES `recipe` (`ing_id`);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `staff` (`staff_id`);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `shift` (`shift_id`);


ALTER TABLE item RENAME COLUMN sku to recipe_id; -- rename sku to recipe_id because I got the error 1061
CREATE UNIQUE INDEX recipe_recipe_id_uniq ON item(recipe_id); -- to solve the error 1822 because there is no primary key with recipe_id column
ALTER TABLE `recipe` ADD CONSTRAINT `fk_recipe_recipe_id` FOREIGN KEY(`recipe_id`) 
REFERENCES `item` (`recipe_id`);

CREATE UNIQUE INDEX rota_date_uniq ON orders(created_at); -- to solve the error 1822 because there is no primary key with date/created_at column
ALTER TABLE rota ADD CONSTRAINT FK_rota_date FOREIGN KEY (date) 
REFERENCES orders(created_at);
-- ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_date` FOREIGN KEY(`date`) REFERENCES `orders` (`created_at`);




SET foreign_key_checks = 0;
SHOW KEYS FROM island_rooster.inventory;
SHOW KEYS FROM island_rooster.item;




