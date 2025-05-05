﻿create database QuanLyXe2;
use QuanLyXe2;

INSERT INTO danh_muc(ten_danh_muc, mo_ta, loai)
VALUES
(N'Sedan', N'Dòng xe sedan phổ biến, phù hợp cho gia đình và cá nhân', N'xe'),
(N'SUV', N'Dòng xe SUV đa dụng, phù hợp cho mọi địa hình', N'xe'),
(N'Bán tải', N'Dòng xe bán tải mạnh mẽ, phù hợp cho công việc và giải trí', N'xe'),
(N'Xe điện', N'Dòng xe thân thiện với môi trường, sử dụng động cơ điện', N'xe'),
(N'Hatchback', N'Dòng xe nhỏ gọn, phù hợp cho đô thị', N'xe'),
(N'Coupe', N'Dòng xe thể thao, thiết kế 2 cửa', N'xe'),
(N'MPV', N'Dòng xe đa dụng, nhiều chỗ ngồi, phù hợp cho gia đình lớn', N'xe'),
(N'Xe sang', N'Dòng xe cao cấp, sang trọng, dành cho giới thượng lưu', N'xe'),
(N'Xe thể thao', N'Dòng xe hiệu suất cao, thiết kế thể thao', N'xe'),
(N'Xe cổ điển', N'Dòng xe cổ điển, phục vụ sưu tầm và giải trí', N'xe'),
(N'Camera hành trình', N'Ghi lại hành trình di chuyển, hỗ trợ lái xe an toàn', N'phu_kien'),
(N'Cảm biến áp suất lốp', N'Giúp kiểm soát áp suất lốp, đảm bảo an toàn khi lái xe', N'phu_kien'),
(N'Bọc ghế da', N'Tăng tính thẩm mỹ và bảo vệ ghế xe khỏi mài mòn', N'phu_kien'),
(N'Thanh giá nóc', N'Hỗ trợ chở hàng trên nóc xe, tiện lợi cho các chuyến đi xa', N'phu_kien'),
(N'Bơm lốp ô tô', N'Dụng cụ bơm lốp khẩn cấp, tiện lợi khi đi đường dài', N'phu_kien'),
(N'Gạt mưa', N'Gạt nước kính chắn gió, đảm bảo tầm nhìn khi trời mưa', N'phu_kien'),
(N'Nước hoa ô tô', N'Tạo không gian thơm mát, dễ chịu khi lái xe', N'phu_kien'),
(N'Màn hình giải trí', N'Giải trí đa phương tiện, hỗ trợ kết nối điện thoại và GPS', N'phu_kien'),
(N'Tấm che nắng', N'Giảm nhiệt độ trong xe, bảo vệ nội thất khỏi ánh nắng mặt trời', N'phu_kien'),
(N'Bạt phủ xe', N'Bảo vệ xe khỏi bụi bẩn, nắng mưa khi đỗ xe ngoài trời', N'phu_kien');

