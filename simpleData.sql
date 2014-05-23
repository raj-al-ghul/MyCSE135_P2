
INSERT INTO users (name, role, age, state) VALUES('user0','customer',0,'CA');
INSERT INTO users (name, role, age, state) VALUES('user1','customer',1,'CA');
INSERT INTO users (name, role, age, state) VALUES('user2','customer',2,'CA');

INSERT INTO categories (name, description) VALUES('c0','This is a category');

INSERT INTO products (cid, name, SKU, price) VALUES(1, 'p0','SKU0',1);
INSERT INTO products (cid, name, SKU, price) VALUES(1, 'p1','SKU1',1);
INSERT INTO products (cid, name, SKU, price) VALUES(1, 'p2','SKU2',1);
INSERT INTO products (cid, name, SKU, price) VALUES(1, 'p3','SKU3',1);
INSERT INTO products (cid, name, SKU, price) VALUES(1, 'p4','SKU4',1);
INSERT INTO products (cid, name, SKU, price) VALUES(1, 'p5','SKU5',1);

INSERT INTO sales (uid, pid, quantity,price) VALUES(1, 1 , 1, 1);
INSERT INTO sales (uid, pid, quantity,price) VALUES(2, 2 , 1, 1);
INSERT INTO sales (uid, pid, quantity,price) VALUES(3, 3 , 1, 1);
INSERT INTO sales (uid, pid, quantity,price) VALUES(1, 1 , 1, 1);
INSERT INTO sales (uid, pid, quantity,price) VALUES(2, 1 , 1, 1);
INSERT INTO sales (uid, pid, quantity,price) VALUES(3, 1 , 1, 1);


