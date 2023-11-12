create database car

use car

--Xử lý cột [Số km đã đi]
--Xóa 'km'
update [car_detail]
set [Số Km đã đi] = LEFT([Số Km đã đi], CHARINDEX(' ',[Số Km đã đi], CHARINDEX(' ',[Số Km đã đi]))) 

--Xóa dấu ',' ngăn cách các số
update [car_detail]
set [Số Km đã đi] =  REPLACE([Số Km đã đi], ',', '')

--Xử lý cột [Số cửa]
--Xóa 'cửa'
update [car_detail]
set [Số cửa] = LEFT([Số cửa], CHARINDEX(' ',[Số cửa], CHARINDEX(' ',[Số cửa])))

--Xử lý cột [Số chỗ ngồi]
--Xóa 'chỗ' 
update [car_detail]
set [Số chỗ ngồi] = LEFT([Số chỗ ngồi], CHARINDEX(' ',[Số chỗ ngồi], CHARINDEX(' ',[Số chỗ ngồi])))

--Xử lý cột [Màu nội thất]
--Xóa các giá trị '-' 
update [car_detail]
set [Màu nội thất] = REPLACE([Màu nội thất], '-', '')

--Thay các giá trị null thành 'Màu khác'
update [car_detail]
set [Màu nội thất] = N'Màu khác' where [Màu nội thất] = ''

--Xử lý cột [Màu ngoại thất]
--Xóa các giá trị '-'
update [car_detail]
set [Màu ngoại thất] = REPLACE([Màu ngoại thất], '-', '')

--Thay các giá trị null thành 'Màu khác'
update [car_detail]
set [Màu ngoại thất] = N'Màu khác' where [Màu ngoại thất] = ''

--Thêm cột [Loại máy]
alter table [car_detail]
add [Loại máy] nvarchar(10)

--Thêm cột [Giá xe]
alter table [car_detail]
add [Giá xe] money


--Tách cột [Động cơ] thành các loại máy
update [car_detail]
set [Loại máy] = 
	case
		when (len([Động cơ])-6) <=0 then [Động cơ]
		else left([Động cơ], len([Động cơ])-6)
	end
--select [Động cơ], [Loại máy] from Sheet1
--Xóa cột [URL]
alter table [car_detail]
drop column [URL] 

--Chuyển đổi giá 
select [Giá] from [car_detail] where [Giá] like N'%Tỷ___Triệu' 

update [car_detail]
set [Giá xe] = 
	case
		when [Giá] like N'%Tỷ%Triệu%' and left(right([Giá],9),3) >= 100 then 
		CAST(REPLACE(REPLACE(REPLACE(Giá, N' Tỷ', ''), N' Triệu', ''),' ','') AS INT)
		when [Giá] like N'%Tỷ%Triệu%' and left(right([Giá],9),3) < 100 then 
		REVERSE(STUFF(REVERSE(CAST(REPLACE(REPLACE(REPLACE(Giá, N' Tỷ', ''), N' Triệu', ''),' ','') AS INT)),3,0,'0'))
		when [Giá] like N'%Tỷ ' then (Cast(replace([Giá], N' Tỷ', '') as int))*1000
		else (Cast(replace([Giá], N' Triệu', '') as int))
	end

update [car_detail]
set [Giá xe] = [Giá xe]*1000000
--Xóa cột [Mô tả]
alter table [car_detail]
drop column [Mô tả]

--Xử lý cột [Dẫn động]
--Xóa các giá trị '-'
update [car_detail]
set [Dẫn động] = REPLACE([Dẫn động], '-', '')

--Thay giá trị null thành 'Khác'
update [car_detail]
set [Dẫn động] = N'Khác' where [Dẫn động] = ''

--Thay các giá trị null của cột [Loại máy] thành 'Khác'
update [car_detail]
set [Loại máy] = N'Khác' where [Loại máy] = '-'

--Thay các giá trị null của cột [Động cơ] thành 'Khác'
update [car_detail]
set [Động cơ] = N'Khác' where [Động cơ] = '-'

--Thay các giá trị null của cột [Hộp số] thành 'Khác'
update [car_detail]
set [Hộp số] = N'Khác' where [Hộp số] = '-'

--XỬ lý cột [Năm sản xuất]
ALTER TABLE [car_detail]
ALTER COLUMN [Năm sản xuất] nvarchar(10)
--thay giá trị null : Nếu là xe mới thì thay 2023, còn lại là 'Khác'
update [car_detail]
SET [Năm sản xuất] = 
    CASE 
        WHEN [Tình trạng] = N'Xe mới' THEN '2023'
        ELSE N'Khác'
    END
WHERE [Năm sản xuất] IS NULL



