use master
go
if exists (select * from sysdatabases where name = 'SmartLibraryDB')
	drop database SmartLibraryDB
go
create database SmartLibraryDB
go
use SmartLibraryDB
go
CREATE TABLE LOAISACH
(
  MaLoai CHAR(10) NOT NULL,
  TenLoai NVARCHAR(50) NOT NULL,
  PRIMARY KEY (MaLoai)
);

CREATE TABLE TACGIA
(
  MaTG CHAR(10) NOT NULL,
  TenTG NVARCHAR(50) NOT NULL,
  PRIMARY KEY (MaTG)
);

CREATE TABLE NHAXB
(
  MaNXB CHAR(10) NOT NULL,
  TenNXB NVARCHAR(50) NOT NULL,
  PRIMARY KEY (MaNXB)
);

CREATE TABLE BOPHAN
(
  MaBP CHAR(10) NOT NULL,
  TenBP NVARCHAR(50) NOT NULL,
  PRIMARY KEY (MaBP)
);

CREATE TABLE LOAIDOCGIA
(
  MaLoai CHAR(10) NOT NULL,
  TenLoai NVARCHAR(50) NOT NULL,
  PRIMARY KEY (MaLoai)
);

CREATE TABLE SACH
(
  MaSach CHAR(10) NOT NULL,
  TenSach NVARCHAR(50) NOT NULL,
  TriGia INT,
  NamXB DATE,
  SoLuongHienCo INT,
  TongSoLuong INT,
  MaNXB CHAR(10),
  MaLoai CHAR(10),
  MaTG CHAR(10),
  PRIMARY KEY (MaSach),
  FOREIGN KEY (MaNXB) REFERENCES NHAXB(MaNXB),
  FOREIGN KEY (MaLoai) REFERENCES LOAISACH(MaLoai),
  FOREIGN KEY (MaTG) REFERENCES TACGIA(MaTG)
);

CREATE TABLE NHANVIEN
(
  MaNV CHAR(10) NOT NULL,
  HoTen NVARCHAR(50) NOT NULL,
  NgaySinh DATE,
  DiaChi NVARCHAR(80),
  SDT CHAR(10),
  Email VARCHAR(50),
  NgayVaoLam DATE,
  MatKhau varbinary(8000),
  MaBP CHAR(10),
  PRIMARY KEY (MaNV),
  FOREIGN KEY (MaBP) REFERENCES BOPHAN(MaBP)
);

CREATE TABLE DOCGIA
(
  MaDG CHAR(10) NOT NULL,
  HoTen NVARCHAR(50) NOT NULL,
  NgaySinh DATE,
  Email VARCHAR(50),
  DiaChi NVARCHAR(80),
  SDT CHAR(10),
  NgayLapThe DATE,
  NgayHetHan DATE,
  MaLoai CHAR(10),
  PRIMARY KEY (MaDG),
  FOREIGN KEY (MaLoai) REFERENCES LOAIDOCGIA(MaLoai)
);

