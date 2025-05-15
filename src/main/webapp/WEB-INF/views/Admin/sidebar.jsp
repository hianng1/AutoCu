<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<nav id="sidebar" class="col-md-3 col-lg-3 d-md-block sidebar">
    <div class="position-sticky">
        <h6
            class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted"
        >
            <span>Quản lý hệ thống</span>
        </h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a
                    class="nav-link ${param.activeMenu == 'quantri' ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/quantri"
                >
                    <i class="fas fa-tachometer-alt"></i> Quản trị
                </a>
            </li>
            <li class="nav-item">
                <a
                    class="nav-link ${param.activeMenu == 'taikhoan' ? 'active' : ''}"
                    href="#"
                    data-bs-toggle="collapse"
                    data-bs-target="#thongTinTaiKhoan"
                >
                    <i class="fas fa-cogs"></i> Thông tin tài khoản
                    <i class="fas fa-caret-down"></i>
                </a>
                <div
                    class="collapse ${param.activeMenu == 'taikhoan' ? 'show' : ''}"
                    id="thongTinTaiKhoan"
                >
                    <ul class="nav flex-column ps-3">
                        <li class="nav-item">
                            <a
                                class="nav-link ${param.activeSubmenu == 'khachhang' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/khachhang"
                            >
                                Danh sách khách hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a
                                class="nav-link ${param.activeSubmenu == 'themnhanvien' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/themnhanvien"
                            >
                                Thêm Nhân Viên
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-item">
                <a
                    class="nav-link ${param.activeMenu == 'user' ? 'active' : ''}"
                    href="/quantri"
                    disabled
                >
                    <i class="fas fa-users"></i> Sửa thông tin tài khoản
                </a>
            </li>
            <li class="nav-item">
                <a
                    class="nav-link ${param.activeMenu == 'sanpham' ? 'active' : ''}"
                    href="#"
                    data-bs-toggle="collapse"
                    data-bs-target="#quanLySanPham"
                >
                    <i class="fas fa-box"></i> Quản lý Sản Phẩm
                    <i class="fas fa-caret-down"></i>
                </a>
                <div
                    class="collapse ${param.activeMenu == 'sanpham' ? 'show' : ''}"
                    id="quanLySanPham"
                >
                    <ul class="nav flex-column ps-3">
                        <li class="nav-item">
                            <a
                                class="nav-link ${param.activeSubmenu == 'qlsanpham' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/sanpham"
                            >
                                Quản lý sản phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a
                                class="nav-link ${param.activeSubmenu == 'phukien' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/phukien/list"
                            >
                                Quản lý phụ kiện
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-item">
                <a
                    class="nav-link ${param.activeMenu == 'thongke' ? 'active' : ''}"
                    href="#"
                    data-bs-toggle="collapse"
                    data-bs-target="#thongKe"
                >
                    <i class="fas fa-chart-bar"></i> Thống kê
                    <i class="fas fa-caret-down"></i>
                </a>
                <div
                    class="collapse ${param.activeMenu == 'thongke' ? 'show' : ''}"
                    id="thongKe"
                >
                    <ul class="nav flex-column ps-3">
                        <li class="nav-item">
                            <a
                                class="nav-link ${param.activeSubmenu == 'doanhthu' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/thongke"
                            >
                                Thống kê doanh thu
                            </a>
                        </li>
                        <li class="nav-item">
                            <a
                                class="nav-link ${param.activeSubmenu == 'banhang' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/thongke/banhang"
                            >
                                Thống kê bán hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a
                                class="nav-link ${param.activeSubmenu == 'donhang' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/donhang"
                            >
                                Thống kê đơn hàng
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-item mt-3">
                <a
                    class="nav-link text-danger"
                    href="${pageContext.request.contextPath}/logout"
                >
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </li>
        </ul>
    </div>
</nav>