INSERT INTO san_pham (ten_san_pham, so_ghe, truyen_dong, nhien_lieu, dia_diem_lay_xe, hang_xe, gia, so_luong_trong_kho, CategoryID, ngay_san_xuat, bao_hanh, anh_dai_dien)
(N'Sedan', N'Dòng xe sedan phổ biến, phù hợp cho gia đình và cá nhân'),
(N'SUV', N'Dòng xe SUV đa dụng, phù hợp cho mọi địa hình'),
(N'Bán tải', N'Dòng xe bán tải mạnh mẽ, phù hợp cho công việc và giải trí'),
(N'Xe điện', N'Dòng xe thân thiện với môi trường, sử dụng động cơ điện'),
(N'Hatchback', N'Dòng xe nhỏ gọn, phù hợp cho đô thị'),
(N'Coupe', N'Dòng xe thể thao, thiết kế 2 cửa'),
(N'MPV', N'Dòng xe đa dụng, nhiều chỗ ngồi, phù hợp cho gia đình lớn'),
(N'Xe sang', N'Dòng xe cao cấp, sang trọng, dành cho giới thượng lưu'),
(N'Xe thể thao', N'Dòng xe hiệu suất cao, thiết kế thể thao'),
(N'Xe cổ điển', N'Dòng xe cổ điển, phục vụ sưu tầm và giải trí'),
(N'Camera hành trình', N'Ghi lại hành trình di chuyển, hỗ trợ lái xe an toàn'),
(N'Cảm biến áp suất lốp', N'Giúp kiểm soát áp suất lốp, đảm bảo an toàn khi lái xe'),
(N'Bọc ghế da', N'Tăng tính thẩm mỹ và bảo vệ ghế xe khỏi mài mòn'),
( N'Thanh giá nóc', N'Hỗ trợ chở hàng trên nóc xe, tiện lợi cho các chuyến đi xa'),
(N'Bơm lốp ô tô', N'Dụng cụ bơm lốp khẩn cấp, tiện lợi khi đi đường dài'),
(N'Gạt mưa', N'Gạt nước kính chắn gió, đảm bảo tầm nhìn khi trời mưa'),
(N'Nước hoa ô tô', N'Tạo không gian thơm mát, dễ chịu khi lái xe'),
(N'Màn hình giải trí', N'Giải trí đa phương tiện, hỗ trợ kết nối điện thoại và GPS'),
(N'Tấm che nắng', N'Giảm nhiệt độ trong xe, bảo vệ nội thất khỏi ánh nắng mặt trời'),
(N'Bạt phủ xe', N'Bảo vệ xe khỏi bụi bẩn, nắng mưa khi đỗ xe ngoài trời');
INSERT INTO san_pham 
(ten_san_pham, so_ghe, truyen_dong, nhien_lieu, dia_diem_lay_xe, hang_xe, gia, so_luong_trong_kho, CategoryID, ngay_san_xuat, bao_hanh, anh_dai_dien, mota)
VALUES
(N'Xe Toyota Camry 2023', 5, N'Tự động', N'Xăng', N'Hà Nội', N'Toyota', 1200000000.00, 10, 2, '2023-01-01', N'3 năm', N'ToyotaCamry2023.jpg', 
N'Toyota Camry 2023 là mẫu sedan hạng D nổi bật của thương hiệu Toyota, nổi bật với thiết kế hiện đại, tiện nghi vượt trội và công nghệ tiên tiến. Phiên bản 2023 tiếp tục kế thừa và phát huy những giá trị cốt lõi của dòng xe này, mang đến cho người dùng một trải nghiệm hoàn hảo với khả năng vận hành mượt mà, không gian nội thất rộng rãi và cảm giác lái thoải mái.

Với thiết kế ngoại thất thanh thoát, lưới tản nhiệt lớn và đèn pha LED sắc nét, Camry 2023 toát lên vẻ sang trọng và thể thao. Bên trong, nội thất được bọc da cao cấp, màn hình giải trí cảm ứng hiện đại cùng hệ thống âm thanh JBL mang lại không gian thoải mái, tiện nghi cho người sử dụng. Xe còn trang bị nhiều tính năng an toàn tiên tiến như hệ thống cảnh báo điểm mù, cảnh báo va chạm sớm, hỗ trợ giữ làn đường và kiểm soát hành trình thích ứng.

Về mặt hiệu suất, Camry 2023 có các lựa chọn động cơ mạnh mẽ nhưng tiết kiệm nhiên liệu, với khả năng vận hành êm ái trên mọi loại địa hình. Mẫu xe này không chỉ là một phương tiện di chuyển mà còn là biểu tượng của sự thành đạt và phong cách sống hiện đại, xứng đáng là sự lựa chọn hoàn hảo cho những ai tìm kiếm sự sang trọng và bền bỉ.'),

(N'Xe Honda CR-V 2023', 7, N'Tự động', N'Xăng', N'Hồ Chí Minh', N'Honda', 1500000000.00, 5, 2, '2023-02-01', N'5 năm', N'HondaCR-V2023.jpg', 
N'Honda CR-V 2023 là mẫu SUV cỡ trung nổi bật của Honda, mang thiết kế hiện đại, nội thất rộng rãi và nhiều công nghệ an toàn tiên tiến. Phiên bản mới sở hữu diện mạo khỏe khoắn hơn với lưới tản nhiệt lớn, đèn pha LED sắc sảo và các đường gân dập nổi dọc thân xe, tạo cảm giác thể thao và sang trọng.

Bên trong, khoang nội thất được bố trí khoa học với không gian thoải mái cho cả gia đình. Chất liệu cao cấp, ghế ngồi êm ái, màn hình giải trí trung tâm hỗ trợ Apple CarPlay/Android Auto, cùng với nhiều tiện ích như điều hòa tự động hai vùng, phanh tay điện tử và cửa sổ trời toàn cảnh mang đến trải nghiệm dễ chịu khi di chuyển.

Về vận hành, CR-V 2023 sử dụng động cơ 1.5L VTEC Turbo mạnh mẽ nhưng tiết kiệm nhiên liệu, kết hợp hộp số CVT êm ái. Hệ thống treo được tinh chỉnh để mang lại cảm giác lái ổn định, phù hợp cả đô thị và đường dài.

Xe còn tích hợp gói an toàn Honda Sensing gồm cảnh báo va chạm, giữ làn đường, kiểm soát hành trình chủ động và hỗ trợ phanh khẩn cấp, nâng cao mức độ an toàn cho người lái và hành khách.

Honda CR-V 2023 là lựa chọn lý tưởng cho những gia đình cần một mẫu SUV hiện đại, tiện nghi và đáng tin cậy trong mọi hành trình.'),

(N'Xe Ford Ranger 2023', 5, N'Số sàn', N'Dầu', N'Đà Nẵng', N'Ford', 900000000.00, 8, 3, '2023-03-01', N'4 năm', N'FordRanger2023.jpeg', 
N'Ford Ranger 2023 là mẫu bán tải thế hệ mới của Ford, nổi bật với thiết kế mạnh mẽ, công nghệ hiện đại và khả năng vận hành linh hoạt. Phiên bản 2023 được nâng cấp toàn diện, từ ngoại hình đến nội thất, mang đến trải nghiệm lái xe vượt trội cho cả công việc và giải trí.

Về thiết kế, Ranger 2023 sở hữu ngoại hình cứng cáp với lưới tản nhiệt lớn, đèn pha LED sắc nét và thân xe rộng rãi, tạo nên vẻ ngoài mạnh mẽ và hiện đại. Nội thất được trang bị tiện nghi với màn hình cảm ứng trung tâm, hệ thống giải trí SYNC 4, hỗ trợ kết nối Apple CarPlay và Android Auto, cùng với không gian cabin rộng rãi và thoải mái.

Về hiệu suất, Ford Ranger 2023 cung cấp nhiều tùy chọn động cơ, bao gồm động cơ diesel 2.0L turbo đơn và turbo kép, với công suất từ 170 đến 210 mã lực, kết hợp với hộp số tự động 6 cấp hoặc 10 cấp, tùy phiên bản. Hệ thống dẫn động 4x4 cùng khả năng gài cầu điện giúp xe vận hành ổn định trên nhiều địa hình khác nhau.'),


(N'Xe Mazda CX-5 2023', 5, N'Tự động', N'Xăng', N'Cần Thơ', N'Mazda', 1300000000.00, 6, 2, '2023-05-01', N'5 năm', N'MazdaCX-52023.jpg', 
N'Mazda CX-5 2023 là mẫu SUV 5 chỗ nổi bật trong phân khúc với thiết kế hiện đại, tinh tế theo ngôn ngữ KODO đặc trưng của hãng Mazda. Ngoại thất xe sở hữu những đường nét sắc sảo, lưới tản nhiệt dạng tổ ong kết hợp cụm đèn LED mảnh tạo cảm giác thể thao và sang trọng. Xe có kích thước tổng thể hài hòa, phù hợp cả di chuyển trong phố lẫn trên đường trường.

Không gian nội thất của CX-5 được trau chuốt với vật liệu cao cấp, bảng điều khiển trung tâm được bố trí hợp lý, cùng với ghế ngồi bọc da và hệ thống thông tin giải trí hiện đại tích hợp Apple CarPlay và Android Auto. Khoang cabin yên tĩnh, rộng rãi, mang lại cảm giác thoải mái cho cả người lái lẫn hành khách.

Về vận hành, Mazda CX-5 2023 trang bị động cơ xăng SkyActiv mạnh mẽ, tiết kiệm nhiên liệu. Xe sử dụng hộp số tự động 6 cấp cùng hệ thống treo tối ưu giúp mang lại cảm giác lái mượt mà, ổn định. Các tính năng an toàn như phanh ABS, cân bằng điện tử, hỗ trợ khởi hành ngang dốc và hệ thống camera lùi đều được tích hợp, nâng cao sự an tâm khi điều khiển.'),

(N'Xe VinFast VF e34', 5, N'Tự động', N'Điện', N'Hà Nội', N'VinFast', 800000000.00, 15, 3, '2023-06-01', N'7 năm', N'VinFastVFe34.jpg', 
N'VinFast VF e34 2023 là mẫu SUV điện đầu tiên của Việt Nam, thuộc phân khúc C, được thiết kế hiện đại với ngôn ngữ "Dynamic Balance" – cân bằng động. Xe có kích thước tổng thể dài 4.300 mm, rộng 1.793 mm, cao 1.613 mm và chiều dài cơ sở 2.610 mm, mang đến không gian nội thất rộng rãi và thoải mái cho hành khách.
VF e34 được trang bị động cơ điện công suất 110 kW (tương đương 147 mã lực) và mô-men xoắn cực đại 242 Nm, kết hợp với hệ dẫn động cầu trước. Hệ thống treo trước dạng MacPherson và treo sau dạng thanh xoắn giúp xe vận hành ổn định và linh hoạt trên nhiều loại địa hình.'),

(N'Xe Kia Seltos 2023', 5, N'Tự động', N'Xăng', N'Hồ Chí Minh', N'Kia', 950000000.00, 9, 2, '2023-07-01', N'5 năm', N'KiaSeltos2023.jpg', 
N'Kia Seltos 2023 là mẫu SUV đô thị cỡ B nổi bật với thiết kế trẻ trung, năng động và đậm chất thể thao. Xe sở hữu ngoại hình mạnh mẽ với lưới tản nhiệt dạng mũi hổ đặc trưng, cụm đèn LED sắc sảo cùng các chi tiết tạo hình góc cạnh giúp tăng tính nhận diện và sự cuốn hút cho người dùng trẻ tuổi.

Không gian nội thất của Kia Seltos được thiết kế thông minh, tận dụng tối đa diện tích để mang lại sự rộng rãi và thoải mái cho cả người lái và hành khách. Bảng điều khiển trung tâm hiện đại với màn hình cảm ứng lớn, hỗ trợ kết nối Apple CarPlay, Android Auto, Bluetooth, cùng hệ thống âm thanh chất lượng. Các chi tiết nội thất được hoàn thiện tốt, kết hợp giữa chất liệu da và nhựa cao cấp.

Về vận hành, Seltos 2023 sử dụng động cơ xăng 1.4L tăng áp hoặc 1.6L hút khí tự nhiên, tùy từng phiên bản, đi kèm hộp số tự động hoặc hộp số vô cấp CVT. Xe mang đến trải nghiệm lái ổn định, mượt mà và tiết kiệm nhiên liệu. Hệ thống treo được tinh chỉnh cho cảm giác chắc chắn, phù hợp cả đường phố lẫn đi xa.'),

(N'Xe Mercedes-Benz C200 2023', 5, N'Tự động', N'Xăng', N'Hà Nội', N'Mercedes-Benz', 2500000000.00, 3, 3, '2023-08-01', N'6 năm', N'Mercedes-BenzC2002023.jpg', 
N'Mercedes-Benz C200 2023 là mẫu sedan hạng sang cỡ nhỏ, nổi bật với thiết kế hiện đại và công nghệ tiên tiến. Xe có kích thước tổng thể dài 4.751 mm, rộng 1.890 mm, cao 1.437 mm và chiều dài cơ sở 2.865 mm, mang đến không gian nội thất rộng rãi và thoải mái cho hành khách.

Nội thất của C200 2023 được thiết kế sang trọng với các vật liệu cao cấp như da và gỗ, cùng hệ thống giải trí hiện đại. Bảng đồng hồ kỹ thuật số 12,3 inch và màn hình trung tâm 11,9 inch đặt dọc tạo cảm giác công nghệ và tiện nghi.

Về vận hành, xe trang bị động cơ xăng I4 1.5L tăng áp, công suất 204 mã lực tại 5.800–6.100 vòng/phút, mô-men xoắn cực đại 300 Nm tại 1.800–4.000 vòng/phút, kết hợp với hộp số tự động 9 cấp 9G-TRONIC và hệ dẫn động cầu sau. Khả năng tăng tốc từ 0–100 km/h trong 7,3 giây và tốc độ tối đa đạt 246 km/h.'),

(N'Xe BMW X5 2023', 5, N'Tự động', N'Xăng', N'Hồ Chí Minh', N'BMW', 3500000000.00, 2, 2, '2023-09-01', N'6 năm', N'BMWX52023.jpg', 
N'BMW X5 2023 là mẫu SUV hạng sang cỡ trung, nổi bật với thiết kế mạnh mẽ và hiện đại. Xe có kích thước tổng thể dài 4.922 mm, rộng 2.004 mm, cao 1.745 mm và chiều dài cơ sở 2.975 mm, mang đến không gian nội thất rộng rãi và thoải mái cho hành khách.
Nội thất của BMW X5 2023 được trang bị các vật liệu cao cấp như da và gỗ, cùng hệ thống giải trí hiện đại với màn hình cảm ứng trung tâm, hỗ trợ kết nối Apple CarPlay và Android Auto. Các tiện ích như điều hòa tự động bốn vùng, hệ thống âm thanh cao cấp và ghế ngồi chỉnh điện mang lại sự tiện nghi tối đa cho người sử dụng.
Về vận hành, xe sử dụng động cơ xăng I6 TwinPower Turbo 3.0L, công suất 340 mã lực và mô-men xoắn cực đại 450 Nm, kết hợp với hộp số tự động 8 cấp STEPTRONIC và hệ dẫn động 4 bánh toàn thời gian. Khả năng tăng tốc từ 0–100 km/h trong 5,5 giây và tốc độ tối đa đạt 243 km/h.'),

(N'Xe Hyundai Tucson 2023', 5, N'Tự động', N'Xăng', N'Hải Phòng', N'Hyundai', 1100000000.00, 7, 3, '2023-04-01', N'5 năm', N'HyundaiTucson2023.jpg', 
N'Hyundai Tucson 2023 gây ấn tượng với thiết kế sắc sảo, động cơ mạnh mẽ và nội thất hiện đại. Xe trang bị màn hình kép 10.25 inch, hỗ trợ Apple CarPlay, camera 360 và hệ thống hỗ trợ lái thông minh. Rất phù hợp cho người trẻ năng động và gia đình nhỏ.'),


(N'Xe Audi Q7 2023', 7, N'Tự động', N'Xăng', N'Đà Nẵng', N'Audi', 4000000000.00, 1, 2, '2023-10-01', N'6 năm', N'AudiQ72023.jpg', 
N'Audi Q7 2023 là mẫu SUV hạng sang cỡ lớn, nổi bật với thiết kế hiện đại và công nghệ tiên tiến. Xe có kích thước tổng thể dài 5.064 mm, rộng 1.970 mm, cao 1.741 mm và chiều dài cơ sở 2.999 mm, mang đến không gian nội thất rộng rãi và thoải mái cho hành khách.

Nội thất của Audi Q7 2023 được thiết kế sang trọng với các vật liệu cao cấp như da và gỗ, cùng hệ thống giải trí hiện đại với màn hình cảm ứng trung tâm, hỗ trợ kết nối Apple CarPlay và Android Auto. Các tiện ích như điều hòa tự động bốn vùng, hệ thống âm thanh cao cấp và ghế ngồi chỉnh điện mang lại sự tiện nghi tối đa cho người sử dụng.

Về vận hành, xe sử dụng động cơ xăng 2.0L tăng áp, công suất 252 mã lực tại 5.000–6.000 vòng/phút, mô-men xoắn cực đại 370 Nm tại 1.600–4.500 vòng/phút, kết hợp với hộp số tự động 8 cấp Tiptronic và hệ dẫn động 4 bánh toàn thời gian quattro. Khả năng tăng tốc từ 0–100 km/h trong 7,3 giây và tốc độ tối đa đạt 250 km/h.');


INSERT INTO nhan_vien(ten_nhan_vien, email, so_dien_thoai, mat_khau, vai_tro)
VALUES 
(N'Nguyễn Văn A', 'nva@example.com', 123456789, 'password123', 1), -- Quản lý
(N'Trần Thị B', 'ttb@example.com', 987654321, 'password456', 1), -- Nhân viên bình thường
(N'Lê Văn C', 'lvc@example.com', 555555555, 'password789', 1), -- Nhân viên bình thường
(N'Phạm Thị D', 'ptd@example.com', 111111111, 'password101', 1); -- Quản lý

-- Chèn dữ liệu mẫu
INSERT INTO ma_khuyen_mai(ma_khuyen_mai, phan_tram_giam, han_su_dung)
VALUES 
('SUMMER2023', 10.50, '2023-12-31'), -- Giảm 10.5%, hết hạn vào 31/12/2023
('FALLSALE', 15.00, '2023-11-15'), -- Giảm 15%, hết hạn vào 15/11/2023
('WINTER2024', 20.00, '2024-02-28'), -- Giảm 20%, hết hạn vào 28/02/2024
('NEWYEAR2024', 25.00, '2024-01-31'); -- Giảm 25%, hết hạn vào 31/01/2024

INSERT INTO khach_hang (ten_khach_hang, email, so_dien_thoai, dia_chi, mat_khau, vai_tro)
VALUES
('Nguyen Van A', 'nguyenvana@example.com', '0912345678', '123 Đường ABC, Quận 1, TP.HCM', 'password123', 0),
('Tran Thi B', 'tranthib@example.com', '0912345679', '456 Đường XYZ, Quận 2, TP.HCM', 'password123', 0),
('Le Van C', 'levanc@example.com', '0912345680', '789 Đường DEF, Quận 3, TP.HCM', 'password123', 0),
('Pham Thi D', 'phamthid@example.com', '0912345681', '321 Đường GHI, Quận 4, TP.HCM', 'password123', 0),
('Hoang Van E', 'hoangvane@example.com', '0912345682', '654 Đường JKL, Quận 5, TP.HCM', 'password123', 0),
('Vu Thi F', 'vuthif@example.com', '0912345683', '987 Đường MNO, Quận 6, TP.HCM', 'password123', 0),
('Do Van G', 'dovang@example.com', '0912345684', '111 Đường PQR, Quận 7, TP.HCM', 'password123', 0),
('Mai Thi H', 'maithih@example.com', '0912345685', '222 Đường STU, Quận 8, TP.HCM', 'password123', 0),
('Dang Van I', 'dangvani@example.com', '0912345686', '333 Đường VWX, Quận 9, TP.HCM', 'password123', 0),
('Bui Thi K', 'buithik@example.com', '0912345687', '444 Đường YZZ, Quận 10, TP.HCM', 'password123', 0);


INSERT INTO phu_kien_oto(ten_phu_kien, mo_ta, gia, so_luong, hang_san_xuat, anh_dai_dien, CategoryID)
VALUES
(N'Camera hành trình Vietmap X9', N'Ghi hình Full HD, hỗ trợ GPS, cảnh báo tốc độ', 2500000, 100, N'Vietmap',N'VietmapX9.jpg', 11),
(N'Cảm biến áp suất lốp Xiaomi 70mai', N'Giám sát áp suất lốp, cảnh báo khi có bất thường', 1200000, 200, N'Xiaomi',N'Xiaomi70mai.jpg', 12),
(N'Bọc ghế da cao cấp', N'Chất liệu da PU, chống thấm, bền đẹp', 3500000, 50, N'AutoLeather', N'bocgheda.jpg', 13),
(N'Thanh giá nóc Hamer', N'Hỗ trợ chở hàng trên nóc xe, lắp đặt dễ dàng', 2800000, 80, N'Hamer', N'ThanhgianocHamer.jpg', 14),
(N'Bơm lốp ô tô mini Michelin', N'Bơm nhanh, màn hình LED hiển thị áp suất', 1500000, 120, N'Michelin', N'miniMichelin.jpg', 15),
(N'Gạt mưa Bosch AeroTwin', N'Gạt nước hiệu quả, bền bỉ trong mọi thời tiết', 600000, 300, N'Bosch', N'BoschAeroTwin.jpg', 16),
(N'Nước hoa ô tô Areon Ken', N'Hương thơm dịu nhẹ, giúp không gian xe dễ chịu', 250000, 500, N'Areon', N'AreonKe.png', 17),
(N'Màn hình giải trí Android Gotech', N'Cảm ứng mượt, tích hợp GPS, Youtube, sim 4G', 8000000, 40, N'Gotech', N'AndroidGotech.jpg', 18),
(N'Tấm che nắng kính lái', N'Phản xạ nhiệt, giữ nội thất xe mát mẻ', 350000, 400, N'AutoShield', N'chenang.jpg', 19),
(N'Bạt phủ xe chống nước', N'Chất liệu chống tia UV, bảo vệ xe khỏi nắng mưa', 900000, 150, N'CarCover', N'batphuxe.jpg', 20);

INSERT INTO ton_kho (accessoryid, staffid, vi_tri_kho, so_luong, ngay_cap_nhat)
VALUES
(1, 1, N'Kho Hà Nội', 50, '2024-03-09'),
(2, 2, N'Kho TP.HCM', 100, '2024-03-09'),
(3, 3, N'Kho Đà Nẵng', 30, '2024-03-09'),
(4, 4, N'Kho Hà Nội', 40, '2024-03-09'),
(5, 1, N'Kho TP.HCM', 80, '2024-03-09'),
(6, 2, N'Kho Đà Nẵng', 200, '2024-03-09'),
(7, 3, N'Kho Hà Nội', 300, '2024-03-09'),
(8, 4, N'Kho TP.HCM', 20, '2024-03-09'),
(9, 1, N'Kho Đà Nẵng', 150, '2024-03-09'),
(10, 2, N'Kho Hà Nội', 90, '2024-03-09');