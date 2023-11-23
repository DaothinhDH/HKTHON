CREATE DATABASE QUANLYBANHANG;
use QUANLYBANHANG;

CREATE TABLE CUSTOMERS(
customer_id VARCHAR(4) PRIMARY KEY NOT NULL,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
phone VARCHAR(25) NOT NULL,
address VARCHAR(255) NOT NULL
);

CREATE TABLE ORDERS(
order_id VARCHAR(4) PRIMARY KEY NOT NULL,
customer_id VARCHAR(4),
FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id),
order_date DATE NOT NULL,
toatal_amount DOUBLE NOT NULL
);

CREATE TABLE PRODUCTS(
product_id VARCHAR(4) PRIMARY KEY NOT NULL,
name VARCHAR(255) NOT NULL,
description TEXT,
price DOUBLE NOT NULL,
status BIT(1) DEFAULT(1) NOT NULL
);

CREATE TABLE ORDERS_DETAILS(
order_id VARCHAR(4)  NOT NULL,
product_id VARCHAR(4),
FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id),
PRIMARY KEY (order_id,product_id),
quantity INT(11) NOT NULL,
price DOUBLE NOT NULL
);
-- Bài 2: Thêm dữ liệu 
-- Thêm dữ liệu vào bảng CUSTOMERS
INSERT INTO CUSTOMERS (customer_id, name, email, phone, address)
VALUES
('C001', 'Nguyễn Trung Mạnh', 'john.doe@example.com', '984756322', 'Cầu giấy,Hà Nội'),
('C002', 'Hồ Hải Nam', 'manhnt@gmail.com', '984875926', 'Ba vì,Sơn La'),
('C003', 'Tô Ngọc Vũ', 'namhh@gmail.com', '555555555', 'Mộc Châu,Sơn La'),
('C004', 'Phạm Ngọc Anh', 'vutn@gmail.com', '111111111', 'Vinh,Nghệ An'),
('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '999999999', 'Hai Bà trưng,hÀ Nội');

-- Thêm dữ liệu vào bảng PRODUCTS
INSERT INTO PRODUCTS (product_id, name, description, price)
VALUES
('P001', ' Iphone 13 ProMax', 'Bảng 512 GB,Xanh Lá', 22999999),
('P002', ' Dell Vostro V3510', 'Core i5,RAM 8GB', 14999999),
('P003', 'Macbook Pro M2', '8CPU 10GPU 8GB 256 GB', 28999999),
('P004', 'Apple Wath Ultra', 'Titanium Alpine Loop Small', 28999999),
('P005', 'Airpods', 'Spatial', 409000);

-- Thêm dữ liệu vào bảng ORDERS
INSERT INTO ORDERS (order_id,customer_id,order_date,toatal_amount) VALUES
	('H001','C001','2023/2/22',52999997),
    ('H002','C001','2023/3/11',80999997),
    ('H003','C002','2023/1/22',54359998),
    ('H004','C003','2023/3/14',102999995),
    ('H005','C003','2022/3/12',80999997),
    ('H006','C004','2023/2/1',110449994),
    ('H007','C004','2023/3/29',79999996),
    ('H008','C005','2023/2/14',29999998),
    ('H009','C005','2023/1/10',28999999),
    ('H010','C005','2023/4/1',149999994);
  -- Thêm dữ liệu vào bảng ORDERS_DETAILS  
INSERT INTO ORDERS_DETAILS (order_id,product_id,price,quantity) VALUES
	('H001','P002',14999999,1),
    ('H001','P004',18999999,2),
    ('H002','P001',22999999,1),
    ('H002','P003',28999999,2),
    ('H003','P004',18999999,2),
    ('H003','P005',4090000,4),
    ('H004','P002',14999999,3),
    ('H004','P003',28999999,2),
    ('H005','P001',22999999,1),
    ('H005','P003',28999999,2),
    ('H006','P005',4090000,5),
    ('H006','P002',14999999,6),
    ('H007','P004',18999999,3),
    ('H007','P001',22999999,1),
    ('H008','P002',14999999,2),
    ('H009','P003',28999999,1),
    ('H010','P003',28999999,2),
    ('H010','P001',22999999,4);

-- Bài 3: Truy vấn dữ liệu
-- 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers .
SELECT name, email, phone, address
FROM CUSTOMERS;
-- 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện thoại và địa chỉ khách hàng).
SELECT c.name, c.phone, c.address
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE MONTH(o.order_date) = 3 AND YEAR(o.order_date) = 2023;
-- 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm tháng và tổng doanh thu ).
SELECT MONTH(order_date) AS 'tHáng', SUM(toatal_amount) AS 'Tổng doanh thu'
FROM ORDERS
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date);
-- 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại).
SELECT name, address, email, phone
FROM CUSTOMERS
WHERE customer_id NOT IN (
SELECT DISTINCT customer_id
FROM ORDERS
WHERE MONTH(order_date) = 2 AND YEAR(order_date) = 2023
);
-- 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã sản phẩm, tên sản phẩm và số lượng bán ra).
SELECT  p.product_id,p.name,sum(od.quantity)as 'Số lượng bán ra'
FROM PRODUCTS AS p
JOIN orders_details od on p.product_id =od.product_id
JOIN orders as o ON o.order_id = od.order_id
WHERE MONTH(order_date) = 3 AND YEAR(order_date) = 2023
GROUP BY p.product_id,p.name;
-- 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu).
SELECT c.customer_id, c.name, SUM(toatal_amount) AS total_spending
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.customer_id
WHERE YEAR(order_date) = 2023
GROUP BY c.customer_id, c.name
ORDER BY total_spending DESC;

