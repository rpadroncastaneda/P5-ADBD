ALTER TABLE film
ADD CONSTRAINT chk_film_rental_rate CHECK (rental_rate > 0),
ADD CONSTRAINT chk_film_length CHECK (length > 0),
ADD CONSTRAINT chk_film_rating CHECK (rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17'));

ALTER TABLE payment
ADD CONSTRAINT chk_payment_amount CHECK (amount >= 0);


ALTER TABLE customer
ADD CONSTRAINT chk_customer_active CHECK (active IN (0,1)),
ADD CONSTRAINT chk_customer_email CHECK (email LIKE '%@%');

ALTER TABLE staff
ADD CONSTRAINT chk_staff_email CHECK (email LIKE '%@%');

