CREATE TABLE suppliers(
   sup_id INT AUTO_INCREMENT,
   sup_name VARCHAR(50) NOT NULL,
   sup_city VARCHAR(50) NOT NULL,
   sup_countries VARCHAR(50) NOT NULL,
   sup_adress VARCHAR(50) NOT NULL,
   sup_zipcode VARCHAR(20) NOT NULL,
   sup_phone VARCHAR(20) NOT NULL,
   sup_mail VARCHAR(75) NOT NULL,
   sup_type VARCHAR(10) NOT NULL,
   PRIMARY KEY(sup_id),
   UNIQUE(sup_phone),
   UNIQUE(sup_mail)
);

CREATE TABLE categories(
   cat_id INT AUTO_INCREMENT,
   cat_name VARCHAR(30) NOT NULL,
   PRIMARY KEY(cat_id)
);

CREATE TABLE users(
   use_id INT AUTO_INCREMENT,
   use_role VARCHAR(15) NOT NULL,
   PRIMARY KEY(use_id)
);

CREATE TABLE subcategories(
   sub_id INT AUTO_INCREMENT,
   sub_name VARCHAR(30) NOT NULL,
   cat_id INT NOT NULL,
   PRIMARY KEY(sub_id),
   FOREIGN KEY(cat_id) REFERENCES categories(cat_id)
);

CREATE TABLE employees(
   emp_id INT AUTO_INCREMENT,
   emp_firstname VARCHAR(30) NOT NULL,
   emp_lastname VARCHAR(30) NOT NULL,
   emp_city VARCHAR(30) NOT NULL,
   emp_countries VARCHAR(30) NOT NULL,
   emp_zipcode VARCHAR(20) NOT NULL,
   emp_adress VARCHAR(50) NOT NULL,
   emp_phone VARCHAR(20) NOT NULL,
   emp_mail VARCHAR(75) NOT NULL,
   emp_type VARCHAR(10),
   use_id INT NOT NULL,
   sup_id INT NOT NULL,
   PRIMARY KEY(emp_id),
   UNIQUE(use_id),
   UNIQUE(emp_phone),
   UNIQUE(emp_mail),
   FOREIGN KEY(use_id) REFERENCES users(use_id),
   FOREIGN KEY(sup_id) REFERENCES suppliers(sup_id)
);

