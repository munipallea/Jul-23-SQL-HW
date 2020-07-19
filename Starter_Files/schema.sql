DROP TABLE IF EXISTS CardHolder CASCADE;
DROP TABLE IF EXISTS CreditCard CASCADE;
DROP TABLE IF EXISTS Merchant CASCADE;
DROP TABLE IF EXISTS MerchantCategory CASCADE;
DROP TABLE IF EXISTS Transaction CASCADE;



CREATE TABLE CardHolder(
  CH_ID INTEGER PRIMARY KEY NOT NULL,
  CH_NAME VARCHAR,
);


CREATE TABLE CreditCard (
  Card_NO BIGINT PRIMARY KEY NOT NULL,
  FOREIGN KEY (CH_ID)  REFERENCES CardHolder(CH_ID),
);


CREATE TABLE Merchant (
  Merchant_ID INTEGER PRIMARY KEY,
  Merchant_Name VARCHAR NOT NULL,
  FOREIGN KEY (Merchant_ID_Category)  REFERENCES CardHolder(MerchantCategory.Merchant_ID_Category)
);


CREATE TABLE MerchantCategory(
  Merchant_ID_Category INTEGER PRIMARY KEY NOT NULL,
  MerchantCategory_Name VARCHAR NOT NULL,
);


CREATE TABLE Transaction(
  Trans_id INTEGER PRIMARY KEY NOT NULL,
  Trans_Date DATE NOT NULL,
  AMOUNT BIGINT,
  FOREIGN KEY (Merchant_ID_Category)  REFERENCES CardHolder(MerchantCategory.Merchant_ID_Category)
);

-- Table schema for the junction table
