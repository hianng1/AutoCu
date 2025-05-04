<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Theo dõi đơn hàng - AutoCu</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    <style>
      body {
        background-color: #f8f9fa;
      }
      .tracking-container {
        max-width: 900px;
        margin: 60px auto;
        padding: 0;
        background: transparent;
      }
      .tracking-header {
        text-align: center;
        margin-bottom: 40px;
      }
      .tracking-header h2 {
        font-size: 2.2rem;
        font-weight: 700;
        color: #333;
        margin-bottom: 15px;
      }
      .tracking-form {
        margin-bottom: 40px;
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
      }
      .tracking-form .form-control {
        height: 50px;
        font-size: 1rem;
        border: 1px solid #e1e5eb;
      }
      .tracking-form .btn-primary {
        height: 50px;
        font-size: 1rem;
        background-color: #ff6b00;
        border-color: #ff6b00;
        font-weight: 600;
      }
      .tracking-form .btn-primary:hover {
        background-color: #e85d00;
        border-color: #e85d00;
      }
      .tracking-status {
        background: white;
        padding: 35px;
        border-radius: 10px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
      }
      .tracking-status h4 {
        font-size: 1.5rem;
        font-weight: 600;
        color: #333;
        margin-bottom: 25px;
        position: relative;
        padding-bottom: 15px;
      }
      .tracking-status h4:after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 0;
        width: 60px;
        height: 4px;
        background: #ff6b00;
        border-radius: 2px;
      }
      .status-timeline {
        position: relative;
        padding: 10px 0 0 20px;
      }
      .status-timeline:before {
        content: "";
        position: absolute;
        top: 15px;
        bottom: 0;
        left: 19.5px;
        width: 1px;
        background: #e9ecef;
        z-index: 1;
      }
      .status-step {
        display: flex;
        align-items: flex-start;
        margin-bottom: 35px;
        position: relative;
        z-index: 2;
      }
      .status-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #f0f0f0;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 20px;
        box-shadow: 0 0 0 5px white;
        transition: all 0.3s;
      }
      .status-icon.active {
        background: #28a745;
        color: white;
        box-shadow: 0 0 0 5px rgba(40, 167, 69, 0.2);
      }
      .status-icon.completed {
        background: #28a745;
        color: white;
        box-shadow: 0 0 0 5px rgba(40, 167, 69, 0.2);
      }
      .status-details {
        flex: 1;
        padding-top: 3px;
      }
      .status-title {
        font-weight: 600;
        font-size: 1.1rem;
        margin-bottom: 6px;
        color: #333;
      }
      .status-date {
        color: #6c757d;
        font-size: 0.95em;
        display: flex;
        align-items: center;
      }
      .status-date i {
        margin-right: 5px;
        font-size: 0.9rem;
      }
      .status-step:last-child {
        margin-bottom: 0;
      }
      .status-desc {
        color: #6c757d;
        margin-top: 8px;
        font-size: 0.95em;
        line-height: 1.5;
      }

      /* Responsive fixes */
      @media (max-width: 768px) {
        .tracking-container {
          margin: 30px auto;
          padding: 0 15px;
        }
        .tracking-header h2 {
          font-size: 1.8rem;
        }
        .tracking-form,
        .tracking-status {
          padding: 25px;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/common/header.jsp" />

    <div class="container tracking-container">
      <div class="tracking-header">
        <h2>Theo dõi đơn hàng</h2>
        <p class="text-muted">
          Nhập mã đơn hàng để kiểm tra trạng thái giao hàng của bạn
        </p>
      </div>

      <div class="tracking-form">
        <form action="track-order" method="post">
          <div class="input-group mb-3">
            <input
              type="text"
              class="form-control"
              name="orderId"
              placeholder="Nhập mã đơn hàng của bạn (ví dụ: ORD-12345)"
              required
            />
            <button class="btn btn-primary" type="submit">
              <i class="fas fa-search me-2"></i> Tra cứu
            </button>
          </div>
          <div class="text-muted small mt-2">
            <i class="fas fa-info-circle me-1"></i> Mã đơn hàng đã được gửi qua
            email xác nhận đơn hàng của bạn
          </div>
        </form>
      </div>

      <div class="tracking-status">
        <h4>Chi tiết trạng thái đơn hàng</h4>
        <div class="status-timeline">
          <div class="status-step">
            <div class="status-icon active">
              <i class="fas fa-shopping-cart"></i>
            </div>
            <div class="status-details">
              <div class="status-title">Đã đặt hàng</div>
              <div class="status-date">
                <i class="far fa-clock"></i> 01/05/2024 10:30
              </div>
              <div class="status-desc">
                Đơn hàng của bạn đã được tạo thành công và đang chờ xác nhận.
              </div>
            </div>
          </div>

          <div class="status-step">
            <div class="status-icon active">
              <i class="fas fa-file-invoice"></i>
            </div>
            <div class="status-details">
              <div class="status-title">Đã xác nhận</div>
              <div class="status-date">
                <i class="far fa-clock"></i> 01/05/2024 11:00
              </div>
              <div class="status-desc">
                Đơn hàng đã được xác nhận và đang được chuẩn bị để giao cho đơn
                vị vận chuyển.
              </div>
            </div>
          </div>

          <div class="status-step">
            <div class="status-icon">
              <i class="fas fa-box"></i>
            </div>
            <div class="status-details">
              <div class="status-title">Đang đóng gói</div>
              <div class="status-date">
                <i class="far fa-clock"></i> Chưa cập nhật
              </div>
              <div class="status-desc">
                Đơn hàng đang được đóng gói và chuẩn bị bởi nhân viên kho.
              </div>
            </div>
          </div>

          <div class="status-step">
            <div class="status-icon">
              <i class="fas fa-truck"></i>
            </div>
            <div class="status-details">
              <div class="status-title">Đang vận chuyển</div>
              <div class="status-date">
                <i class="far fa-clock"></i> Chưa cập nhật
              </div>
              <div class="status-desc">
                Đơn hàng đang được vận chuyển đến địa chỉ của bạn.
              </div>
            </div>
          </div>

          <div class="status-step">
            <div class="status-icon">
              <i class="fas fa-check-circle"></i>
            </div>
            <div class="status-details">
              <div class="status-title">Đã giao hàng</div>
              <div class="status-date">
                <i class="far fa-clock"></i> Chưa cập nhật
              </div>
              <div class="status-desc">
                Đơn hàng đã được giao thành công đến địa chỉ của bạn.
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Thêm phần thông tin chi tiết đơn hàng -->
      <div class="tracking-status mt-4">
        <h4>Thông tin đơn hàng #ORD-12345</h4>
        <div class="row mt-4">
          <div class="col-md-6">
            <h5 class="fw-bold mb-3">Thông tin giao hàng</h5>
            <p><strong>Người nhận:</strong> Nguyễn Văn A</p>
            <p><strong>Địa chỉ:</strong> 123 Đường ABC, Quận 1, TP.HCM</p>
            <p><strong>Số điện thoại:</strong> 0987654321</p>
            <p><strong>Email:</strong> nguyenvana@example.com</p>
          </div>
          <div class="col-md-6">
            <h5 class="fw-bold mb-3">Thông tin thanh toán</h5>
            <p>
              <strong>Phương thức thanh toán:</strong> Thanh toán khi nhận hàng
              (COD)
            </p>
            <p><strong>Tổng tiền hàng:</strong> 1,200,000₫</p>
            <p><strong>Phí vận chuyển:</strong> 30,000₫</p>
            <p>
              <strong>Tổng thanh toán:</strong>
              <span class="text-danger fw-bold">1,230,000₫</span>
            </p>
          </div>
        </div>
      </div>
    </div>

    <jsp:include page="/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
