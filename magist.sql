


/*2. Answer business questions

Whenever you feel ready for it, go through the questions below. Note that in many cases, you will have to translate business terms into tables, columns and aggregations. Whenever needed, make your own educated guesses or assumptions (e.g. what can be considered a “tech” or an “expensive” product).

-- 2.1. In relation to the products:

-- 1. What categories of tech products does Magist have?
-- 2. How many products of these tech categories have been sold (within the time window of the database snapshot)? What percentage does that represent from the overall number of products sold?
-- 3. What’s the average price of the products being sold?
-- 4. Are expensive tech products popular? *
--  TIP: Look at the function CASE WHEN to accomplish this task.

-- 2.2. In relation to the sellers:

-- 1. How many months of data are included in the magist database?
-- 2. How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?
-- 3. What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?
-- 4. Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?

2.3. In relation to the delivery time:

-- 1. What’s the average time between the order being placed and the product being delivered?
-- 2. Is there any pattern for delayed orders, e.g. big products being delayed more often?*/

USE magist;

-- 1. What categories of tech products does Magist have? 
SELECT distinct product_category_name_english
FROM product_category_name_translation
ORDER BY product_category_name_english;


-- audio, electronics, computers, computer_accessories, consoles_games, pc_gamer, Telephony, tablets_printing_image, 
-- audio
-- "cine_foto", "climatizacao", "consoles_games", "eletronicos",
-- "eletrodomesticos", "eletrodomesticos_2", "eletroportateis", "informatica_acessorios",
-- "pc_gamer", "pcs", "portateis_casa_forno_e_cafe", "portateis_cozinha_e_preparadores_de_alimentos", "tablets_impressao_imagem", "telefonia", "telefonia_fixa"

-- 2. How many products of these tech categories have been sold (within the time window of the database snapshot)? 
-- What percentage does that represent from the overall number of products sold? 17.17%%

SELECT COUNT(oi.product_id) AS total_tech_sales, (SELECT COUNT(*) FROM order_items) AS total_sales,
ROUND((Count(oi.product_id) / (SELECT COUNT(*) FROM order_items)) * 100, 2) AS percentage_tech_sales
FROM order_items AS oi
JOIN products AS p USING(product_id)
WHERE p.product_category_name IN ("audio", "cine_foto", "climatizacao", "consoles_games", "eletronicos", "eletrodomesticos", "eletrodomesticos_2", "eletroportateis", "informatica_acessorios",
"pc_gamer", "pcs", "portateis_casa_forno_e_cafe", "portateis_cozinha_e_preparadores_de_alimentos", "tablets_impressao_imagem", "telefonia", "telefonia_fixa");




