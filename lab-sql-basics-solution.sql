use bank;

## 1. QUERY 1 - Get the id values of the first 5 clients from district_id with a value equals to 1.
select * from client;
select * from client where district_id = "1" limit 5;

## 2. QUERY 2 - In the client table, get an id value of the last client where the district_id equals to 72.
select * from client;
select max(client_id) as last_client from client where district_id = 72;

## 3. QUERY 3 - Get the 3 lowest amounts in the loan table.
select * from loan;
select amount from loan order by amount asc limit 3;

## 4. QUERY 4 - What are the possible values for status, ordered alphabetically in ascending order in the loan table?
select distinct(status) from loan order by status asc;

## 5. QUERY 5 - What is the loan_id of the highest payment received in the loan table?
select * from loan order by payments asc limit 1;

## 6. QUERY 6 - What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
select account_id, amount from loan order by account_id limit 5;

## 7. QUERY 7 - What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
select account_id from loan where duration = "60" order by amount asc;

## 8. QUERY 8 - What are the unique values of k_symbol in the order table?
select * from bank.order;
select distinct(k_symbol) from bank.order order by k_symbol;

## 9. QUERY 9 - In the order table, what are the order_ids of the client with the account_id 34?
select order_id from bank.order where account_id = "34";

## 10. QUERY 10 - In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
select distinct(account_id) from bank.order where order_id between '29540' and '29560';

## 11. QUERY 11 - In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
 select distinct(amount) from bank.order where account_to = '30067122';

## 12. QUERY 12 - In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 
## in chronological order, from newest to oldest.
select * from trans;
select trans_id, date, type, amount from trans where account_id = '793' order by date desc limit 10;

## 13. QUERY 13 - In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? 
## Show the results sorted by the district_id in ascending order.
select * from client;
select district_id, count(*) as num_clients 
from client 
where district_id < 10 
group by district_id 
order by district_id asc;

## 14. QUERY 14 - In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
select * from card;
select type, count(*) as num_cards from card group by type order by num_cards desc;

## 15. QUERY 15 - Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
select * from loan;
select account_id, sum(amount) as total_loan_amount from loan group by account_id order by total_loan_amount desc limit 10;

## 16. QUERY 16 - In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.
select 
  date as loan_date, count(*) as number_of_loans from loan where date < '930907' group by loan_date order by loan_date desc;

## 17. QUERY 17 - In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, 
## ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.
select date, duration, count(amount) as number_of_loans
from loan
group by
date, duration
order by date asc, duration asc, number_of_loans asc ;

## 18. QUERY 18 - In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming).
## Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.
select account_id, type, sum(amount) as total_amount
from trans
where account_id = 396
group by account_id, type
order by type;

## 19. QUERY 19 - From the previous output, translate the values for type to English, rename the column to transaction_type,
## round total_amount down to an integer
select 
    account_id, 
    case 
        when type = 'VYDAJ' then 'Outgoing' 
        when type = 'PRIJEM' then 'Incoming' 
    end as transaction_type, 
    round(sum(amount), 0) as total_amount
from trans
where account_id = 396
group by account_id, type
order by transaction_type;

## 20. QUERY 20 - From the previous result, modify your query so that it returns only one row, 
## with a column for incoming amount, outgoing amount and the difference.
select 
    account_id, 
    case 
        when type = 'VYDAJ' then 'Outgoing' 
        when type = 'PRIJEM' then 'Incoming' 
    end as transaction_type, 
    round(sum(amount), 0) as total_amount
from trans
where account_id = 396
group by account_id, type
order by transaction_type;

## 21. QUERY 21 - Continuing with the previous example, rank the top 10 account_ids based on their difference.
SELECT 
    account_id, 
    SUM(amount) - balance, 0) AS total_amount_difference
FROM trans
GROUP BY account_id
ORDER BY total_amount_difference
LIMIT 10;
 