-- 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm)
SELECT c.name,o.toatal_amount,o.order_date, SUM(od.quantity) AS total_quantity
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
JOIN ORDERS_DETAILS od ON o.order_id = od.order_id
GROUP BY c.name, o.order_id
HAVING total_quantity >= 5;

-- Bài 4: Tạo View, Procedure
-- 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn .
CREATE VIEW view_details AS
SELECT c.name, c.phone, c.address, o.toatal_amount, o.order_date
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id;
-- 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt.
CREATE VIEW customer_view AS
SELECT c.name, c.address, c.phone, COUNT(od.order_id) AS total_orders
FROM CUSTOMERS as c
JOIN ORDERS as od ON c.customer_id = od.customer_id
GROUP BY c.name, c.address, c.phone;

-- 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm.
CREATE VIEW view_product AS
SELECT p.name, p.description, p.price, SUM(od.quantity) AS 'tổng bán ra'
FROM PRODUCTS p
JOIN ORDERS_DETAILS od ON p.product_id = od.product_id
GROUP BY p.name, p.description, p.price;
-- 4. Đánh Index cho trường `phone` và `email` của bảng Customer.
CREATE INDEX idx_phone ON CUSTOMERS(phone);
CREATE INDEX idx_email ON CUSTOMERS(email);
-- 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.
DELIMITER //
CREATE PROCEDURE PROC_GETCUSTOMERBYID
    (IN id VARCHAR(4))
BEGIN
    SELECT * FROM CUSTOMERS
    WHERE customer_id = id;
END //
DELIMITER ;
CALL PROC_GETCUSTOMERBYID('C001');

-- 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm.
DELIMITER //
CREATE PROCEDURE PROC_GETALLPRODUCTS()
BEGIN
SELECT * FROM PRODUCTS;
END //
DELIMITER ;
CALL PROC_GETALLPRODUCTS();

-- 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng.
DELIMITER //
CREATE PROCEDURE PROC_GETORDERS(IN id VARCHAR(4))
BEGIN
SELECT o.order_id, o.order_date, o.toatal_amount
FROM ORDERS AS o
WHERE o.customer_id = id;
END //
DELIMITER ;

CALL PROC_GETORDERS('C002');

-- 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo.
DELIMITER //
CREATE PROCEDURE PROC_ADD_ORDER(
	IN order_id VARCHAR(4),
    IN customer_id VARCHAR(4),
    IN toatal_amount DOUBLE,
    IN order_date DATE
)
BEGIN
    INSERT INTO ORDERS (order_id,customer_id, toatal_amount, order_date)
    VALUES (order_id,customer_id, toatal_amount, order_date);
    SELECT order_id as 'new_oder_id';
END //
DELIMITER ;

CALL PROC_ADD_ORDER('H011', 'C001', 12000000, '2023-11-23');
-- 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc.
DELIMITER &&
CREATE PROCEDURE QUANTITY_BY_PRODUCT(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT p.product_id,p.name,SUM(od.quantity) AS total_quantity
    FROM products p
    JOIN orders_details od ON p.product_id = od.product_id
    JOIN orders o ON od.order_id = o.order_id
    WHERE o.order_date >= start_date AND o.order_date <= end_date
	GROUP BY p.product_id, p.name;
end;
&&
CALL QUANTITY_BY_PRODUCT('2023-01-01', '2023-12-31');
-- 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê.
DELIMITER &&
CREATE PROCEDURE QUANTITY_BY_PRODUCT_RANK(
    IN p_month INT,
    IN p_year INT
)
BEGIN
    SELECT p.product_id, p.name, SUM(od.quantity) AS total_quantity
    FROM products p
    JOIN orders_details od ON p.product_id = od.product_id
    JOIN orders o ON od.order_id = o.order_id
    WHERE MONTH(o.order_date) = p_month AND YEAR(o.order_date) = p_year
    GROUP BY p.product_id, p.name
    ORDER BY total_quantity DESC;
END &&
DELIMITER ;
CALL QUANTITY_BY_PRODUCT_RANK(3, 2023);
