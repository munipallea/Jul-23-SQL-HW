DROP TABLE IF EXISTS CardHolder CASCADE;
DROP TABLE IF EXISTS CreditCard CASCADE;
DROP TABLE IF EXISTS Merchant CASCADE;
DROP TABLE IF EXISTS MerchantCategory CASCADE;
DROP TABLE IF EXISTS Transaction_List CASCADE;
DROP TABLE IF EXISTS Transaction CASCADE;


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
  Trans_Date DATE NOT NULL,
  AMOUNT FLOAT,
	Card_NO BIGINT NOT NULL,
	FOREIGN KEY (Card_NO)  
	REFERENCES CreditCard(Card_NO),
	
	Merchant_ID INT NOT NULL,
	FOREIGN KEY (Merchant_ID)  
	REFERENCES Merchant(Merchant_ID)
);

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
