﻿USE master
IF EXISTS (SELECT * FROM SYS.DATABASES WHERE NAME = 'QLBH')
BEGIN
	ALTER DATABASE QLBH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE QLBH;
END
GO

CREATE DATABASE QLBH
GO

USE QLBH
GO
CREATE TABLE KHACHHANG
(
	MAKH CHAR(4) PRIMARY KEY, 
	HOTEN VARCHAR(40) NOT NULL,
	DCHI VARCHAR(50) NOT NULL,
	SODT VARCHAR(20) NOT NULL,
	NGSINH SMALLDATETIME,
	NGDK SMALLDATETIME,
	DOANHSO MONEY NOT NULL
)
GO

CREATE TABLE NHANVIEN
(
	MANV CHAR(4) PRIMARY KEY,
	HOTEN VARCHAR(40) NOT NULL,
	SODT VARCHAR(20) NOT NULL,
	NGVL SMALLDATETIME
)
GO

CREATE TABLE SANPHAM
(
	MASP CHAR(4) PRIMARY KEY,
	TENSP VARCHAR(40) NOT NULL,
	DVT VARCHAR(20),
	NUOCSX VARCHAR(40),
	GIA MONEY NOT NULL
)
GO

CREATE TABLE HOADON
(
	SOHD INT PRIMARY KEY,
	NGHD SMALLDATETIME,
	MAKH CHAR(4) FOREIGN KEY REFERENCES KHACHHANG(MAKH),
	MANV CHAR(4) FOREIGN KEY REFERENCES NHANVIEN(MANV),
	TRIGIA MONEY
)
GO

CREATE TABLE CTHD
(
	SOHD INT FOREIGN KEY REFERENCES HOADON(SOHD),
	MASP CHAR(4) FOREIGN KEY REFERENCES SANPHAM(MASP),
	SL INT,
	PRIMARY KEY (SOHD, MASP)
)
GO
--Nhập dữ liệu cho CSDL QuanLyBanHang 

