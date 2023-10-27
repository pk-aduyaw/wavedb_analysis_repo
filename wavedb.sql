DROP DATABASE IF EXISTS wave;

CREATE DATABASE wave;

USE wave;



CREATE TABLE `users` (
  `u_id` integer PRIMARY KEY,
  `name` text NOT NULL,
  `mobile` text NOT NULL,
  `wallet_id` integer NOT NULL,
  `when_created` timestamp NOT NULL
  
);

CREATE TABLE `transfers` (
  `transfer_id` integer PRIMARY KEY,
  `u_id` integer NOT NULL,
  `source_wallet_id` integer NOT NULL,
  `dest_wallet_id` integer NOT NULL,
  `send_amount_currency` text NOT NULL,
  `send_amount_scalar` numeric NOT NULL,
  `receive_amount_currency` text NOT NULL,
  `receive_amount_scalar` numeric NOT NULL,
  `kind` text NOT NULL,
  `dest_mobile` text,
  `dest_merchant_id` integer,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `agents` (
  `agent_id` integer PRIMARY KEY,
  `name` text,
  `country` text NOT NULL,
  `region` text,
  `city` text,
  `subcity` text,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `agent_transactions` (
  `atx_id` integer PRIMARY KEY,
  `u_id` integer NOT NULL,
  `agent_id` integer NOT NULL,
  `amount` numeric NOT NULL,
  `fee_amount_scalar` numeric NOT NULL,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `wallets` (
  `wallet_id` integer PRIMARY KEY,
  `currency` text NOT NULL,
  `ledger_location` text NOT NULL,
  `when_created` timestamp NOT NULL
);

ALTER TABLE `transfers` ADD FOREIGN KEY (`u_id`) REFERENCES `users` (`u_id`);

ALTER TABLE `agent_transactions` ADD FOREIGN KEY (`agent_id`) REFERENCES `agents` (`agent_id`);

ALTER TABLE `agent_transactions` ADD FOREIGN KEY (`u_id`) REFERENCES `users` (`u_id`);

ALTER TABLE `transfers` ADD FOREIGN KEY (`source_wallet_id`) REFERENCES `wallets` (`wallet_id`);

ALTER TABLE `transfers` ADD FOREIGN KEY (`dest_wallet_id`) REFERENCES `wallets` (`wallet_id`);

ALTER TABLE `users` ADD FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`wallet_id`);


INSERT INTO `wallets` VALUES (1,'GHS','Ghana','2020-04-29 23:00:00'),(2,'USD','USA','2020-04-28 23:00:00'),(3,'EUR','Germany','2020-03-29 23:00:00'),(4,'GHS','Ghana','2020-04-29 23:00:00'),(5,'CFA','Ivory Coast','2020-11-05 00:00:00'),(6,'CFA','Ivory Coast','2020-12-05 00:00:00'),(7,'CFA','Ivory Coast','2020-05-12 23:00:00'),(8,'GHS','Ghana','2020-05-13 23:00:00'),(9,'EUR','Germany','2020-05-14 23:00:00'),(10,'USD','USA','2020-05-15 23:00:00');
INSERT INTO `users` VALUES (1,'James Gardner','546808023',1,'2020-04-29 23:00:00'),(2,'Akwasi Yeboah','249458023',2,'2020-04-29 23:00:00'),(3,'Harry Gyampo','278965247',3,'2020-01-05 00:00:00'),(4,'Jones Quaye','267452147',4,'2020-04-29 23:00:00'),(5,'Samuel Ankomah','234321654',5,'2020-04-12 23:00:00'),(6,'Joan Lartey','245902345',6,'2020-04-12 23:00:00'),(7,'Moses Toyosi','208458796',7,'2020-04-16 23:00:00'),(8,'Erica Azure','274201032',8,'2020-05-16 23:00:00'),(9,'Gloria Anan','233636363',9,'2020-04-19 23:00:00'),(10,'Berty Adjei','254658471',10,'2020-04-17 23:00:00');
INSERT INTO `agents` VALUES (1,'Sunday Oluwale','Nigeria','Lagos State','Lagos','Yaba','2020-05-11 00:00:00'),(2,'Enock Ade','Nigeria','Abuja State','Abuja','Kubwa','2020-06-16 00:00:00'),(3,'Pope Armah','Ghana','Greater Accra','Accra','Tesano','2020-06-21 00:00:00'),(4,'Talika','Ivory Coast','Abidjan','Abidjan','Anyama','2020-03-19 00:00:00'),(5,'Elija Nyare','Ghana','Western','Takoradi','Port','2020-05-28 00:00:00'),(6,'Leslie Toure','Ivory Coast','Abidjan','Abidjan','Cocodi','2020-03-20 00:00:00'),(7,'Lesfam','Ghana','Ashanti','Kumasi','Suame','2020-02-20 00:00:00'),(8,'Sadio Kone','Senegal','Dakar','Dakar','Fann','2020-03-26 00:00:00'),(9,'Abdul Salim','Senegal','Dakar','Dakar','Yoff','2020-03-20 00:00:00'),(10,'John Osei','Ghana','Greater Accra','Accra','Legon','2020-04-10 00:00:00');
INSERT INTO `agent_transactions` VALUES (1,1,9,100,0,'2022-03-22 00:00:00'),(2,2,8,200,0,'2022-04-20 00:00:00'),(3,3,7,120,0,'2022-03-25 00:00:00'),(4,4,6,2000,0,'2022-04-26 00:00:00'),(5,5,5,350,0,'2022-01-06 00:00:00'),(6,6,4,60000,0,'2022-01-06 00:00:00'),(7,7,4,4200,0,'2022-01-07 00:00:00'),(8,8,4,300,0,'2022-02-06 00:00:00'),(9,9,3,600,0,'2022-02-06 00:00:00'),(10,10,2,750,0,'2022-03-06 00:00:00'),(11,10,7,800,0,'2022-04-14 00:00:00'),(12,4,6,10,0,'2022-05-15 00:00:00'),(13,5,10,120,0,'2022-07-26 00:00:00'),(14,3,8,500,0,'2022-06-14 00:00:00'),(15,2,2,740,0,'2022-07-25 00:00:00'),(16,1,1,230,0,'2022-02-14 00:00:00'),(17,7,5,-500,5,'2022-02-13 00:00:00'),(18,3,1,-650,6,'2022-03-16 00:00:00'),(19,9,3,-700,7,'2022-02-17 00:00:00'),(20,4,3,-200,2,'2022-01-14 00:00:00'),(21,1,9,600,0,'2022-09-22 00:00:00'),(22,2,8,50000,0,'2022-08-20 00:00:00'),(23,7,3,3000,0,'2022-08-25 00:00:00'),(24,4,6,4230,0,'2022-07-26 00:00:00'),(25,5,8,335,0,'2022-12-06 00:00:00'),(26,6,4,55200,0,'2022-11-06 00:00:00'),(27,7,4,6521,0,'2022-06-07 00:00:00'),(28,8,5,-50000,500,'2022-05-06 00:00:00'),(29,9,3,4800,0,'2022-04-16 00:00:00'),(30,2,2,-7000,70,'2022-07-23 00:00:00'),(31,2,7,80000,0,'2022-04-14 00:00:00'),(32,4,6,-5300,53,'2022-07-30 00:00:00'),(33,3,8,600,0,'2022-06-14 00:00:00'),(34,1,1,860,0,'2022-02-14 00:00:00'),(35,2,2,-1500,15,'2022-02-13 00:00:00'),(36,3,1,-2500,25,'2022-03-16 00:00:00'),(37,9,3,1200,7,'2022-02-17 00:00:00'),(38,4,3,-3200,32,'2022-10-14 00:00:00'),(39,5,7,17000,0,'2022-07-26 00:00:00'),(40,4,2,850,0,'2022-09-25 00:00:00');
INSERT INTO `transfers` VALUES (1,1,1,9,'USD',100,'USD',540,'Merchant','244784512',1,'2022-04-30 00:00:00'),(2,2,2,8,'EUR',150,'EUR',900,'Merchant','234569874',2,'2022-05-01 00:00:00'),(3,3,3,7,'GHS',200,'GHS',40,'Merchant','801234785',5,'2022-03-30 00:00:00'),(4,4,4,6,'USD',1000,'USD',5400,'Merchant','547125463',3,'2022-01-30 00:00:00'),(5,5,5,1,'CFA',2000000,'GHS',2000,'P2P','546654123',NULL,'2022-02-06 00:00:00'),(6,6,6,2,'CFA',50000,'GHS',500,'P2P','578965214',NULL,'2022-07-08 00:00:00'),(7,7,7,3,'CFA',1400000,'GHS',100,'P2P','204010230',NULL,'2022-05-10 00:00:00'),(8,8,8,4,'GHS',500,'GHS',500,'Merchant','577989695',6,'2022-10-13 00:00:00'),(9,9,9,5,'EUR',200,'CFA',140000,'P2P','233321321',NULL,'2022-07-25 00:00:00'),(10,9,9,6,'EUR',100,'CFA',70000,'Merchant','654896321',5,'2022-07-26 00:00:00'),(11,1,1,4,'USD',780,'USD',780,'Merchant','800654787',5,'2022-07-20 00:00:00'),(12,10,10,1,'USD',365,'USD',365,'P2P','900124563',NULL,'2022-09-21 00:00:00'),(13,2,2,6,'EUR',7400,'EUR',7400,'Merchant','147896584',9,'2022-07-24 00:00:00'),(14,1,1,2,'CFA',5000,'CFA',5000,'Merchant','452456871',1,'2022-04-30 00:00:00'),(15,2,4,3,'GHS',8000,'GHS',8000,'P2P','233584587',NULL,'2022-05-01 00:00:00'),(16,3,5,6,'GHS',120,'GHS',120,'P2P','654896321',NULL,'2022-03-30 00:00:00'),(17,4,8,7,'EUR',1000,'EUR',1000,'P2P','900124563',NULL,'2022-12-30 00:00:00'),(18,5,9,1,'USD',80,'USD',80,'P2P','900124563',NULL,'2022-07-06 00:00:00'),(19,6,8,2,'GHS',600,'GHS',600,'P2P','654896321',NULL,'2022-07-08 00:00:00'),(20,6,3,7,'GHS',75,'GHS',75,'Merchant','900124563',2,'2022-07-10 00:00:00'),(21,4,6,4,'CFA',600000,'CFA',600000,'P2P','578965214',NULL,'2022-11-13 00:00:00'),(22,7,5,10,'GHS',2200,'GHS',2200,'P2P','654896321',NULL,'2022-07-20 00:00:00'),(23,8,9,10,'CFA',12150000,'CFA',12150000,'Merchant','578965214',5,'2022-05-21 00:00:00'),(24,9,8,1,'EUR',400,'EUR',400,'Merchant','900124563',4,'2022-07-24 00:00:00'),(25,3,2,6,'USD',1250,'USD',1250,'Merchant','578965214',3,'2022-08-25 00:00:00');

