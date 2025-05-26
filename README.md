# AutoCu - Hệ thống Quản lý Bán Xe Cũ và Phụ kiện Ô tô

## Tổng quan dự án

AutoCu là một ứng dụng web toàn diện được phát triển bằng **Spring Boot** để quản lý việc bán xe cũ và phụ kiện ô tô. Hệ thống cung cấp nền tảng thương mại điện tử cho phép người dùng mua bán xe cũ, phụ kiện ô tô với các tính năng quản lý đơn hàng, đánh giá sản phẩm, và hỗ trợ khách hàng.

## Công nghệ sử dụng

### Backend

-   **Java 17**
-   **Spring Boot 3.2.3**
-   **Spring MVC** - Framework web
-   **Spring Data JPA** - ORM và quản lý database
-   **Spring Security** - Bảo mật và authentication
-   **Hibernate** - ORM framework
-   **Lombok** - Giảm boilerplate code

### Frontend

-   **JSP (JavaServer Pages)** - Template engine
-   **JSTL** - JSP Standard Tag Library
-   **Bootstrap 5.3** - CSS framework
-   **TailwindCSS** - Utility-first CSS framework
-   **Font Awesome** - Icons
-   **JavaScript** - Interactive features

### Database

-   **Microsoft SQL Server** - Database chính
-   **JDBC Driver** - SQL Server connectivity

### Build Tool

-   **Maven** - Dependency management và build tool

### Các thư viện khác

-   **Spring Mail** - Gửi email
-   **Spring WebSocket** - Real-time communication
-   **iText PDF** - Xuất hóa đơn PDF
-   **BCrypt** - Mã hóa mật khẩu

## Cấu trúc dự án

```
AutoCu/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── poly/edu/
│   │   │       ├── QuanLyXeApplication.java      # Main application class
│   │   │       ├── Controller/                   # REST/Web Controllers
│   │   │       │   ├── HomeController.java
│   │   │       │   ├── CartController.java
│   │   │       │   ├── DonHangController.java
│   │   │       │   ├── ReviewController.java
│   │   │       │   ├── UserController.java
│   │   │       │   ├── WishlistApiController.java
│   │   │       │   ├── SanPhamController.java
│   │   │       │   ├── ThongkeController.java
│   │   │       │   └── SupportController.java
│   │   │       ├── Model/                        # Entity classes
│   │   │       │   ├── User.java
│   │   │       │   ├── SanPham.java
│   │   │       │   ├── PhuKienOto.java
│   │   │       │   ├── DonHang.java
│   │   │       │   ├── ChiTietDonHang.java
│   │   │       │   ├── GioHang.java
│   │   │       │   ├── DanhGia.java
│   │   │       │   ├── Wishlist.java
│   │   │       │   └── DanhMuc.java
│   │   │       ├── Repository/                   # Data Access Layer
│   │   │       │   ├── UserRepository.java
│   │   │       │   ├── SanPhamRepository.java
│   │   │       │   ├── PhuKienOtoRepository.java
│   │   │       │   ├── DonHangRepository.java
│   │   │       │   ├── GioHangRepository.java
│   │   │       │   ├── DanhGiaRepository.java
│   │   │       │   ├── WishlistRepository.java
│   │   │       │   └── DanhMucRepository.java
│   │   │       ├── Service/                      # Business Logic Layer
│   │   │       │   ├── UserService.java
│   │   │       │   ├── SanPhamService.java
│   │   │       │   ├── PhuKienOtoService.java
│   │   │       │   ├── CartService.java
│   │   │       │   ├── DonHangService.java
│   │   │       │   ├── DanhGiaService.java
│   │   │       │   ├── WishlistService.java
│   │   │       │   ├── DanhMucService.java
│   │   │       │   └── EmailService.java
│   │   │       ├── DAO/                          # Data Access Objects
│   │   │       ├── config/                       # Configuration classes
│   │   │       └── api/                          # API endpoints
│   │   ├── resources/
│   │   │   ├── application.properties            # Application configuration
│   │   │   └── templates/
│   │   │       └── email/
│   │   │           └── verify-email.html
│   │   └── webapp/
│   │       ├── common/                           # Shared JSP components
│   │       │   ├── header.jsp
│   │       │   └── footer.jsp
│   │       ├── imgs/                             # Product images
│   │       ├── resources/css/                    # Custom CSS
│   │       └── WEB-INF/views/                    # JSP pages
│   │           ├── index2.jsp                    # Homepage
│   │           ├── login.jsp                     # Login page
│   │           ├── register.jsp                  # Registration
│   │           ├── cart.jsp                      # Shopping cart
│   │           ├── checkout.jsp                  # Checkout process
│   │           ├── Detail.jsp                    # Product details
│   │           ├── accessories.jsp               # Accessories listing
│   │           ├── wishlist.jsp                  # Wishlist page
│   │           ├── profile.jsp                   # User profile
│   │           ├── Admin/                        # Admin pages
│   │           ├── user/                         # User-specific pages
│   │           └── product/                      # Product-related pages
│   └── test/                                     # Test classes
├── target/                                       # Build output
├── pom.xml                                       # Maven configuration
└── SQLQuery1.sql                                 # Database schema
```

