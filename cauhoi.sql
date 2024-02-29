#QUAN LY NHAN SU
-- 1.Hiển thị thông tin của những nhân viên ở phòng số 5
	 Select * from nhanvien where pgh=5;

-- 2.Hiển thị mã nhân viên, họ nhân viên, tên lót và tên nhân viên của những nhân viên ở phòng số 5 và có lương >= 3000
	SELECT manv,honv,tenlot,tennv FROM nhanvien WHERE pgh=5 and luong>=3000;

-- 3.Hiển thị mã nhân viên, tên nhân viên của những nhân viên có lương từ 2000 đến 8000
	SELECT manv,tennv
	FROM nhanvien
	WHERE luong BETWEEN 2000 AND 8000;

-- 4.Hiển thị thông tin của những nhân viên ở địa chỉ có tên đường là Nguyễn
	SELECT *
	FROM nhanvien
	WHERE diachi like 'Nguyễn %';

-- 5.Cho biết số lượng nhân viên
	SELECT count(*) as soluong
	FROM nhanvien;

-- 6.Cho biết số lượng nhân viên trong từng phòng ban
	SELECT pgh as phongBan, count(*) as soLuong
	FROM nhanvien
	GROUP BY pgh;

-- 7.Hiển thị thông tin về mã nhân viên, tên nhân viên và tên phòng ban ở phòng kế toán
	SELECT manv,tennv,tenpgh
	FROM nhanvien
	JOIN phongban 
	ON nhanvien.pgh = phongban.pgh
	WHERE phongban.tenpgh = 'Kế toán';

-- 8.Tìm thông tin của nhân viên làm từ 2 đề án trở lên
	SELECT * 
	FROM nhanvien
	WHERE manv IN (
		SELECT phancong.manv
		FROM phancong
		GROUP BY phancong.manv
		HAVING COUNT(phancong.manv)>=2
	);
    
#THUC TAP
-- 1.Đưa ra thông tin gồm mã số, họ tênvà tên khoa của tất cả các giảng viên
	SELECT Magv,Hotengv,Tenkhoa
    from tblgiangvien as gv, tblkhoa as k
    where gv.Makhoa = k.Makhoa;
    
-- 2.Đưa ra thông tin gồm mã số, họ tênvà tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’
	SELECT Magv,Hotengv,Tenkhoa
    from tblgiangvien as gv
    join tblkhoa as k
    on gv.Makhoa = k.Makhoa
    where k.TenKhoa = 'Dia ly va QLTN';

-- 3.Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
	select count(*)
    from tblsinhvien as sv
    join tblkhoa as k
    on sv.Makhoa = k.Makhoa
    where k.Tenkhoa = 'CONG NGHE SINH HOC'
    group by sv.Makhoa;
    
-- 4.Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’    
    select masv,hotensv,namsinh, YEAR(NOW()) - namsinh as tuoi
    from tblsinhvien 
    where makhoa in (select makhoa from tblkhoa where tenkhoa like 'TOAN');
    
-- 5.Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
	select count(gv.Makhoa)
    from tblgiangvien as gv, tblkhoa as k
    where gv.Makhoa = k.Makhoa and k.Tenkhoa = 'CONG NGHE SINH HOC' 
    group by gv.Makhoa;
    
-- 6.Cho biết thông tin về sinh viên không tham gia thực tập
	select sv.*
    from tblsinhvien as sv
    left join tblhuongdan as hd
    on sv.Masv = hd.Masv
    where hd.Madt is null;

-- 7.Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
	select k.Makhoa,k.Tenkhoa,count(k.MaKhoa) as soluonggiangvien
    from tblkhoa as k
    join tblgiangvien as gv
    on k.Makhoa = gv.Makhoa
    group by k.Makhoa;
	
-- 8.Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
	select k.Dienthoai
    from tblsinhvien as sv
    join tblkhoa as k on sv.Makhoa = k.Makhoa
    where sv.Hotensv = 'Le van son';
    
-- 9.Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
	select dt.Madt, dt.Tendt
    from tblhuongdan as hd
    join tbldetai as dt on hd.Madt = dt.Madt
    join tblgiangvien as gv on hd.Magv = gv.Magv
    where gv.Hotengv = 'Le Thi Ly'
    group by Madt;

-- 10.Cho biết tên đề tài không có sinh viên nào thực tập
	select dt.Madt, dt.Tendt
    from tbldetai as dt
    left join tblhuongdan as hd on dt.Madt = hd.Madt
    where hd.Masv is null;
    
-- 11.Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
    select gv.Magv, gv.Hotengv, k.Tenkhoa
    from tblgiangvien as gv
    join tblkhoa as k on gv.Makhoa = k.Makhoa
    where gv.Magv in (
		select Magv
        from tblhuongdan as hd
        group by Magv
        having count(Magv) >= 2
    );
    
-- 12.Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
	select dt.Madt, dt.Tendt
    from tbldetai as dt
    where dt.Kinhphi = (
		select max(Kinhphi)
        from tbldetai
    );
    
-- 13.Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
	select *
    from tbldetai as dt
    join tblhuongdan as hd on dt.Madt = hd.Madt
    group by hd.Madt
    having count(hd.Madt)>=2;
    
-- 14.Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
	select sv.Masv, sv.Hotensv, hd.KetQua
    from tblsinhvien as sv
    join tblkhoa as k on sv.Makhoa = k.Makhoa
    join tblhuongdan as hd on sv.Masv = hd.Masv
    where k.Tenkhoa like 'Dia ly va QLTN';

-- 15.Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
	select k.TenKhoa, count(k.Makhoa) as soluong
    from tblkhoa as k
    join tblsinhvien as sv on k.MaKhoa = sv.Makhoa
	group by k.Makhoa;

-- 16.Cho biết thông tin về các sinh viên thực tập tại quê nhà
	select sv.*
    from tblsinhvien as sv
    join tblhuongdan as hd on sv.Masv = hd.Masv
    join tbldetai as dt on hd.Madt = dt.Madt
    where sv.Quequan = dt.Noithuctap;

-- 17.Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
	select sv.*
    from tblsinhvien as sv
    left join tblhuongdan as hd on sv.Masv = hd.Masv
    where hd.KetQua is null

-- 18.Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng.
	
    