CREATE TABLE customers(
   cus_id INT AUTO_INCREMENT,
   cus_lastname VARCHAR(30) NOT NULL,
   cus_firstname VARCHAR(30) NOT NULL,
   cus_city VARCHAR(30) NOT NULL,
   cus_countries VARCHAR(30) NOT NULL,
   cus_zipcode VARCHAR(20) NOT NULL,
   cus_adress VARCHAR(50) NOT NULL,
   cus_phone VARCHAR(20),
   cus_mail VARCHAR(75) NOT NULL,
   cus_type BOOLEAN NOT NULL,
   cus_coef DECIMAL(3,2) NOT NULL,
   use_id INT NOT NULL,
   emp_id INT NOT NULL,
   PRIMARY KEY(cus_id),
   UNIQUE(use_id),
   UNIQUE(cus_phone),
   UNIQUE(cus_mail),
   FOREIGN KEY(use_id) REFERENCES users(use_id),
   FOREIGN KEY(emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE orders(
   ord_id INT AUTO_INCREMENT,
   ord_order_date DATETIME NOT NULL,
   ord_bil_date DATETIME,
   ord_payment_date DATETIME,
   ord_ship_date DATETIME,
   ord_reception_date DATETIME,
   ord_status VARCHAR(10),
   ord_delivery_invoice BOOLEAN NOT NULL,
   ord_dnote TEXT NOT NULL,
   ord_del_adress VARCHAR(50),
   ord_del_city VARCHAR(50),
   ord_del_countries VARCHAR(50),
   ord_del_zipcode VARCHAR(20),
   ord_additional_reduction DECIMAL(10,2),
   cus_id INT NOT NULL,
   PRIMARY KEY(ord_id),
   FOREIGN KEY(cus_id) REFERENCES customers(cus_id)
);

CREATE TABLE product(
   pro_id INT AUTO_INCREMENT,
   pro_name VARCHAR(50) NOT NULL,
   pro_little_desc VARCHAR(20),
   pro_desc TEXT,
   pro_ref VARCHAR(20) NOT NULL,
   pro_price DECIMAL(10,2) NOT NULL,
   pro_stock INT,
   pro_stock_alert INT NOT NULL,
   pro_add_date DATETIME NOT NULL,
   pro_update_date DATETIME,
   pro_picture TEXT,
   sup_id INT NOT NULL,
   sub_id INT NOT NULL,
   PRIMARY KEY(pro_id),
   UNIQUE(pro_ref),
   FOREIGN KEY(sup_id) REFERENCES suppliers(sup_id),
   FOREIGN KEY(sub_id) REFERENCES subcategories(sub_id)
);

CREATE TABLE composes(
   pro_id INT AUTO_INCREMENT,
   ord_id INT,
   order_quantity INT NOT NULL,
   price_modified DECIMAL(10,2),
   PRIMARY KEY(pro_id, ord_id),
   FOREIGN KEY(pro_id) REFERENCES product(pro_id),
   FOREIGN KEY(ord_id) REFERENCES orders(ord_id)
);

CREATE TABLE manages(
   pro_id INT AUTO_INCREMENT,
   emp_id INT,
   PRIMARY KEY(pro_id, emp_id),
   FOREIGN KEY(pro_id) REFERENCES product(pro_id),
   FOREIGN KEY(emp_id) REFERENCES employees(emp_id)
);


INSERT INTO `suppliers` (`sup_id`,`sup_name`,`sup_city`,`sup_countries`,`sup_adress`,`sup_zipcode`,`sup_phone`,`sup_mail`,`sup_type`)
VALUES
  (1,"Mathieu Grimberg Production","Lille","France","7 rue du bois l'abbé pierre","59000","06 18 25 45 45","est.vitae@hotmail.ca",4),
  (2,"Colin Gibbs Daniel","Amiens","France","54 rue des papillons","80000","03 25 26 45 45","dolor@yahoo.couk",9),
  (3,"Caldwell Comptoir","Brest","France","1 rue perdues","45000","03 54 58 85 25","et.magnis.dis@yahoo.ca",5),
  (4,"Hayden Stuart - Don de matériaux","Marseille","France","87 rue du vieux port","13000","03 25 25 45 65","neque@protonmail.ca",1),

INSERT INTO `categories` (`cat_id`,`cat_name`)
VALUES
  (1,"Rock"),
  (2,"Reggea"),
  (3,"Rap");


INSERT INTO `users` (`use_id`,`use_role`)
VALUES
   (1,"admin"),
   (2,"employés"),
   (3,"client"),
   (4,"visiteur");


INSERT INTO `subcategories` (`sub_id`,`sub_name`,`cat_id`)
VALUES
   (1,"Rock étranger",1),
   (2,"Rock français",1),
   (3,"Reggea étranger", 2),
   (4,"Reggea français",2),
   (5,"Rap étranger", 3),
   (6,"Rap français", 3);


INSERT INTO `employees` (`emp_id`,`emp_firstname`,`emp_lastname`,`emp_city`,`emp_countries`,`emp_zipcode`,`emp_adress`,`emp_phone`,`emp_mail`,`emp_type`)
VALUES
  (1,"Loucas","Hérault","Amiens","France","80000","30 rue de Poulainville","08 47 46 38 01","vivamus.non@protonmail.net","pro"),
  (2,"Marco-Miguel","Hérault","Lille","France","QL54 3XJ","55 rue Solférino","02 46 63 82 34","a.aliquet@protonmail.couk","pro"),
  (3,"Jonas","Rovillon","Chateau-Thierry","France","02400","15 rue des sables","05 98 27 27 89","pellentesque.a@yahoo.edu","particulier"),

/*manque peut être des infos colonne */
INSERT INTO `customers` (`cus_id`,`cus_firstname`,`cus_lastname`,`cus_city`,`cus_countries`,`cus_zipcode`,`cus_adress`,`cus_phone`,`cus_mail`,`cus_type`)
VALUES
  (1,"Montana","Coleman","North Waziristan","China","25099","340-3914 Maecenas Avenue","05 29 43 73 76","consectetuer@outlook.org","0"),
  (2,"Chaim","Nichols","Motala","Brazil","553136","Ap #952-9106 Suspendisse St.","09 60 46 55 44","sed@protonmail.com","0"),
  (3,"Addison","Guerra","Yopal","Sweden","154289","4321 Maecenas Av.","07 18 77 62 54","ullamcorper.velit@hotmail.edu","1"),
  (4,"Sasha","Horne","Cà Mau","Netherlands","50203","P.O. Box 462, 7974 Cum Av.","04 28 14 43 87","integer.vitae@aol.net","1"),
  (5,"Shelby","Waters","Burns Lake","Sweden","515634","Ap #582-5536 Purus. Ave","01 36 07 14 18","id.risus@aol.org","1");
  (6,"Amena","Cortez","Fort Good Hope","Russian Federation","103508","Ap #326-1196 Nunc Av.","05 67 31 15 72","euismod.et.commodo@outlook.org","0"),
  (7,"Fitzgerald","Wood","San Pablo","Poland","28338","Ap #265-8129 Luctus Street","09 17 34 76 87","eu.dolor@hotmail.edu","1"),
  (8,"Berk","Downs","Recklinghausen","Indonesia","31226-32625","Ap #568-6607 Dui. Rd.","01 28 12 17 44","dignissim@google.edu","1"),
  (9,"Lane","Sargent","Moncton","United Kingdom","861667","Ap #203-5117 Sapien Rd.","03 19 40 44 63","morbi.tristique@protonmail.net","1"),
  (10,"Alexis","Powers","Pskov","Pakistan","B7Z 1C8","891-6336 Lorem Street","07 16 35 78 52","aliquet@google.edu","1");

/*manque peut être des infos colonne*/
INSERT INTO `orders` (`ord_id`;`ord_order_date`,`ord_bil_date`,`ord_payment_date`,`ord_ship_date`,`ord_reception_date`,`ord_status`,`ord_delivery_invoice`,`ord_dnote`,`ord_del_adress`,`ord_del_city`,`ord_del_countries`,`ord_del_zipcode`,`ord_additional_reduction`)
VALUES
  (
/* DROP TABLE IF EXISTS `myTable`;

CREATE TABLE `myTable` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `ord_id` mediumint,
  `ord_order_date` varchar(255),
  `ord_bil_date` varchar(255),
  `ord_payment_date` varchar(255),
  `ord_ship_date` varchar(255),
  `ord_reception_date` varchar(255),
  `ord_status` mediumint default NULL,
  `ord_delivery_invoice` varchar(255) default NULL,
  `ord_dnote` TEXT default NULL,
  `ord_del_adress` varchar(255) default NULL,
  `ord_del_countries` varchar(100) default NULL,
  `ord_del_zipcode` varchar(10) default NULL,
  `numberrange` mediumint default NULL,
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1;

INSERT INTO `myTable` (`ord_id`,`ord_order_date`,`ord_bil_date`,`ord_payment_date`,`ord_ship_date`,`ord_reception_date`,`ord_status`,`ord_delivery_invoice`,`ord_dnote`,`ord_del_adress`,`ord_del_countries`,`ord_del_zipcode`,`numberrange`)
VALUES
  (1,"May 9, 2021","Aug 24, 2021","May 20, 2022","Aug 30, 2021","Feb 24, 2021",6,"1","arcu et pede. Nunc sed orci lobortis augue scelerisque mollis.","P.O. Box 742, 1088 Consequat Road","Mexico","52450",10),
  (2,"Feb 5, 2022","Oct 28, 2021","Feb 4, 2022","May 15, 2022","Jun 21, 2022",5,"0","molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est,","P.O. Box 872, 6732 Magna. Ave","Germany","40204",19),
  (3,"Feb 8, 2022","Mar 30, 2022","Mar 6, 2022","Aug 20, 2021","Jan 30, 2022",7,"0","non massa non ante bibendum ullamcorper. Duis cursus, diam at","428-3095 Vitae, St.","Peru","2886",19),
  (4,"Oct 24, 2021","May 15, 2022","Feb 9, 2022","Jul 28, 2021","Mar 27, 2021",5,"1","nibh dolor, nonummy ac, feugiat non, lobortis quis, pede. Suspendisse","4077 Tristique Street","United States","248322",24),
  (5,"Feb 11, 2021","Feb 14, 2022","Nov 25, 2022","Feb 10, 2021","Oct 21, 2022",5,"1","malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit.","8525 A, Av.","France","25578",17);
*/

INSERT INTO `product` (`pro_id`,`pro_name`,`pro_little_desc`,`pro_desc`,`pro_price`,`pro_stock`,`pro_stock_alert`,`pro_add_date`,`pro_update_date`,`pro_picture`)
VALUES
 (1, )