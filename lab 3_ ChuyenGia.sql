
-- 8. Hiển thị tên và cấp độ của tất cả các kỹ năng của chuyên gia có MaChuyenGia là 1.
SELECT * FROM ChuyenGia_KyNang
WHERE MaChuyenGia = 1;
-- 9. Liệt kê tên các chuyên gia tham gia dự án có MaDuAn là 2.
SELECT cg.HoTen
FROM ChuyenGia cg
JOIN ChuyenGia_DuAn cgd ON cg.MaChuyenGia = cgd.MaChuyenGia
WHERE cgd.MaDuAn = 2;
-- 10. Hiển thị tên công ty và tên dự án của tất cả các dự án.
SELECT ct.TenCongTy, da.TenDuAn
FROM CongTy ct
JOIN DuAn da ON ct.MaCongTy = da.MaCongTy;
-- 11. Đếm số lượng chuyên gia trong mỗi chuyên ngành.
SELECT ChuyenNganh, COUNT(*) AS SoLuongChuyenGia
FROM ChuyenGia
GROUP BY ChuyenNganh;
-- 12. Tìm chuyên gia có số năm kinh nghiệm cao nhất.
SELECT TOP 1 *
FROM ChuyenGia
ORDER BY NamKinhNghiem DESC;
-- 13. Liệt kê tên các chuyên gia và số lượng dự án họ tham gia.
SELECT cg.HoTen, COUNT(cda.MaDuAn) AS SoLuongDuAn
FROM ChuyenGia cg
LEFT JOIN ChuyenGia_DuAn cda ON cg.MaChuyenGia = cda.MaChuyenGia
GROUP BY cg.HoTen;