## Chức năng chính

### 1. Quản lý người dùng

-   **Đăng ký/Đăng nhập**: Hệ thống authentication với Spring Security
-   **Xác thực email**: Gửi email xác thực khi đăng ký
-   **Phân quyền**: Admin, Employee, Customer roles
-   **Quản lý profile**: Cập nhật thông tin cá nhân
-   **Đổi mật khẩu**: Bảo mật tài khoản

### 2. Quản lý sản phẩm

-   **Xe cũ**: Thông tin chi tiết về xe (năm sản xuất, nhiên liệu, truyền động, etc.)
-   **Phụ kiện ô tô**: Đa dạng phụ kiện với thông tin kỹ thuật
-   **Danh mục sản phẩm**: Phân loại theo thương hiệu và loại
-   **Tìm kiếm và lọc**: Theo giá, năm, thương hiệu, loại nhiên liệu
-   **Hình ảnh sản phẩm**: Upload và quản lý hình ảnh

### 3. Giỏ hàng và Đặt hàng

-   **Giỏ hàng session-based**: Lưu trữ trong session và database
-   **Quản lý số lượng**: Thêm, sửa, xóa sản phẩm
-   **Checkout process**: Quy trình đặt hàng hoàn chỉnh
-   **Theo dõi đơn hàng**: Trạng thái đơn hàng real-time
-   **Lịch sử đơn hàng**: Xem các đơn hàng đã đặt

### 4. Hệ thống đánh giá

-   **Đánh giá sản phẩm**: Rating 1-5 sao và comment
-   **Chỉ khách hàng đã mua**: Đảm bảo tính xác thực
-   **Quản lý đánh giá**: Xem, sửa, xóa đánh giá cá nhân
-   **Thống kê rating**: Hiển thị điểm trung bình

### 5. Wishlist (Danh sách yêu thích)

-   **Lưu sản phẩm**: Thêm xe và phụ kiện vào wishlist
-   **Quản lý wishlist**: Xem, xóa sản phẩm yêu thích
-   **API endpoints**: RESTful API cho wishlist operations

### 6. Quản trị hệ thống (Admin)

-   **Dashboard**: Thống kê tổng quan
-   **Quản lý người dùng**: CRUD users, phân quyền
-   **Quản lý sản phẩm**: Thêm, sửa, xóa sản phẩm
-   **Quản lý đơn hàng**: Cập nhật trạng thái đơn hàng
-   **Báo cáo thống kê**: Doanh thu, bán hàng theo thời gian
-   **Quản lý phụ kiện**: CRUD accessories

### 7. Hỗ trợ khách hàng

-   **Ticket system**: Tạo và theo dõi yêu cầu hỗ trợ
-   **Live chat**: WebSocket-based chat
-   **Email support**: Gửi email hỗ trợ
-   **FAQ section**: Câu hỏi thường gặp

### 8. Tính năng khác

-   **Responsive design**: Tương thích mobile
-   **Email notifications**: Thông báo qua email
-   **PDF generation**: Xuất hóa đơn PDF
-   **File upload**: Upload hình ảnh sản phẩm
-   **Search functionality**: Tìm kiếm toàn văn

## Cấu hình Database

### Thông tin kết nối

-   **Database**: Microsoft SQL Server
-   **Server**: localhost:1433
-   **Database Name**: QuanLyXe2
-   **Username**: sa
-   **Password**: 123

### Các bảng chính

-   `User` - Thông tin người dùng
-   `SanPham` - Sản phẩm xe cũ
-   `PhuKienOto` - Phụ kiện ô tô
-   `DanhMuc` - Danh mục sản phẩm
-   `DonHang` - Đơn hàng
-   `ChiTietDonHang` - Chi tiết đơn hàng
-   `GioHang` - Giỏ hàng
-   `DanhGia` - Đánh giá sản phẩm
-   `Wishlist` - Danh sách yêu thích
-   `TicketHoTro` - Ticket hỗ trợ

