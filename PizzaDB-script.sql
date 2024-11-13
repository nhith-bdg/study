-- Dashboard 1
SELECT
	o.order_id,
    i.item_price,
    o.quantity,
    (SELECT AVG(i.item_price) 
		FROM Orders o
		LEFT JOIN Items i USING (item_id)
		WHERE row_id = o.row_id) AS Average_order_value,
    i.item_category,
    i.item_name,
    o.created_at,
    a.delivery_address1,
    a.delivery_address2,
    a.delivery_city,
    a.delivery_zipcode,
    o.delivery
FROM Orders o
LEFT JOIN Items i USING (item_id)
LEFT JOIN Address a USING (add_id);


-- Dashboard 2
SELECT
	s1.item_name,
    s1.ing_id,
    s1.ing_name,
    s1.ing_weight,
    s1.ing_price,
    s1.order_quantity,
    s1.recipe_quantity,
    s1.order_quantity * s1.recipe_quantity AS ordered_weight,
    s1.ing_price / s1.ing_weight as unit_cost,
    (s1.order_quantity * s1.recipe_quantity) / (s1.ing_price / s1.ing_weight) AS ingredient_cost
FROM (SELECT
		o.item_id,
		i.item_sku,
		i.item_name,
		r.ing_id,
		ing.ing_name,	
		r.quantity AS recipe_quantity,
		SUM(o.quantity) AS order_quantity,
		ing.ing_weight,
		ing.ing_price
	FROM Orders o
	LEFT JOIN Items i USING (item_id)
	LEFT JOIN Recipe r ON r.recipe_id = i.item_sku
	LEFT JOIN ingredients ing USING (ing_id)
	GROUP BY o.item_id, i.item_sku, i.item_name, r.ing_id, r.quantity, ing.ing_name, ing.ing_weight, ing.ing_price) s1
;

-- total weight ordered
-- inventory amount
-- inventory remaining per ingredient
SELECT
	s2.ing_name,
    s2.ordered_weight,
    ing.ing_weight,
    inv.quantity,
    ing.ing_weight * inv.quantity AS total_inv_weight, -- total weight in stock = ingredient quantity x ingredient weight
    (ing.ing_weight * inv.quantity) - s2.ordered_weight AS remaining_weight
FROM
(SELECT
	ing_id,
    ing_name,
    sum(ordered_weight) AS ordered_weight
FROM stock1
GROUP BY ing_name, ing_id) s2
LEFT JOIN Inventory inv ON inv.item_id = s2.ing_id
LEFT JOIN Ingredients ing USING (ing_id) -- to calculate the total weight in stock
;


SELECT
	ro.date,
    s.Sta_first_name,
    s.sta_last_name,
    s.hourly_rate,
    sh.start_time,
    sh.end_time,
    ((hour(TIMEDIFF(sh.start_time, sh.end_time)))*60+(minute(TIMEDIFF(sh.start_time, sh.end_time))))/60 AS hours_in_shift,
    ((hour(TIMEDIFF(sh.start_time, sh.end_time)))*60+(minute(TIMEDIFF(sh.start_time, sh.end_time))))/60 * s.hourly_rate AS staff_cost
FROM Rotations Ro
LEFT JOIN Staff s USING (staff_id)
LEFT JOIN Shift sh USING (shift_id)









