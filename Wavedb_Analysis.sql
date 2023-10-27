USE wave;

-- Question 1
-- How many agent_transactions did we have in the months of 2022 (broken down by months)?
SELECT MONTH(when_created) month_num, MONTHNAME(when_created) months, COUNT(*) num_of_atx
FROM agent_transactions
GROUP BY month_num, months
ORDER BY month_num;



-- Question 2
-- Over the course of the first half of 2022, how many Wave agents were "net depositors" vs. "net withdrawers"?
SELECT agent_id, SUM(amount) total_amount,
CASE
	WHEN SUM(amount) > 0 THEN 'net withdrawers'
    ELSE 'net depositors'
END agent_type
FROM agent_transactions
WHERE MONTHNAME(when_created) IN ('January', 'February', 'March', 'April', 'May', 'June')
GROUP BY agent_id
ORDER BY total_amount;


-- Question 3
-- Build an "atx volume city summary" table: find the volume of agent transactions created in the first half of 2022, grouped by city. You can determine the city where the agent transaction took place from the agent's city field.
SELECT agent_id, city, sum(amount) atx_volume
FROM agent_transactions atx
JOIN agents USING (agent_id)
WHERE DATE(atx.when_created) < '2022-07-01'
GROUP BY agent_id, city
ORDER BY agent_id;


-- Question 4
-- Now separate the atx volume by country as well (so your columns should be country, city, volume)
SELECT agent_id, country, city, sum(amount) atx_volume
FROM agent_transactions atx
LEFT JOIN agents USING (agent_id)
WHERE DATE(atx.when_created) < '2022-07-01'
GROUP BY agent_id, country, city
ORDER BY country;


-- Question 5
-- Build a "send volume by country and kind" table: find the total volumne of transfers (by send_amount_scalar) sent in the first half of 2022, grouped by coutry and transfer kind.
SELECT ledger_location as country, kind as transfer_kind, sum(send_amount_scalar) as send_volume
FROM transfers trns
LEFT JOIN wallets
	ON trns.source_wallet_id = wallets.wallet_id
WHERE DATE(trns.when_created) < '2022-07-01'
GROUP BY country, transfer_kind
ORDER BY country;


-- Question 6
-- Then add columns for transaction count and number of unique senders (still broken down by country and transfer kind)
SELECT ledger_location as country,
	kind as transfer_kind,
	sum(send_amount_scalar) as send_volume,
    count(transfer_id) as num_of_transactions,
    count(distinct(u_id)) as unique_senders
FROM transfers trns
LEFT JOIN wallets
	ON trns.source_wallet_id = wallets.wallet_id
WHERE DATE(trns.when_created) < '2022-07-01'
GROUP BY country, kind;




-- Question 7
-- Finally, which wallets sent more than 1,000,000 CFA in transfers in the first quarter (as identified by the source_wallet_id column on the trasfers table), and how much did they send?
SELECT source_wallet_id as wallet_id, send_amount_currency as currency, send_amount_scalar as amount
FROM transfers
WHERE DATE(when_created) < '2022-04-01'
	AND send_amount_scalar >= 1000000
    AND send_amount_currency = 'CFA';
    
