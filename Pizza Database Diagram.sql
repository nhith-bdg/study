-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/pzL8pG
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE `Orders` (
    `row_id` int  NOT NULL ,
    `order_id` varchar(10)  NOT NULL ,
    `customer_id` int  NOT NULL ,
    `created_date` date  NOT NULL ,
    `created_at` time  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    `delivery` boolean  NOT NULL ,
    `add_id` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `Customers` (
    `customer_id` int  NOT NULL ,
    `Cus_first_name` varchar(50)  NOT NULL ,
    `Cus_last_name` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `customer_id`
    )
);

CREATE TABLE `Address` (
    `add_id` int  NOT NULL ,
    `delivery_address1` varchar(200)  NOT NULL ,
    `delivery_address2` varchar(200)  NULL ,
    `delivery_city` varchar(50)  NOT NULL ,
    `delivery_zipcode` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `add_id`
    )
);

CREATE TABLE `Items` (
    `item_id` varchar(10)  NOT NULL ,
    `item_sku` varchar(20)  NOT NULL ,
    `item_name` varchar(100)  NOT NULL ,
    `item_category` varchar(100)  NOT NULL ,
    `item_size` varchar(10)  NOT NULL ,
    `item_price` decimal(10,2)  NOT NULL ,
    PRIMARY KEY (
        `item_id`
    )
);

CREATE TABLE `Ingredients` (
    `ing_id` varchar(10)  NOT NULL ,
    `ing_name` varchar(200)  NOT NULL ,
    `ing_weight` int  NOT NULL ,
    `ing_measurements` varchar(20)  NOT NULL ,
    `ing_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `ing_id`
    )
);

CREATE TABLE `Recipe` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(20)  NOT NULL ,
    `ing_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `Inventory` (
    `inv_id` int  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inv_id`
    )
);

CREATE TABLE `Staff` (
    `staff_id` varchar(20)  NOT NULL ,
    `Sta_first_name` varchar(50)  NOT NULL ,
    `Sta_last_name` varchar(50)  NOT NULL ,
    `position` varchar(100)  NOT NULL ,
    `hourly_rate` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

CREATE TABLE `Shift` (
    `shift_id` varchar(20)  NOT NULL ,
    `day_of_week` varchar(10)  NOT NULL ,
    `start_time` time  NOT NULL ,
    `end_time` time  NOT NULL ,
    PRIMARY KEY (
        `shift_id`
    )
);

CREATE TABLE `Rotations` (
    `row_id` int  NOT NULL ,
    `rota_id` varchar(20)  NOT NULL ,
    `date` date  NOT NULL ,
    `shift_id` varchar(20)  NOT NULL ,
    `staff_id` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

ALTER TABLE `Customers` ADD CONSTRAINT `fk_Customers_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `Orders` (`customer_id`);

ALTER TABLE `Address` ADD CONSTRAINT `fk_Address_add_id` FOREIGN KEY(`add_id`)
REFERENCES `Orders` (`add_id`);

ALTER TABLE `Items` ADD CONSTRAINT `fk_Items_item_id` FOREIGN KEY(`item_id`)
REFERENCES `Orders` (`item_id`);

ALTER TABLE `Ingredients` ADD CONSTRAINT `fk_Ingredients_ing_id` FOREIGN KEY(`ing_id`)
REFERENCES `Recipe` (`ing_id`);

ALTER TABLE `Recipe` ADD CONSTRAINT `fk_Recipe_recipe_id` FOREIGN KEY(`recipe_id`)
REFERENCES `Items` (`item_sku`);

ALTER TABLE `Inventory` ADD CONSTRAINT `fk_Inventory_item_id` FOREIGN KEY(`item_id`)
REFERENCES `Recipe` (`ing_id`);

ALTER TABLE `Shift` ADD CONSTRAINT `fk_Shift_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `Rotations` (`staff_id`);

ALTER TABLE `Rotations` ADD CONSTRAINT `fk_Rotations_date` FOREIGN KEY(`date`)
REFERENCES `Orders` (`created_date`);

ALTER TABLE `Rotations` ADD CONSTRAINT `fk_Rotations_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `Staff` (`staff_id`);