SELECT
  COUNT(oi.order_item_id) AS tech_products_sold,
  (SELECT COUNT(*) FROM order_items) AS total_products_sold,
  ROUND(COUNT(oi.order_item_id) * 100.0 / (SELECT COUNT(*) FROM order_items), 2) AS pct_tech
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
WHERE p.product_category_name IN (
  'audio',
  'cine_foto',
  'climatizacao',
  'consoles_games',
  'eletronicos',
  'eletrodomesticos',
  'eletrodomesticos_2',
  'eletroportateis',
  'informatica_acessorios',
  'pc_gamer',
  'pcs',
  'portateis_casa_forno_e_cafe',
  'portateis_cozinha_e_preparadores_de_alimentos',
  'tablets_impressao_imagem',
  'telefonia',
  'telefonia_fixa';


-- 3. What’s the average price of the products being sold? 119,98
SELECT ROUND(AVG(price), 2)
FROM order_items;

SELECT ROUND(AVG(oi.price), 2) AS avg_price
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

-- Alternative

SELECT 
  ROUND(AVG(oi.price), 2) AS avg_price,
  ROUND(MIN(oi.price), 2) AS min_price,
  ROUND(MAX(oi.price), 2) AS max_price
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


-- 4. Are expensive tech products popular? NEIN  % Prozent sind verkauft worden die günstigen 0.94% 

SELECT 
CASE	WHEN oi.price >= 119.98 THEN "Teuer (>=119.98)"
		ELSE "Guenstig (<119.98)"
END AS price_category,
	COUNT(oi.product_id) AS total_tech_sales, (SELECT COUNT(*) FROM order_items) AS total_sales, 
	ROUND((Count(oi.product_id) / (SELECT COUNT(*) FROM order_items)) * 100, 2) AS percentage_tech_sales
FROM order_items AS oi
JOIN products AS p USING(product_id)
WHERE product_category_name IN ("audio", "cine_foto", "climatizacao", "consoles_games", "eletronicos", "eletrodomesticos", "eletrodomesticos_2", "eletroportateis", "informatica_acessorios",
"pc_gamer", "pcs", "portateis_casa_forno_e_cafe", "portateis_cozinha_e_preparadores_de_alimentos", "tablets_impressao_imagem", "telefonia", "telefonia_fixa")

GROUP BY price_category; 



SELECT
    CASE
        WHEN oi.price >= 119.98 THEN 'Expensive'
        ELSE 'Not expensive'
    END AS price_category,
    COUNT(*) AS sold_products,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_category_name IN (
    'audio',
  'cine_foto',
  'climatizacao',
  'consoles_games',
  'eletronicos',
  'eletrodomesticos',
  'eletrodomesticos_2',
  'eletroportateis',
  'informatica_acessorios',
  'pc_gamer',
  'pcs',
  'portateis_casa_forno_e_cafe',
  'portateis_cozinha_e_preparadores_de_alimentos',
  'tablets_impressao_imagem',
  'telefonia',
  'telefonia_fixa'
)
GROUP BY
    CASE
        WHEN oi.price >= 119.98 THEN 'Expensive'
        ELSE 'Not expensive'
    END;


-- 2.2. In relation to the sellers:

-- 1. How many months of data are included in the magist database? 25 Monate
SELECT timestampdiff(MONTH, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp)) AS months_count,
MIN(order_purchase_timestamp) AS earliest_order,
MAX(order_purchase_timestamp) AS latest_order
FROM orders;

-- 2. How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers? 109, 48,79% , 638, 

SELECT COUNT(DISTINCT oi.seller_id) AS total_tech_seller, (SELECT COUNT(DISTINCT oi.seller_id) AS tech_sellers, 
ROUND((Count(oi.seller_id) * 100 / (SELECT COUNT(*) FROM sellers)), 2) AS percentage_tech_seller
FROM sellers AS s
JOIN products AS p USING(product_id)
WHERE product_category_name IN ("audio", "cine_foto", "climatizacao", "consoles_games", "eletronicos", "eletrodomesticos", "eletrodomesticos_2", "eletroportateis", "informatica_acessorios",
"pc_gamer", "pcs", "portateis_casa_forno_e_cafe", "portateis_cozinha_e_preparadores_de_alimentos", "tablets_impressao_imagem", "telefonia", "telefonia_fixa");



SELECT 
COUNT(seller_id)
FROM
sellers;

-------
SELECT
  (SELECT COUNT(*) FROM sellers) AS total_sellers,
  COUNT(DISTINCT oi.seller_id) AS tech_sellers,
  ROUND(COUNT(DISTINCT oi.seller_id) * 100.0 / (SELECT COUNT(*) FROM sellers), 2) AS pct_tech_sellers
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
WHERE p.product_category_name IN (
  'audio','cine_foto','climatizacao','consoles_games','eletronicos',
  'eletrodomesticos','eletrodomesticos_2','eletroportateis',
  'informatica_acessorios','pc_gamer','pcs',
  'portateis_casa_forno_e_cafe','portateis_cozinha_e_preparadores_de_alimentos',
  'tablets_impressao_imagem','telefonia','telefonia_fixa'
);


-- 3. What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?
SELECT ROUND(SUM(price), 2) 
FROM order_items as oi
JOIN orders as o USING(order_id);

SELECT 
    ROUND(SUM(price), 2) AS total_earnings
FROM order_items;

SELECT 
    ROUND(SUM(oi.price), 2) AS Gesamtverdienst,
    ROUND(SUM(CASE
                WHEN
                    p.product_category_name IN ('audio' , 'cine_foto',
                        'consoles_games',
                        'eletronicos',
                        'eletrodomesticos',
                        'eletrodomesticos_2',
                        'eletroportateis',
                        'informatica_acessorios',
                        'pc_gamer',
                        'pcs',
                        'portateis_casa_forno_e_cafe',
                        'portateis_cozinha_e_preparadores_de_alimentos',
                        'tablets_impressao_imagem',
                        'telefonia',
                        'telefonia_fixa')
                THEN
                    oi.price
                ELSE 0
            END),
            2) AS Tech_Gesamtverdienst
FROM
    order_items oi
        JOIN
    products p ON oi.product_id = p.product_id;

SELECT 
  ROUND(SUM(oi.price), 2) AS total_earned_all
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered' AND product_category_name IN (
  'audio','cine_foto','climatizacao','consoles_games','eletronicos',
  'eletrodomesticos','eletrodomesticos_2','eletroportateis',
  'informatica_acessorios','pc_gamer','pcs',
  'portateis_casa_forno_e_cafe','portateis_cozinha_e_preparadores_de_alimentos',
  'tablets_impressao_imagem','telefonia','telefonia_fixa') ;




