INSERT INTO raw.orderdetails VALUES ('1250.00','123','S18_1749',1,200,'FOOBAR','2024-06-11 15:08:46.806+00','{"changes": []}');
INSERT INTO raw.orders VALUES ('Shipped','','2024-06-13',123,'2024-06-13','2024-06-15',119,'FOOBAR','2024-06-11 15:08:46.82+00','{"changes": []}');
UPDATE raw.products SET "productName" = 'FOOBAR' WHERE "productCode" = 'S18_1749';