-- 14. Hiển thị tên công ty và số lượng dự án của mỗi công ty.
SELECT ct.TenCongTy, COUNT(da.MaDuAn) AS SoLuongDuAn
FROM CongTy ct
LEFT JOIN DuAn da ON ct.MaCongTy = da.MaCongTy
GROUP BY ct.TenCongTy;
-- 15. Tìm kỹ năng được sở hữu bởi nhiều chuyên gia nhất.
SELECT ky.TenKyNang
FROM KyNang ky
JOIN ChuyenGia_KyNang ckg ON ky.MaKyNang = ckg.MaKyNang
GROUP BY ky.TenKyNang
HAVING COUNT(ckg.MaChuyenGia) = (
    SELECT MAX(SoLuong)
    FROM (
        SELECT COUNT(*) AS SoLuong
        FROM ChuyenGia_KyNang
        GROUP BY MaKyNang
    ) AS SubQuery
);
-- 16. Liệt kê tên các chuyên gia có kỹ năng 'Python' với cấp độ từ 4 trở lên.
SELECT cg.HoTen
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ckg ON cg.MaChuyenGia = ckg.MaChuyenGia
JOIN KyNang ky ON ckg.MaKyNang = ky.MaKyNang
WHERE ky.TenKyNang = 'Python' AND ckg.CapDo >= 4;
-- 17. Tìm dự án có nhiều chuyên gia tham gia nhất.
SELECT da.TenDuAn
FROM DuAn da
JOIN ChuyenGia_DuAn cgd ON da.MaDuAn = cgd.MaDuAn
GROUP BY da.TenDuAn
HAVING COUNT(cgd.MaChuyenGia) = (
    SELECT MAX(SoLuong)
    FROM (
        SELECT COUNT(*) AS SoLuong
        FROM ChuyenGia_DuAn
        GROUP BY MaDuAn
    ) AS SubQuery
);
-- 18. Hiển thị tên và số lượng kỹ năng của mỗi chuyên gia.
SELECT cg.HoTen, COUNT(ckg.MaKyNang) AS SoLuongKyNang
FROM ChuyenGia cg
LEFT JOIN ChuyenGia_KyNang ckg ON cg.MaChuyenGia = ckg.MaChuyenGia
GROUP BY cg.HoTen;
-- 19. Tìm các cặp chuyên gia làm việc cùng dự án.
SELECT cg1.HoTen AS ChuyenGia1, cg2.HoTen AS ChuyenGia2, da.TenDuAn
FROM ChuyenGia_DuAn cgd1
JOIN ChuyenGia_DuAn cgd2 ON cgd1.MaDuAn = cgd2.MaDuAn AND cgd1.MaChuyenGia < cgd2.MaChuyenGia
JOIN ChuyenGia cg1 ON cgd1.MaChuyenGia = cg1.MaChuyenGia
JOIN ChuyenGia cg2 ON cgd2.MaChuyenGia = cg2.MaChuyenGia
JOIN DuAn da ON cgd1.MaDuAn = da.MaDuAn
ORDER BY da.TenDuAn;
-- 20. Liệt kê tên các chuyên gia và số lượng kỹ năng cấp độ 5 của họ.
SELECT cg.HoTen, COUNT(ckg.MaKyNang) AS SoLuongKyNangCapDo5
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ckg ON cg.MaChuyenGia = ckg.MaChuyenGia
WHERE ckg.CapDo = 5
GROUP BY cg.HoTen;
-- 21. Tìm các công ty không có dự án nào.
SELECT ct.TenCongTy
FROM CongTy ct
LEFT JOIN DuAn da ON ct.MaCongTy = da.MaCongTy
WHERE da.MaDuAn IS NULL;
-- 22. Hiển thị tên chuyên gia và tên dự án họ tham gia, bao gồm cả chuyên gia không tham gia dự án nào.
SELECT cg.HoTen AS TenChuyenGia, da.TenDuAn
FROM ChuyenGia cg
LEFT JOIN ChuyenGia_DuAn cgd ON cg.MaChuyenGia = cgd.MaChuyenGia
LEFT JOIN DuAn da ON cgd.MaDuAn = da.MaDuAn;
-- 23. Tìm các chuyên gia có ít nhất 3 kỹ năng.
SELECT cg.HoTen
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ckg ON cg.MaChuyenGia = ckg.MaChuyenGia
GROUP BY cg.HoTen
HAVING COUNT(ckg.MaKyNang) >= 3;
-- 24. Hiển thị tên công ty và tổng số năm kinh nghiệm của tất cả chuyên gia trong các dự án của công ty đó.
SELECT ct.TenCongTy, SUM(cg.NamKinhNghiem) AS TongNamKinhNghiem
FROM CongTy ct
JOIN DuAn da ON ct.MaCongTy = da.MaCongTy
JOIN ChuyenGia_DuAn cgd ON da.MaDuAn = cgd.MaDuAn
JOIN ChuyenGia cg ON cgd.MaChuyenGia = cg.MaChuyenGia
GROUP BY ct.TenCongTy;
-- 25. Tìm các chuyên gia có kỹ năng 'Java' nhưng không có kỹ năng 'Python'.
SELECT cg.HoTen
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ckg ON cg.MaChuyenGia = ckg.MaChuyenGia
WHERE ckg.MaKyNang = (SELECT MaKyNang FROM KyNang WHERE TenKyNang = 'Java')
AND cg.MaChuyenGia NOT IN (
    SELECT ckg.MaChuyenGia
    FROM ChuyenGia_KyNang ckg
    WHERE ckg.MaKyNang = (SELECT MaKyNang FROM KyNang WHERE TenKyNang = 'Python')
)
GROUP BY cg.HoTen;
-- 76. Tìm chuyên gia có số lượng kỹ năng nhiều nhất.
SELECT cg.HoTen
FROM ChuyenGia cg
WHERE cg.MaChuyenGia IN (
    SELECT ckg.MaChuyenGia
    FROM ChuyenGia_KyNang ckg
    GROUP BY ckg.MaChuyenGia
    HAVING COUNT(ckg.MaKyNang) = (
        SELECT MAX(KySoLuong)
        FROM (
            SELECT COUNT(*) AS KySoLuong
            FROM ChuyenGia_KyNang
            GROUP BY MaChuyenGia
        ) AS subquery
    )
);
-- 77. Liệt kê các cặp chuyên gia có cùng chuyên ngành.
SELECT cg1.HoTen AS ChuyenGia1, cg2.HoTen AS ChuyenGia2, cg1.ChuyenNganh
FROM ChuyenGia cg1
JOIN ChuyenGia cg2 ON cg1.MaChuyenGia < cg2.MaChuyenGia AND cg1.ChuyenNganh = cg2.ChuyenNganh
ORDER BY cg1.ChuyenNganh, cg1.HoTen, cg2.HoTen;
-- 78. Tìm công ty có tổng số năm kinh nghiệm của các chuyên gia trong dự án cao nhất.
WITH TongKinhNghiem AS (
    SELECT ct.MaCongTy, SUM(cg.NamKinhNghiem) AS TongNamKinhNghiem
    FROM CongTy ct
    JOIN DuAn da ON ct.MaCongTy = da.MaCongTy
    JOIN ChuyenGia_DuAn cgd ON da.MaDuAn = cgd.MaDuAn
    JOIN ChuyenGia cg ON cgd.MaChuyenGia = cg.MaChuyenGia
    GROUP BY ct.MaCongTy
)

SELECT ct.TenCongTy
FROM TongKinhNghiem tkn
JOIN CongTy ct ON tkn.MaCongTy = ct.MaCongTy
WHERE tkn.TongNamKinhNghiem = (
    SELECT MAX(TongNamKinhNghiem)
    FROM TongKinhNghiem
);
-- 79. Tìm kỹ năng được sở hữu bởi tất cả các chuyên gia.
SELECT ky.TenKyNang
FROM KyNang ky
JOIN ChuyenGia_KyNang ckg ON ky.MaKyNang = ckg.MaKyNang
GROUP BY ky.TenKyNang
HAVING COUNT(DISTINCT ckg.MaChuyenGia) = (SELECT COUNT(*) FROM ChuyenGia);