## Cài đặt và Chạy ứng dụng

### Yêu cầu hệ thống

-   Java 17+
-   Maven 3.6+
-   SQL Server 2019+
-   IDE (IntelliJ IDEA, Eclipse, VS Code)

### Các bước cài đặt

1. **Clone repository**

```bash
git clone <repository-url>
cd AutoCu
```

2. **Cấu hình database**

-   Tạo database `QuanLyXe2` trong SQL Server
-   Cập nhật thông tin kết nối trong `application.properties`

3. **Cấu hình email**

-   Cập nhật thông tin SMTP trong `application.properties`

```properties
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password
```

4. **Build project**

```bash
mvn clean install
```

5. **Chạy ứng dụng**

```bash
mvn spring-boot:run
```

6. **Truy cập ứng dụng**

-   URL: `http://localhost:8088`
-   Admin panel: `http://localhost:8088/quantri`

### Cấu hình môi trường

#### Development

```properties
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
logging.level.poly.edu=DEBUG
```

#### Production

```properties
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false
logging.level.poly.edu=INFO
```

## API Endpoints

### Authentication

-   `POST /login` - Đăng nhập
-   `POST /register` - Đăng ký
-   `POST /logout` - Đăng xuất

### Products

-   `GET /` - Homepage với danh sách sản phẩm
-   `GET /details/{id}` - Chi tiết sản phẩm
-   `GET /accessories` - Danh sách phụ kiện
-   `GET /cars` - Danh sách xe cũ

### Cart & Orders

-   `GET /cart` - Xem giỏ hàng
-   `POST /cart/add` - Thêm vào giỏ hàng
-   `POST /cart/update` - Cập nhật giỏ hàng
-   `POST /cart/remove` - Xóa khỏi giỏ hàng
-   `POST /checkout` - Đặt hàng

### Wishlist API

-   `GET /api/wishlist/count` - Số lượng wishlist
-   `GET /api/wishlist/items` - Danh sách wishlist
-   `POST /api/wishlist/toggle` - Thêm/xóa wishlist

### Reviews

-   `GET /reviews/user-reviews` - Đánh giá của người dùng
-   `POST /reviews/submit` - Gửi đánh giá
-   `GET /reviews/write` - Form viết đánh giá

### Admin APIs

-   `GET /admin/dashboard` - Dashboard admin
-   `GET /sanpham` - Quản lý sản phẩm
-   `GET /donhang` - Quản lý đơn hàng
-   `GET /thongke` - Báo cáo thống kê

## Bảo mật

### Spring Security Configuration

-   **Authentication**: Form-based login
-   **Authorization**: Role-based access control
-   **Password Encoding**: BCrypt
-   **Session Management**: Session-based với timeout 30 phút
-   **CSRF Protection**: Enabled cho forms

### Phân quyền

-   **ADMIN**: Toàn quyền quản trị
-   **EMPLOYEE**: Quản lý sản phẩm và đơn hàng
-   **CUSTOMER**: Mua hàng và đánh giá

## Testing

### Unit Tests

```bash
mvn test
```

### Integration Tests

```bash
mvn verify
```

## Deployment

### WAR Deployment

```bash
mvn package
# Deploy target/QuanLyXe-0.0.1-SNAPSHOT.war to Tomcat
```

### Docker Deployment

```dockerfile
FROM openjdk:17-jre-slim
COPY target/QuanLyXe-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8088
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

## Troubleshooting

### Lỗi thường gặp

1. **Database Connection Error**

    - Kiểm tra SQL Server service
    - Xác nhận thông tin kết nối
    - Kiểm tra firewall settings

2. **JSP Not Found**

    - Đảm bảo có dependency `tomcat-embed-jasper`
    - Kiểm tra view resolver configuration

3. **File Upload Error**

    - Kiểm tra đường dẫn upload
    - Xác nhận quyền write folder

4. **Email Error**
    - Kiểm tra SMTP settings
    - Sử dụng App Password cho Gmail

## Đóng góp

1. Fork project
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Liên hệ

-   **Email**: thiembinh16@gmail.com
-   **Project Link**: [https://github.com/your-username/AutoCu](https://github.com/your-username/AutoCu)

## Cảm ơn

-   Spring Boot team
-   Bootstrap team
-   Font Awesome
-   Microsoft SQL Server
-   All open source contributors

---

**Phát triển bởi**: Đội ngũ phát triển AutoCu  
**Năm**: 2025  
**Version**: 1.0.0