CREATE TABLE PHIEUKIEMKE
(
  MaPhieuKK CHAR(10) NOT NULL,
  NgayLap DATE,
  MaNV CHAR(10),
  PRIMARY KEY (MaPhieuKK),
  FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

CREATE TABLE CTPHIEUKK
(
  SoLuongKK INT,
  TinhTrang NVARCHAR(50),
  MaPhieuKK CHAR(10),
  MaSach CHAR(10),
  PRIMARY KEY (MaPhieuKK, MaSach),
  FOREIGN KEY (MaPhieuKK) REFERENCES PHIEUKIEMKE(MaPhieuKK),
  FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE SACH_TACGIA
(
  MaTG CHAR(10) NOT NULL,
  MaSach CHAR(10) NOT NULL,
  PRIMARY KEY (MaTG, MaSach),
  FOREIGN KEY (MaTG) REFERENCES TACGIA(MaTG),
  FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE PHIEUMUONTRA
(
  MaPhieu CHAR(10) NOT NULL,
  TinhTrang NVARCHAR(50),
  NgayMuon DATE,
  HanTra DATE,
  NgayTra DATE,
  MaDG CHAR(10),
  MaNV CHAR(10),
  PRIMARY KEY (MaPhieu),
  FOREIGN KEY (MaDG) REFERENCES DOCGIA(MaDG),
  FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

CREATE TABLE PHIEUTHUTIENPHAT
(
  MaPhieuThu CHAR(10) NOT NULL,
  SoTien INT,
  LyDo NVARCHAR(100),
  NgayLap DATE,
  MaPhieu CHAR(10),
  PRIMARY KEY (MaPhieuThu),
  FOREIGN KEY (MaPhieu) REFERENCES PHIEUMUONTRA(MaPhieu)
);

CREATE TABLE CTPHIEUMUONTRA
(
  SoLuongMuon INT,
  MaSach CHAR(10),
  MaPhieu CHAR(10),
  PRIMARY KEY (MaSach, MaPhieu),
  FOREIGN KEY (MaSach) REFERENCES SACH(MaSach),
  FOREIGN KEY (MaPhieu) REFERENCES PHIEUMUONTRA(MaPhieu)
);

-----------------------------
--thêm dữ liệu
insert into NHAXB values ('NXB001', N'Dân trí')
insert into NHAXB values ('NXB002', N'Kim Đồng')
insert into NHAXB values ('NXB003', N'Bloomsbury')

insert into LOAISACH values ('LS001', N'Tâm lý tình cảm')
insert into LOAISACH values ('LS002', N'Thiếu nhi')
insert into LOAISACH values ('LS003', N'Hư cấu kỳ ảo')

insert into TACGIA values ('TG001', N'Phan')
insert into TACGIA values ('TG002', N'Fujiko F Fujio')
insert into TACGIA values ('TG003', N'J. K. Rowling')

insert into SACH values ('S001', N'Trước khi chúng ta nói lời chia tay', 88000, '2024-02-17', 97, 100, 'NXB001', 'LS001', 'TG001') 
insert into SACH values ('S002', N'Doraemon', 20000, '2020-01-30', 100, 100, 'NXB002', 'LS002', 'TG002')
insert into SACH values ('S003', N'Harry Potter và Hòn đá Phù thủy', 150000, '1997-06-26', 100, 100, 'NXB003', 'LS003', 'TG003')

insert into SACH_TACGIA values ('TG001', 'S001')
insert into SACH_TACGIA values ('TG002', 'S002')
insert into SACH_TACGIA values ('TG003', 'S003')

insert into LOAIDOCGIA values ('LDG001', N'Theo tháng')
insert into LOAIDOCGIA values ('LDG002', N'Theo năm')

insert into DOCGIA values ('DG001', N'Nguyễn A', '2004-09-10', 'a@example.com', N'Address 1', '0909853877', '2024-06-01', '2024-09-01', 'LDG001' )
insert into DOCGIA values ('DG002', N'Thị B', '2001-02-11', 'b@example.com', N'Address 2', '0904533378', '2024-06-01', '2025-06-01', 'LDG002' )
insert into DOCGIA values ('DG003', N'Văn C', '1994-03-03', 'c@example.com', N'Address 3', '0908887433', '2024-01-03', '2024-04-03', 'LDG001')
insert into DOCGIA values ('DG004', N'Phạm D', '1996-04-04', 'd@example.com', N'Address 4', '0908882284', '2024-01-04', '2025-01-04', 'LDG002')

insert into BOPHAN values ('BPNVTT', N'Bộ phận quản lý')
insert into BOPHAN values ('BPNVTK', N'Bộ phận kho')
insert into BOPHAN values ('BPNVGD', N'Bộ phận giám đốc')

insert into NHANVIEN values ('NVTT001', N'Phạm Vân', '1998-07-30', 'TPHCM', '0919052855', 'phamvan@gmail.com', '2024-02-24', null, 'BPNVTT')
insert into NHANVIEN values ('NVTK001', N'Lê Huy', '1999-02-09', 'TPHCM', '0908527691', 'lehuy@gmail.com', '2024-02-24', null, 'BPNVTK')
insert into NHANVIEN values ('NVGD001', N'Nguyễn Khoa', '2004-06-30', 'TPHCM', '091063024', 'capy@gmail.com', '2024-01-01', null, 'BPNVGD')

insert into PHIEUKIEMKE values('PKK001', '20240701', 'NVTK001')
insert into CTPHIEUKK values(50, N'Hư hỏng', 'PKK001', 'S003')

insert into PHIEUMUONTRA values ('PMT001', N'Đã trả', '2024-07-01', '2024-07-08', '2024-07-07', 'DG001', 'NVTT001')
insert into PHIEUMUONTRA values ('PMT002', N'Đã trả', '2024-06-25', '2024-07-02', '2024-07-01', 'DG002', 'NVTT001')
insert into PHIEUMUONTRA values ('PMT003', N'Đã trả', '2024-06-25', '2024-07-02', '2024-07-05', 'DG003', 'NVTT001')
insert into PHIEUMUONTRA values ('PMT004', N'Đang mượn', '2024-07-10', '2024-07-17', null, 'DG004', 'NVTT001')

insert into CTPHIEUMUONTRA values (5, 'S002', 'PMT001')
insert into CTPHIEUMUONTRA values (1, 'S001', 'PMT002')
insert into CTPHIEUMUONTRA values (1, 'S001', 'PMT003')
insert into CTPHIEUMUONTRA values (3, 'S001', 'PMT004')
 
insert into PHIEUTHUTIENPHAT values ('PT001', 30000, N'Quá hạn', '2024-07-05','PMT003')

select * from NHAXB
select * from LOAISACH
select * from TACGIA
select * from SACH
select * from SACH_TACGIA
select * from LOAIDOCGIA
select * from DOCGIA
select * from BOPHAN
select * from NHANVIEN
select * from PHIEUMUONTRA
select * from CTPHIEUMUONTRA
select * from PHIEUTHUTIENPHAT
select * from PHIEUKIEMKE
select * from CTPHIEUKK

insert into NHANVIEN (MaNV,HoTen,MaBP,MatKhau) values ('NVTK002',N'Nguyễn Văn A','BPNVTK',ENCRYPTBYPASSPHRASE('NVTK002','123'))
insert into NHANVIEN (MaNV,HoTen,MaBP,MatKhau) values ('NVTT002',N'Nguyễn Văn B','BPNVTT',ENCRYPTBYPASSPHRASE('NVTT002','456'))
insert into NHANVIEN (MaNV,HoTen,MaBP,MatKhau) values ('NVGD002',N'Nguyễn Văn C','BPNVGD',ENCRYPTBYPASSPHRASE('NVGD002','789'))

use master
go
drop database SmartLibraryDB
-----------------------------
--ràng buộc check: ngày hết hạn phải sau ngày lập thẻ
alter table DOCGIA add constraint chkNHH check (NgayHetHan >= NgayLapThe)
go
insert into DOCGIA values ('DG005', N'Đặng E', '2004-06-30', 'e@example.com', N'TPHCM', '0930062004', '2024-06-01', '2024-05-01', 'LDG001')

-----------------------------
--store procedure: thêm, xoá, sửa độc giả
--thêm
create or alter proc sp_ThemDocGia
	@madg char(10),
	@hoten nvarchar(50),
	@ngaysinh date,
	@email varchar(50),
	@diachi nvarchar(80),
	@sdt char(10),
	@ngaylapthe date,
	@ngayhethan date,
	@maloai char(10)
as
begin
	insert into DOCGIA (MaDG, HoTen, NgaySinh, Email, DiaChi, SDT, NgayLapThe, NgayHetHan, MaLoai)
	values (@madg, @hoten, @ngaysinh, @email, @diachi, @sdt, @ngaylapthe, @ngayhethan, @maloai)
end
go
exec sp_ThemDocGia 'DG005', N'Đặng E', '2004-06-30', 'e@example.com', N'TPHCM', '0930062004', '2024-06-01', '2024-07-01', 'LDG001'

select * from DOCGIA

--xoá
create or alter proc sp_XoaDocGia @madg char(10)
as
begin
	delete from DOCGIA
	where MaDG = @madg
end
go
exec sp_XoaDocGia 'DG005'

--sửa
create or alter proc sp_SuaDocGia
	@madg char(10),
	--@hoten nvarchar(50),
	--@ngaysinh date,
	--@email varchar(50),
	--@diachi nvarchar(80),
	--@sdt char(10),
	--@ngaylapthe date,
	@ngayhethan date
	--@maloai char(10)
as
begin
	update DOCGIA
	set NgayHetHan = @ngayhethan
	where MaDG = @madg
end
go
exec sp_SuaDocGia 'DG005', '20250701'

--store procedure: tìm độc giả trả sách quá hạn và in ra số ngày trả trễ (NgayTra > HanTra) 
CREATE OR ALTER PROCEDURE sp_DocGiaTraTre
AS
BEGIN
    CREATE TABLE #DocGiaTraTre
    (
        MaDG CHAR(10),
        HoTen NVARCHAR(50),
        MaPhieu CHAR(10),
        NgayMuon DATE,
        HanTra DATE,
        NgayTra DATE,
        SoNgayQuaHan INT
    );

    INSERT INTO #DocGiaTraTre (MaDG, HoTen, MaPhieu, NgayMuon, HanTra, NgayTra, SoNgayQuaHan)
    SELECT 
        dg.MaDG, 
        dg.HoTen, 
        pmt.MaPhieu, 
        pmt.NgayMuon, 
        pmt.HanTra, 
        pmt.NgayTra,
        CASE 
            WHEN pmt.NgayTra IS NULL THEN DATEDIFF(DAY, pmt.HanTra, GETDATE())  
            ELSE DATEDIFF(DAY, pmt.HanTra, pmt.NgayTra)                         
        END AS SoNgayTraTre
    FROM 
        DOCGIA dg 
    JOIN 
        PHIEUMUONTRA pmt ON dg.MaDG = pmt.MaDG
    WHERE 
        (pmt.NgayTra IS NULL AND GETDATE() > pmt.HanTra) OR
        (pmt.NgayTra > pmt.HanTra);                         

    SELECT * FROM #DocGiaTraTre;

    DROP TABLE #DocGiaTraTre; 
END
go
exec sp_DocGiaTraTre

select * from PHIEUMUONTRA
select * from CTPHIEUMUONTRA

--store procedure: tìm sách được mượn nhiều nhất
create or alter proc sp_SachDuocMuonNhieuNhat 
as
begin
	create table #SACH
	(
		MaSach char(10),
		TenSach nvarchar(50),
		SoLuongMuon int
	)
	declare cr_Sach cursor forward_only for
	select top 1 s.MaSach, s.TenSach, sum(ct.SoLuongMuon)
	from SACH s join CTPHIEUMUONTRA ct on s.MaSach = ct.MaSach
	group by s.MaSach, s.TenSach	
	open cr_Sach
	declare @masach char(10), @tensach nvarchar(50), @soluongmuon int
	fetch next from cr_Sach into @masach, @tensach, @soluongmuon
	while @@FETCH_STATUS = 0
	begin
		insert into #SACH (MaSach, TenSach, SoLuongMuon) values (@masach, @tensach, @soluongmuon)
		fetch next from cr_Sach into @masach, @tensach, @soluongmuon
	end
	close cr_Sach
	deallocate cr_Sach
	select * from #SACH
end
go
exec sp_SachDuocMuonNhieuNhat

-- Truy vấn để kiểm tra thống kê sách mượn
SELECT s.MaSach, s.TenSach, SUM(ct.SoLuongMuon) 
FROM SACH s 
JOIN CTPHIEUMUONTRA ct ON s.MaSach = ct.MaSach 
GROUP BY s.MaSach, s.TenSach;

select * from sach
select * from ctphieumuontra
select * from Phieumuontra
select * from DocGia
select * from PhieuThuTienPhat
------------
CREATE OR ALTER PROCEDURE sp_ThongKeSachDuocMuon
AS
BEGIN
    SELECT s.MaSach, s.TenSach, SUM(ct.SoLuongMuon) AS SoLuongMuon
    FROM SACH s 
    JOIN CTPHIEUMUONTRA ct ON s.MaSach = ct.MaSach 
    GROUP BY s.MaSach, s.TenSach
END
GO
exec sp_ThongKeSachDuocMuon

--store procedure: cập nhật lại NgayHetHan của độc giả khi lập thẻ. LDG theo tháng thì NgayHetHan sẽ sau 3 tháng so với NgayLapThe và LDG theo năm thì NgayHetHan sẽ sau 1 năm so với NgayLapThe. 
create or alter proc sp_CapNhatNgayHetHan @madg char(10)
as
begin
	--theo tháng
	update DOCGIA
	set NgayHetHan = dateadd(MONTH, 3, NgayLapThe)
	from DOCGIA dg join LOAIDOCGIA ldg on dg.MaLDG = ldg.MaLDG
	where ldg.TenLDG = N'Theo tháng'
	and dg.MaDG = @madg
	--theo năm
	update DOCGIA
	set NgayHetHan = dateadd(YEAR, 1, NgayLapThe)
	from DOCGIA dg join LOAIDOCGIA ldg on dg.MaLDG = ldg.MaLDG
	where ldg.TenLDG = N'Theo năm'
	and dg.MaDG = @madg
end
go
--dùng trigger gọi lại thủ tục sp_CapNhatNgayHetHan để tự động cập nhật dữ liệu khi tạo mới hoặc chỉnh sửa
create or alter trigger tr_CapNhatNgayHetHan on DOCGIA after insert, update
as
begin
	declare @madg char(10)
	select @madg = MaDG from inserted
	exec sp_CapNhatNgayHetHan @madg
end

select * from LOAIDOCGIA
select * from DOCGIA
insert into DOCGIA values ('DG005', N'Đặng E', '2004-06-30', 'e@example.com', N'TPHCM', '0930062004', '2024-06-01', null, 'LDG001')
delete DOCGIA where MaDG = 'DG005'

------cập nhật SoLuongMuon khi mượn/ trả sách (dùng thủ tục + trigger)
--trigger: cập nhật lại số lượng hiện có trong bảng SACH khi TinhTrang trong PHIEUMUONTRA là Đang mượn thì SoLuongHienCo = SoLuongHienCo - SoLuongMuon trong CTPHIEUMUONTRA
CREATE OR ALTER TRIGGER trg_CapNhatSLMuonSach
ON CTPHIEUMUONTRA
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @MaPhieu CHAR(10), @MaSach CHAR(10), @SoLuongMuon INT, @sl int

    DECLARE cr_Insert CURSOR FOR
    SELECT i.MaPhieu, i.MaSach, i.SoLuongMuon
    FROM inserted i
    JOIN PHIEUMUONTRA pm ON i.MaPhieu = pm.MaPhieu
    WHERE pm.TinhTrang = N'Đang mượn'

    OPEN cr_Insert

    FETCH NEXT FROM cr_Insert INTO @MaPhieu, @MaSach, @SoLuongMuon

    WHILE @@FETCH_STATUS = 0
    BEGIN

        SELECT @sl = SUM(SoLuongMuon)
        FROM CTPHIEUMUONTRA
        WHERE MaPhieu = @MaPhieu

		IF @sl > 5
        BEGIN
            ROLLBACK TRANSACTION
            RAISERROR (N'Không thể mượn quá 5 cuốn sách trong cùng một phiếu mượn trả', 16, 1)
            RETURN
        END

        UPDATE SACH
        SET SoLuongHienCo = SoLuongHienCo - @SoLuongMuon
        WHERE MaSach = @MaSach

        FETCH NEXT FROM cr_Insert INTO @MaPhieu, @MaSach, @SoLuongMuon
    END

    CLOSE cr_Insert
    DEALLOCATE cr_Insert

    DECLARE cr_Delete CURSOR FOR
    SELECT d.MaPhieu, d.MaSach, d.SoLuongMuon
    FROM deleted d
    JOIN PHIEUMUONTRA pm ON d.MaPhieu = pm.MaPhieu
    WHERE pm.TinhTrang = N'Đang mượn'

    OPEN cr_Delete

    FETCH NEXT FROM cr_Delete INTO @MaPhieu, @MaSach, @SoLuongMuon

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE SACH
        SET SoLuongHienCo = SoLuongHienCo + @SoLuongMuon
        WHERE MaSach = @MaSach

        FETCH NEXT FROM cr_Delete INTO @MaPhieu, @MaSach, @SoLuongMuon
    END

    CLOSE cr_Delete
    DEALLOCATE cr_Delete

END

select * from PHIEUMUONTRA
select * from CTPHIEUMUONTRA
select * from SACH
insert into PHIEUMUONTRA values ('PMT005', N'Đang mượn', '2024-06-20', '2024-06-27', Null, 'DG002', 'NVTT001')
insert into CTPHIEUMUONTRA values (3, 'S002', 'PMT004')
insert into CTPHIEUMUONTRA values (5, 'S003', 'PMT005')
--------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_CapNhatSoLuongKhiTraSach @MaPhieu CHAR(10)
AS
BEGIN
    DECLARE @MaSach CHAR(10), @SoLuongMuon INT

    DECLARE cr_SLTra CURSOR FOR
    SELECT ctp.MaSach, ctp.SoLuongMuon
    FROM CTPHIEUMUONTRA ctp
    WHERE ctp.MaPhieu = @MaPhieu

    OPEN cr_SLTra

    FETCH NEXT FROM cr_SLTra INTO @MaSach, @SoLuongMuon

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE SACH
        SET SoLuongHienCo = SoLuongHienCo + @SoLuongMuon
        WHERE MaSach = @MaSach

        FETCH NEXT FROM cr_SLTra INTO @MaSach, @SoLuongMuon
    END

    CLOSE cr_SLTra
    DEALLOCATE cr_SLTra
END

CREATE OR ALTER TRIGGER trg_CapNhatSLTra
ON PHIEUMUONTRA for UPDATE
AS
BEGIN
    DECLARE @MaPhieu CHAR(10), @OldTinhTrang NVARCHAR(50), @NewTinhTrang NVARCHAR(50)

    SELECT @MaPhieu = inserted.MaPhieu, @OldTinhTrang = deleted.TinhTrang, @NewTinhTrang = inserted.TinhTrang
    FROM inserted JOIN deleted ON inserted.MaPhieu = deleted.MaPhieu

    IF @OldTinhTrang = N'Đang mượn' AND @NewTinhTrang = N'Đã trả'
    BEGIN
        EXEC sp_CapNhatSoLuongKhiTraSach @MaPhieu
    END
END
update	PHIEUMUONTRA
set		TinhTrang = N'Đã trả'
where	MaPhieu = 'PMT005'
-------------------------------
--trigger R1: một phiếu mượn trả không có quá 5 cuốn sách
create or alter trigger tr_R1 on CTPHIEUMUONTRA for insert, update
as
begin
	declare @sl int, @MaPhieu char(10)
    select @MaPhieu = MaPhieu from inserted
    select @sl = SUM(SoLuongMuon)
    from CTPHIEUMUONTRA
    where MaPhieu = @MaPhieu
    if @sl > 5
    begin
        rollback tran
        raiserror (N'Không thể mượn quá 5 cuốn sách trong cùng một phiếu mượn trả', 16, 1)
        return
    end
end

select * from PHIEUMUONTRA
select * from CTPHIEUMUONTRA

insert into PHIEUMUONTRA values ('PMT005', N'Đang mượn', '2024-07-17', '2024-07-17', null, 'DG001', 'NVTT001')
insert into CTPHIEUMUONTRA values (6, 'S002', 'PMT005')

delete CTPHIEUMUONTRA where MaPhieu = 'PMT005'
delete PHIEUMUONTRA where MaPhieu = 'PMT005'

--trigger R2: khi thêm sách mới thì tên sách không được trùng nhau
create or alter trigger tr_R2 on SACH for insert, update
as
begin
	declare @tensach nvarchar(50), @dem tinyint = 0
	select @tensach = TenSach from inserted
	select @dem = count(*) 
	from SACH 
	where TenSach = @tensach
	if @dem > 1
	begin
		rollback tran
		raiserror (N'Tên sách này đã tồn tại', 16, 1)
		return
	end
end

select * from SACH
insert into SACH values ('S004', N'Doraemon', 22000, '2020-01-30', 100, 100, 'NXB002', 'LS002', 'TG002')
delete SACH where MaSach = 'S004'

--trigger R3: sách được mượn phải tồn tại
create or alter trigger tr_R3 on CTPHIEUMUONTRA for insert, update
as
begin
	declare @masach char(10)
	select @masach = MaSach from inserted
	if not exists (select * from SACH where MaSach = @masach)
	begin
		rollback transaction
		raiserror(N'Sách này không tồn tại', 16, 1)
		return
	end
end

select * from SACH
select * from PHIEUMUONTRA
select * from CTPHIEUMUONTRA

insert into PHIEUMUONTRA values ('PMT006', N'Đang mượn', '2024-06-20', '2024-06-27', null, 'DG001', 'NVTT001')
insert into CTPHIEUMUONTRA values (2, 'S004', 'PMT006') 

delete PHIEUMUONTRA where MaPhieu = 'PMT005'
delete CTPHIEUMUONTRA where MaPhieu = 'PMT005'

--trigger R4: TinhTrang là đang mượn, NgayMuon là ngày hiện tại và HanTra là sau 7 ngày so với NgayMuon khi lập phiếu thành công
create or alter trigger tr_R4 on PHIEUMUONTRA after insert
as
begin
    update PHIEUMUONTRA
    set 
		TinhTrang = N'Đang mượn',
        NgayMuon = cast(getdate() as date),
        HanTra = dateadd(day, 7, cast(getdate() as date))
    where MaPhieu in (select MaPhieu from inserted);
end

select * from PHIEUMUONTRA
insert into PHIEUMUONTRA values ('PMT007', null, null, null, null, 'DG001', 'NVTT001')
delete PHIEUMUONTRA where MaPhieu = 'PMT005'

-----------------------------(+)
--mã hoá mật khẩu của nhân viên
insert into BOPHAN values ('PBNVK',N'Nhân viên Kho')
insert into NHANVIEN (MaNV,HoTen,MaBP,MatKhau) values ('NV1',N'Nguyễn Văn A','PBNVK',ENCRYPTBYPASSPHRASE('NV1','123'))

select* from NHANVIEN

--backup full
BACKUP DATABASE SmartLibraryDB
TO DISK  = 'E:\SmartLibraryFull.bak'

use SmartLibraryDB
insert into NHANVIEN (MaNV,HoTen,MaBP,MatKhau) values ('NV005',N'Nguyễn Thu E','PBNVK',ENCRYPTBYPASSPHRASE('NV005','987'))

--backup diff
BACKUP DATABASE SmartLibraryDB
TO DISK = 'E:\SmartLibraryDiff.bak'
WITH DIFFERENTIAL

use master
go
if exists (select * from sysdatabases where name = 'SmartLibraryDB')
	drop database SmartLibraryDB

--khoi phuc full
restore DATABASE SmartLibraryDB
from DISK = 'E:\SmartLibraryFull.bak'
with norecovery

--khoi phuc diff
restore DATABASE SmartLibrary
from DISK = 'E:\SmartLibraryDiff.bak'
with recovery