-- 4. Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?
SELECT ROUND(SUM(price), 2) / 25 as avg_income_all 
FROM order_items;

SELECT (SELECT ROUND(SUM(price), 2) / 25 FROM order_items) AS avg_income_all,
ROUND(SUM(oi.price), 2) / 25 as avg_income_tech 
FROM order_items AS oi
JOIN products AS p USING(product_id)
JOIN product_category_name_translation AS t USING(product_category_name)
WHERE t.product_category_name IN ("audio", "cine_foto", "climatizacao", "consoles_games", "eletronicos", "eletrodomesticos", "eletrodomesticos_2", "eletroportateis", "informatica_acessorios",
"pc_gamer", "pcs", "portateis_casa_forno_e_cafe", "portateis_cozinha_e_preparadores_de_alimentos", "tablets_impressao_imagem", "telefonia", "telefonia_fixa");

-- Taris

SELECT 
    ROUND(SUM(oi.price) / COUNT(DISTINCT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')),
            2) AS average_monthly_income,
    ROUND(SUM(CASE
                WHEN
                    p.product_category_name IN ('audio' , 'cine_foto',
                        'climatizacao',
                        'consoles_games',
                        'eletronicos',
                        'eletrodomesticos',
                        'eletrodomesticos_2',
                        'eletroportateis',
                        'informatica_acessorios',
                        'pc_gamer',
                        'pcs',
                        'portateis_casa_forno_e_cafe',
                        'portateis_cozinha_e_preparadores_de_alimentos',
                        'tablets_impressao_imagem',
                        'telefonia',
                        'telefonia_fixa')
                THEN
                    oi.price
                ELSE 0
            END) / COUNT(DISTINCT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')),
            2) AS average_monthly_tech_income
FROM
    order_items oi
        JOIN
    orders o ON oi.order_id = o.order_id
        JOIN
    products p ON oi.product_id = p.product_id;


-- Miguel
WITH monthly_all AS (
  SELECT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month, SUM(oi.price) AS income
  FROM order_items oi JOIN orders o ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY month
),
monthly_tech AS (
  SELECT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month, SUM(oi.price) AS income
  FROM order_items oi
  JOIN products p ON p.product_id = oi.product_id
  JOIN orders o ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered'
  AND p.product_category_name IN (
    'audio','cine_foto','climatizacao','consoles_games','eletronicos','eletrodomesticos','eletrodomesticos_2','eletroportateis','informatica_acessorios','pc_gamer','pcs','portateis_casa_forno_e_cafe','portateis_cozinha_e_preparadores_de_alimentos','tablets_impressao_imagem','telefonia','telefonia_fixa'
  )
  GROUP BY month
)

SELECT
  ROUND((SELECT AVG(income) FROM monthly_all),2) AS avg_monthly_all_sellers,
  ROUND((SELECT AVG(income) FROM monthly_tech),2) AS avg_monthly_tech_sellers;


-- 2.3. In relation to the delivery time:

-- 1. What’s the average time between the order being placed and the product being delivered?
SELECT DATEdiff( order_estimated_delivery_date, order_purchase_timestamp) as delivery_time
FROM orders
ORDER BY delivery_time DESC;

SELECT avg(DATEdiff( order_estimated_delivery_date, order_purchase_timestamp)) AS avg_delivery_time
FROM orders; -- 12,5 tage für alle produkte -- 14 Tage für techprodukte 

SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))
FROM orders
WHERE   p.product_category_name IN (
    'audio','cine_foto','climatizacao','consoles_games','eletronicos','eletrodomesticos','eletrodomesticos_2','eletroportateis','informatica_acessorios','pc_gamer','pcs','portateis_casa_forno_e_cafe','portateis_cozinha_e_preparadores_de_alimentos','tablets_impressao_imagem','telefonia','telefonia_fixa'
  )

