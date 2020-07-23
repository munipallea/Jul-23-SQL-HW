-- DROP TABLES INITIALLY

DROP TABLE IF EXISTS CardHolder CASCADE;
DROP TABLE IF EXISTS CreditCard CASCADE;
DROP TABLE IF EXISTS Merchant CASCADE;
DROP TABLE IF EXISTS MerchantCategory CASCADE;
DROP TABLE IF EXISTS Transaction_List CASCADE;


-- CREATE REQUISITE TABLES
CREATE TABLE CardHolder(
  CH_ID INTEGER PRIMARY KEY NOT NULL,
  CH_NAME VARCHAR
);

CREATE TABLE CreditCard(
  Card_NO BIGINT PRIMARY KEY NOT NULL,
	CH_ID INT NOT NULL,
	FOREIGN KEY (CH_ID) 
	REFERENCES CardHolder(CH_ID)
);

CREATE TABLE MerchantCategory(
  Merchant_ID_Category INTEGER NOT NULL PRIMARY KEY,
  MerchantCategory_Name VARCHAR NOT NULL
);

CREATE TABLE Merchant(
  Merchant_ID INTEGER PRIMARY KEY,
	Merchant_Name VARCHAR NOT NULL,
	Merchant_ID_Category INTEGER NOT NULL, 
	FOREIGN KEY (Merchant_ID_Category)  
	REFERENCES MerchantCategory(Merchant_ID_Category)
);

CREATE TABLE Transaction_List(
  Trans_id INTEGER PRIMARY KEY NOT NULL,
  Trans_Date TIMESTAMP NOT NULL,
  AMOUNT FLOAT,
	Card_NO BIGINT NOT NULL,
	FOREIGN KEY (Card_NO)  
	REFERENCES CreditCard(Card_NO),
	
	Merchant_ID INT NOT NULL,
	FOREIGN KEY (Merchant_ID)  
	REFERENCES Merchant(Merchant_ID)
);

-- Question on TRANSACTION BY CH_ID (for HVPLOT)
SELECT
	ch_id,card_no
FROM
	creditcard
WHERE
	ch_id = 2 OR
	ch_id = 18;


SELECT
	trans_date,
	amount,
	card_no(transaction_list),
	merchant_id
FROM
	transaction_list
WHERE
	card_no IN (
		SELECT
			card_no
		FROM
			creditcard
		WHERE
			ch_id = 2 OR
		    ch_id=18
	);

-- SIMPLE QUERY FOR UNIQUE CH_ID numbers

SELECT
   DISTINCT ch_id
FROM
   creditcard;
   
-- ALTER TRANSACION TABLE FOR TIMESTAMP
ALTER TABLE transaction_list
ALTER COLUMN trans_date TYPE TIMESTAMP;

-- QUESTION ON VIEWS FOR SMALL TRANSACTIONS. THREE VIEWS ARE CREATED
-- VIEW 1 GROUPING BY MERCHANT ID
CREATE VIEW merchant_small_transactions AS
	SELECT
		merchant_id,
		COUNT (amount)
	FROM
		transaction_list
	WHERE
		amount < 2
	GROUP BY
		merchant_id
	ORDER BY
		   COUNT(amount) DESC;

-- VIEW 2 GROUPING BY CARD NUMBERS

CREATE VIEW card_small_transactions AS
	SELECT
		card_no,
		COUNT (amount) as small_trans
	FROM
		transaction_list
	WHERE
		amount < 2
	GROUP BY
		card_no
	ORDER BY
		   small_trans DESC;

-- VIEW 3 GROUPING BY CH ID
CREATE VIEW chid_small_transactions AS
	SELECT
		creditcard.ch_id,
		card_small_transactions.small_trans
	FROM
		card_small_transactions
	LEFT JOIN creditcard USING (card_no)
	ORDER BY card_small_transactions.small_trans DESC;
	
SELECT * from merchant