CREATE DATABASE quanlydiemthi;
USE quanlydiemthi;

CREATE TABLE student(
studentId VARCHAR(4) PRIMARY KEY NOT NULL,
studentName VARCHAR(100) NOT NULL,
birthday DATE NOT NULL,
gender BIT(1) NOT NULL,
address TEXT NOT NULL,
phoneNumber VARCHAR(45) UNIQUE
);

CREATE TABLE subject(
subjectId VARCHAR(4) PRIMARY KEY NOT NULL,
subjectName VARCHAR(45) NOT NULL,
priority INT(11) NOT NULL
);

CREATE TABLE mark(
subjectId VARCHAR(4),
FOREIGN KEY (subjectId) REFERENCES subject (subjectId),
studentId VARCHAR(4),
FOREIGN KEY (studentId) REFERENCES student(studentId),
point DOUBLE NOT NULL
);
-- Bài 2: Thêm sửa xóa dữ liệu
-- student
INSERT INTO student (studentId, studentName, birthday, gender, address, phoneNumber) VALUES 
('S001', 'Nguyễn Thế Anh', '1999-01-11', 1, 'Hà Nội', '984678082'),
('S002', 'Đặng Bảo Trâm', '1998-12-22', 0, 'Lào Cai', '904982654'),
('S003', 'Trần Hà Phương', '2000-05-05', 0, 'Nghệ An', '947645363'),
('S004', 'Đỗ Tiến Mạnh', '1999-03-26', 1, 'Hà Nội', '983665353'),
('S005', 'Phạm Duy Nhất', '1998-10-04', 1, 'Tuyên Quang', '987242678'),
('S006', 'Mai Văn Thái', '2002-06-22', 1, 'Nam Định', '982654268'),
('S007', 'Giang Gia Hân', '1996-11-10', 0, 'Phú Thọ', '982364753'),
('S008', 'Nguyễn Ngọc Bảo My', '1999-01-22', 0, 'Hà Nam', '927867453'),
('S009', 'Nguyễn Tiến Đạt', '1998-08-07', 1, 'Tuyên Quang', '989274673'),
('S010', 'Nguyễn Thiều Quang', '2000-09-18', 	0, 'Hà Nội', 984378291);

-- subject
INSERT INTO subject (subjectId, subjectName, priority) VALUES 
('MH01', 'Toán', 2),
('MH02', 'Vật lý', 2),
('MH03', 'Hóa học', 1),
('MH04', 'Ngữ Văn', 1),
('MH05', 'Tiếng Anh', 2);

-- mark
INSERT INTO mark (subjectId, studentId, point) VALUES
	('MH01','S001',8.5),
    ('MH02','S001',7),
    ('MH03','S001',9),
    ('MH04','S001',9),
    ('MH05','S001',5),
    
    ('MH01','S002',9),
    ('MH02','S002',8),
    ('MH03','S002',6.5),
    ('MH04','S002',8),
    ('MH05','S002',6),
    
    ('MH01','S003',7.5),
    ('MH02','S003',6.5),
    ('MH03','S003',8),
    ('MH04','S003',7),
    ('MH05','S003',7),
    
    ('MH01','S004',6),
    ('MH02','S004',7),
    ('MH03','S004',5),
    ('MH04','S004',6.5),
    ('MH05','S004',8),
    
    ('MH01','S005',5.5),
    ('MH02','S005',8),
    ('MH03','S005',7.5),
    ('MH04','S005',8.5),
    ('MH05','S005',9),
    
    ('MH01','S006',8),
    ('MH02','S006',10),
    ('MH03','S006',9),
    ('MH04','S006',7.5),
    ('MH05','S006',6.5),
    
    ('MH01','S007',8.5),
    ('MH02','S007',9),
    ('MH03','S007',6),
    ('MH04','S007',9),
    ('MH05','S007',4),
    
    ('MH01','S008',10),
    ('MH02','S008',8.5),
    ('MH03','S008',8.5),
    ('MH04','S008',6),
    ('MH05','S008',9.5),
    
    ('MH01','S009',7.5),
    ('MH02','S009',8),
    ('MH03','S009',5.5),
    ('MH04','S009',4),
    ('MH05','S009',7),
    
    ('MH01','S010',6.5),
    ('MH02','S010',8),
    ('MH03','S010',5.5),
    ('MH04','S010',4),
    ('MH05','S010',7);

-- Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”
UPDATE student SET studentName = 'Đỗ Đức Mạnh'
WHERE studentId = 'S004';
-- Sửa tên và hệ số môn học có mã `MH05` thành “NgoạiNgữ” và hệ số là 1.
UPDATE subject
SET subjectName = 'Ngoại Ngữ', priority = 1
WHERE subjectId = 'MH05';
-- Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6,MH05 : 9).
UPDATE mark SET 
point = CASE
    WHEN subjectId = 'MH01' THEN 8.5
    WHEN subjectId = 'MH02' THEN 7
    WHEN subjectId = 'MH03' THEN 5.5
    WHEN subjectId = 'MH04' THEN 6
    WHEN subjectId = 'MH05' THEN 9
END
WHERE studentId = 'S009';

-- 3. Xoá dữ liệu
-- Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT.
DELETE FROM mark WHERE studentId = 'S010';
DELETE FROM student WHERE studentId = 'S010';

-- Bài 3: Truy vấn dữ liệu
-- 1. Lấy ra tất cả thông tin của sinh viên trong bảng Student
SELECT * FROM student;
-- 2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1.
SELECT subjectId,subjectName 
FROM subject
WHERE priority = 1;
-- 3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ năm sinh) ,
--  giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh.
SELECT studentId, studentName, (YEAR(CURRENT_DATE()) - YEAR(birthday)) AS age,
CASE WHEN gender = 0 THEN 'Nữ' ELSE 'Nam'END AS gender,address
FROM student;
-- 4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn Toán và sắp xếp theo điểm giảm dần.
  SELECT st.studentName, sub.subjectName, m.point
FROM student AS st
JOIN mark AS m ON st.studentId = m.studentId
JOIN subject AS sub ON m.subjectId = sub.subjectId
WHERE sub.subjectName = 'Toán' 
ORDER BY m.point DESC;

-- 5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).
SELECT 
	CASE WHEN gender = 0 THEN 'Nữ' ELSE 'Nam' END as 'giới tính',
    COUNT(*) as 'Số Lượng'
    FROM student 
    GROUP BY gender;
    
-- 6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm để tính toán) ,
-- bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình.
SELECT st.studentId,st.studentName,SUM(m.point) as 'Tổng Điểm',AVG(m.point) as 'Điểm Trung bình'
	FROM student as st
    JOIN mark as m ON st.studentId = m.studentId
    GROUP BY st.studentId,st.studentName;
    
-- Bài 4: Tạo View, Index, Procedure
-- 1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán
	CREATE VIEW student_view AS
    SELECT studentId,studentName,gender,address
    FROM student;
-- 2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh,điểm trung bình các môn học
CREATE VIEW AVERAGE_MARK_VIEW AS
SELECT st.studentId,st.studentName,AVG(m.point) AS aver_age_mark
FROM student as st
JOIN mark as m ON st.studentId = m.studentId
GROUP BY st.studentId,st.studentName;
-- 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT
CREATE INDEX idx_phoneNumber ON student(phoneNumber);
-- 4. Tạo các PROCEDURE sau:
-- - Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó.
delimiter &&
CREATE PROCEDURE PROC_INSERTSTUDENT(
IN studentId VARCHAR(4),
IN studentName VARCHAR(100),
IN birthday DATE,
IN gender INT,
IN address TEXT,
IN phoneNumber VARCHAR(45))
BEGIN
INSERT INTO student (studentId,studentName,birthday,gender,address,phoneNumber)
VALUES (studentId,studentName,birthday,gender,address,phoneNumber);
END;
&&
CALL PROC_INSERTSTUDENT('S011', 'Nguyen Van A', '1988-12-04',1,'Ha Noi', '904989876');
-- Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
delimiter &&
CREATE PROCEDURE PROC_UPDATESUBJECT( 
    IN subjectId VARCHAR(4),
    IN subjectName VARCHAR(45)
)
BEGIN
    UPDATE subject 
    SET subjectName = subjectName
    WHERE subjectId = subjectId;
END &&
-- - Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh và trả về số bản ghi đã xóa.
DELIMITER //
CREATE PROCEDURE PROC_DELETEMARK
(
    IN id VARCHAR(4),
    OUT deletedCount INT
)
BEGIN
    DELETE FROM MARK WHERE studentId = id;
    SET deletedCount = ROW_COUNT();
END //
DELIMITER ;