SELECT 
    t.product_category_name_english AS category,
    ROUND(AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)), 2) AS avg_days_to_deliver,
    COUNT(*) AS total_orders
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND p.product_category_name IN (
    'audio',
    'cine_foto',
    'climatizacao',
    'consoles_games',
    'eletronicos',
    'eletrodomesticos',
    'eletrodomesticos_2',
    'eletroportateis',
    'informatica_acessorios',
    'pc_gamer',
    'pcs',
    'portateis_casa_forno_e_cafe',
    'portateis_cozinha_e_preparadores_de_alimentos',
    'tablets_impressao_imagem',
    'telefonia',
    'telefonia_fixa'
  )
GROUP BY t.product_category_name_english
ORDER BY avg_days_to_deliver DESC;

-- 2. Is there any pattern for delayed orders, e.g. big products being delayed more often?*/
SELECT DATEDIFF(o.order_estimated_delivery_date, o.order_delivered_customer_date) as delivery_delay
FROM orders as o 
JOIN order_items as oi Using(order_id)
JOIN products as p USING(product_id)
WHERE product_weight_g > 2277 
ORDER BY delivery_delay DESC;
-- FAZIT delays haben nichts mit gewicht zu tun

SELECT DATEDIFF(o.order_estimated_delivery_date, o.order_delivered_customer_date) as delivery_delay
FROM orders as o 
JOIN order_items as oi Using(order_id)
JOIN products as p USING(product_id)
WHERE product_height_cm < 16.94
ORDER BY delivery_delay DESC;



SELECT ROUND(avg(product_height_cm), 2)
FROM products;

SELECT ROUND(avg(product_weight_g), 2)
FROM products;

SELECT MAX(product_weight_g) as maximum, MIN(product_weight_g) as MIN
FROM products;


SELECT
    CASE 
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) >= 100 THEN "> 100 day Delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) >= 7 AND DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) < 100 THEN "1 week to 100 day delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) > 3 AND DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) < 7 THEN "4-7 day delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) >= 1  AND DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) <= 3 THEN "1-3 day delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) > 0  AND DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) < 1 THEN "less than 1 day delay"
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) <= 0 THEN 'On time' 
    END AS "delay_range", 
    AVG(product_weight_g) AS weight_avg,
    MAX(product_weight_g) AS max_weight,
    MIN(product_weight_g) AS min_weight,
    SUM(product_weight_g) AS sum_weight,
    COUNT(DISTINCT a.order_id) AS orders_count
FROM orders a
LEFT JOIN order_items b
    USING (order_id)
LEFT JOIN products c
    USING (product_id)
WHERE order_estimated_delivery_date IS NOT NULL
AND order_delivered_customer_date IS NOT NULL
AND order_status = 'delivered'
GROUP BY delay_range;



SELECT
	CASE
        WHEN p.product_weight_g < 1000 THEN 'Klein (< 1 kg)'
        WHEN p.product_weight_g < 5000 THEN 'Mittel (1–5 kg)'
        ELSE 'Groß (> 5 kg)'
    END AS product_size,

    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS late_orders,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_percentage

FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id

WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
  AND p.product_weight_g IS NOT NULL

GROUP BY
    CASE
        WHEN p.product_weight_g < 1000 THEN 'Klein (< 1 kg)'
        WHEN p.product_weight_g < 5000 THEN 'Mittel (1–5 kg)'
        ELSE 'Groß (> 5 kg)'
    END

ORDER BY product_size;



SELECT Count(order_id), Count(review_score)  -- 98371 order_id 22849 scores gleich/unter 3
FROM order_reviews								-- 75522 score größer/gleich 4
WHERE review_score >= 4;

SELECT
    CASE
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date
            THEN 'Pünktlich'
        ELSE 'Verspätet'
    END AS delivery_status,
    COUNT(*) AS number_of_reviews,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY
    CASE
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date
            THEN 'Pünktlich'
        ELSE 'Verspätet'
    END;

SELECT
  SUM(p.payment_value) AS ingresos_2017
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
 AND EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017;