INSERT INTO KHACHHANG (MAKH, HOTEN, DCHI, SODT, NGSINH, NGDK, DOANHSO) VALUES
('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '0823451', '1974-10-22', '2006-10-23', 13600000),
('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0980256478', '1974-03-04', '2006-12-12', 840000),
('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0387766226', '1980-12-16', '2006-08-23', 100000),
('KH04', 'Tran Minh Long', '50/4 Le Dai Hanh, Q10, TpHCM', '0913256748', '1980-10-26', '2006-09-01', 18000),
('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '082461051', '1980-03-16', '2006-10-20', 3800000),
('KH06', 'Nguyen Le Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '0832754165', '1976-01-01', '2006-10-16', 2430000),
('KH07', 'Nguyen Nam Tam', '23 Tran Binh Trong, Q5, TpHCM', '091839402', '1975-09-03', '2006-10-28', 510000),
('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0978965478', '1980-04-12', '2006-10-28', 440000),
('KH09', 'Le Hanh', '45/3 Le Hong Phong, Q5, TpHCM', '091293546', '1985-09-16', '2007-01-13', 7000000),
('KH10', 'Ha Duy Lap', '34/3B Nguyen Trai, Q1, TpHCM', '08768094', '1985-12-25', '2007-01-16', 330000);

INSERT INTO NHANVIEN (MANV, HOTEN, NGVL, SODT) VALUES
('NV01', 'Nguyen Nhu Nhut', '2006-04-13', '0927345678'),
('NV02', 'Le Thi Phi Yen', '2006-04-21', '0987567930'),
('NV03', 'Nguyen Van Ba', '2006-06-24', '0912735849'),
('NV04', 'Ngo Thanh Tuan', '2006-05-10', '0931758498'),
('NV05', 'Nguyen Thi Truc Thanh', '2006-07-20', '0918590387');

INSERT INTO SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA) VALUES
('BC01', 'But chi', 'cay', 'Singapore', 3500),
('BC02', 'But chi', 'cay', 'Singapore', 5000),
('BC03', 'But chi', 'cay', 'Viet Nam', 3500),
('BC04', 'But chi', 'hop', 'Viet Nam', 30000),
('BB01', 'But bi', 'cay', 'Viet Nam', 5000),
('BB02', 'But bi', 'cay', 'Trung Quoc', 5000),
('BB03', 'But bi', 'hop', 'Thai Lan', 100000),
('TV01', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', 2500),
('TV02', 'Tap 200 giay tot', 'quyen', 'Trung Quoc', 4500),
('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000),
('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5200),
('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000),
('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', 53000),
('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', 34000),
('ST01', 'So tay 500 mong', 'quyen', 'Thai Lan', 55000),
('ST02', 'So tay loai 1', 'quyen', 'Thai Lan', 20000),
('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 10000),
('ST04', 'So tay', 'quyen', 'Viet Nam', 5000),
('ST05', 'So tay', 'quyen', 'Thai Lan', 55000),
('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000),
('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000),
('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000),
('ST09', 'But long', 'cay', 'Viet Nam', 5000),
('ST10', 'But long', 'cay', 'Trung Quoc', 7000);

INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA) VALUES
(1001, '2006-07-23', 'KH01', 'NV01', 320000),
(1002, '2006-08-12', 'KH01', 'NV01', 840000),
(1003, '2006-08-23', 'KH02', 'NV01', 100000),
(1004, '2006-09-01', 'KH02', 'NV02', 98000),
(1005, '2006-10-20', 'KH01', 'NV02', 3800000),
(1006, '2006-10-16', 'KH01', 'NV03', 2430000),
(1007, '2006-10-28', 'KH03', 'NV01', 510000),
(1008, '2006-10-28', 'KH01', 'NV01', 440000),
(1009, '2006-10-28', 'KH03', 'NV03', 200000),
(1010, '2006-11-01', 'KH01', 'NV01', 5200000),
(1011, '2006-11-04', 'KH04', 'NV01', 250000),
(1012, '2006-11-30', 'KH05', 'NV01', 21000),
(1013, '2006-12-01', 'KH06', 'NV01', 5000),
(1014, '2006-12-31', 'KH03', 'NV01', 3150000),
(1015, '2007-01-01', 'KH06', 'NV01', 910000),
(1016, '2007-01-01', 'KH07', 'NV02', 12500),
(1017, '2007-01-02', 'KH08', 'NV03', 35000),
(1018, '2007-01-13', 'KH08', 'NV04', 330000),
(1019, '2007-01-14', 'KH01', 'NV01', 30000),
(1020, '2007-01-14', 'KH09', 'NV01', 70000),
(1021, '2007-01-16', 'KH10', 'NV02', 67500),
(1022, '2007-01-16', NULL, 'NV03', 7000),
(1023, '2007-01-17', NULL, 'NV01', 330000);


INSERT INTO CTHD (SOHD, MASP, SL) VALUES
(1001, 'TV02', 10),
(1001, 'ST01', 5),
(1001, 'BC01', 5),
(1001, 'BC02', 10),
(1001, 'ST08', 10),
(1002, 'BC04', 20),
(1002, 'BB01', 20),
(1002, 'BB02', 20),
(1003, 'BB03', 10),
(1003, 'TV01', 20),
(1004, 'TV02', 10),
(1004, 'TV03', 10),
(1004, 'TV04', 10),
(1005, 'TV05', 50),
(1006, 'TV06', 50),
(1006, 'TV07', 20),
(1006, 'ST01', 30),
(1006, 'ST02', 10),
(1007, 'ST03', 10),
(1008, 'ST04', 8),
(1009, 'ST05', 10),
(1010, 'TV07', 50),
(1011, 'ST06', 50),
(1012, 'ST07', 10),
(1013, 'ST08', 100),
(1014, 'TV03', 100),
(1015, 'ST01', 30),
(1016, 'ST02', 10),
(1017, 'ST03', 10),
(1018, 'ST04', 8),
(1019, 'ST05', 10),
(1020, 'TV07', 50),
(1021, 'ST06', 50),
(1022, 'ST07', 10),
(1023, 'ST08', 100);
ALTER TABLE KHACHHANG 
Add LOAIKH VARCHAR(20)
SELECT * FROM KHACHHANG
SELECT * FROM NHANVIEN
SELECT * FROM SANPHAM
SELECT * FROM HOADON
SELECT * FROM CTHD
-- Bài tập 1
-- Câu 12: . Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.SELECT DISTINCT HOADON.SOHD
FROM HOADON
JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
WHERE CTHD.MASP IN ('BB01', 'BB02') 
AND CTHD.SL BETWEEN 10 AND 20;
--Câu 13: Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT HOADON.SOHD
FROM HOADON
JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
WHERE CTHD.MASP IN ('BB01', 'BB02')
AND CTHD.SL BETWEEN 10 AND 20
GROUP BY HOADON.SOHD
HAVING COUNT(DISTINCT CTHD.MASP) = 2;
--Bài tập 4
-- Câu 14: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT DISTINCT SANPHAM.MASP, SANPHAM.TENSP
FROM SANPHAM
LEFT JOIN CTHD ON SANPHAM.MASP = CTHD.MASP
LEFT JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE SANPHAM.NUOCSX = 'Trung Quoc'
   OR HOADON.NGHD = '2007-01-01';
--Câu 15: In ra danh sách các sản phẩm (MASP,TENSP) không bán được
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP NOT IN (SELECT MASP FROM CTHD);
--Câu 16: In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP NOT IN (
    SELECT MASP
    FROM CTHD
    INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
    WHERE HOADON.NGHD BETWEEN '2006-01-01' AND '2006-12-31'
);
--Câu 17: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
AND MASP NOT IN (
    SELECT CTHD.MASP
    FROM CTHD
    JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
    WHERE YEAR(HOADON.NGHD) = 2006
);
--Câu 18: Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
WITH SingaporeProducts AS (
    SELECT MASP
    FROM SANPHAM
    WHERE NUOCSX = 'Singapore'
),
InvoicesWithSingaporeProducts AS (
    SELECT CTHD.SOHD
    FROM CTHD
    JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
    WHERE HOADON.NGHD BETWEEN '2006-01-01' AND '2006-12-31'
    AND CTHD.MASP IN (SELECT MASP FROM SingaporeProducts)
    GROUP BY CTHD.SOHD
    HAVING COUNT(DISTINCT CTHD.MASP) = (SELECT COUNT(*) FROM SingaporeProducts)
)
SELECT DISTINCT SOHD
FROM InvoicesWithSingaporeProducts;
