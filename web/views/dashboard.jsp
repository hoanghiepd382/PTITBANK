<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
       /* Reset và font chữ chung */
* {
   margin: 0;
   padding: 0;
   box-sizing: border-box;
   font-family: Arial, sans-serif;
}

/* Kiểu nền và căn giữa cho toàn bộ trang */
body {
   background-color: #f5f5f5;
   display: flex;
   justify-content: flex-start;
   align-items: flex-start;
   min-height: 100vh;
   flex-direction: row;
}

a {
   text-decoration: none;
}

/* Container chính cho dashboard */
.dashboard-container {
   display: flex;
   width: 100%;
   max-width: 1200px;
   background-color: #ffffff;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
   border-radius: 10px;
   overflow: hidden;
}

/* Sidebar */
.sidebar {
   width: 250px;
   background-color: #212121; /* Màu đen đẹp cho sidebar */
   color: white;
   padding: 20px;
   height: 100vh;
   display: flex;
   flex-direction: column;
   justify-content: flex-start; /* Chỉnh lại cho các mục gần nhau */
   overflow-y: auto;
}

.sidebar h3 {
   color: white;
   font-size: 20px;
   margin-bottom: 10px; /* Giảm khoảng cách để gần với tên chức năng */
}

.sidebar ul {
   list-style-type: none;
   padding-left: 0;
}

.sidebar ul li {
   margin: 8px 0; /* Giảm khoảng cách giữa các chức năng */
}

.sidebar ul li a {
   color: white;
   font-size: 18px;
   display: block;
   padding: 10px 0;
   transition: background-color 0.3s;
}

.sidebar ul li a:hover {
   background-color: #333; /* Màu nền khi hover */
}
.sidebar ul li a.active {
            background-color: #333; /* Màu nền khi active */
            font-weight: bold; /* In đậm chữ */
        }
 /* CSS cho các mục con trong Tiện ích */
    .sidebar ul li ul li a {
      font-size: 14px; /* Cỡ chữ nhỏ hơn */
      padding-left: 20px; /* Thụt lề vào */
    }
    .sidebar ul li ul {
  display: none;
  padding-left: 20px;
}

.sidebar ul li ul.show {
  display: block;
}
/* Phần nội dung chính */
.main-content {
   flex: 1;
   padding: 20px;
   overflow-y: auto;
}

/* Header cho dashboard */
.dashboard-header {
   background-color: #0049b1;
   color: #ffffff;
   padding: 20px;
   text-align: center;
}

.dashboard-header h1 {
   font-size: 28px;
   font-weight: bold;
}

/* Phần hiển thị số tài khoản và số dư */
.account-info {
   background-color: #ffffff;
   padding: 15px;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
   display: flex;
   justify-content: space-between;
   align-items: center;
   margin: 20px 0;
}

.account-info .label {
   font-size: 16px;
   color: #333;
}

.account-info .value {
   font-size: 20px;
   font-weight: bold;
   color: #0049b1;
}

/* Container chức năng */
.dashboard-content {
   display: grid;
   grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
   gap: 20px;
   padding: 30px;
}

/* Ô chức năng */
.feature-box {
   background-color: #f0f4f8;
   padding: 20px;
   border-radius: 8px;
   display: flex;
   flex-direction: column;
   align-items: center;
   text-align: center;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
   transition: transform 0.2s, box-shadow 0.2s;
}

/* Hiệu ứng hover */
.feature-box:hover {
   transform: translateY(-5px);
   box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.feature-box img {
   width: 60px;
   margin-bottom: 15px;
}

.feature-box h3 {
   font-size: 18px;
   color: #333333;
   margin-bottom: 10px;
}

.feature-box p {
   font-size: 14px;
   color: #777777;
}

/* Footer cho dashboard */
.dashboard-footer {
   background-color: #0049b1;
   color: #ffffff;
   text-align: center;
   padding: 15px;
   font-size: 14px;
}
.greeting {
    position: absolute;
    top: 20px;
    right: 20px;
    font-size: 18px;
    font-weight: bold;
    color: #333;
}


    </style>
     <%
    HttpServletRequest httpRequest = (HttpServletRequest) pageContext.getRequest();
    String userPin = (String) session.getAttribute("pin");
    String transferLink = (userPin == null || userPin.isEmpty()) ?
            httpRequest.getContextPath() + "/views/setupPinWarning.jsp" :
            httpRequest.getContextPath() + "/transfer";
    String withdrawLink = (userPin == null || userPin.isEmpty()) ?
            httpRequest.getContextPath() + "/views/setupPinWarning.jsp" :
            httpRequest.getContextPath() + "/WithdrawServlet";
    String rechargeLink = (userPin == null || userPin.isEmpty()) ?
            httpRequest.getContextPath() + "/views/setupPinWarning.jsp" :
            httpRequest.getContextPath() + "/RechargeServlet";
  %>
</head>

<body>
<div class="dashboard-container">
  <div class="sidebar">
    <h3>Trang chủ</h3>
    <ul>
      <li>
        <a href="#tienich" class="dropdown-toggle">Tiện ích</a>
        <ul class="list-unstyled" id="tienich">
          <li><a href="<%= transferLink %>">Chuyển khoản</a></li>
          <li><a href="<%= withdrawLink %>">Rút tiền</a></li>
          <li><a href="${pageContext.request.contextPath}/TransactionHistoryServlet">Lịch sử giao dịch</a></li>
          <li><a href="<%= rechargeLink %>">Nạp tiền điện thoại</a></li>
          <li><a href="${pageContext.request.contextPath}/gifts">Đổi quà tặng</a></li>
          <li><a href="tuitionPtit.jsp">Đóng học phí</a></li>
        </ul>
      </li>
        <li>
        <a href="#caidat" class="dropdown-toggle">Cài đặt</a>
        <ul class="list-unstyled" id="caidat">
          <li><a href="${pageContext.request.contextPath}/updateProfile">Thông tin cá nhân</a></li>
          <li><a href="javascript:void(0);" onclick="redirectToPinMethod()">Phương thức xác thực</a></li>
          <li><a href="changePassword.jsp">Đổi mật khẩu</a></li>
          <li><a href="changeLimit.jsp">Thay đổi hạn mức giao dịch</a></li>
          <li><a href="openBeautifulAccount.jsp">Mở tài khoản số đẹp</a></li>
        </ul>
      </li>
      <li><a href="javascript:void(0);" onclick="performLogout()" class="logout">Đăng xuất</a></li>
    </ul>
    
  </div>

  <div class="main-content">
    <div class="greeting">
      <c:if test="${not empty sessionScope.fullName}">
        Xin chào, ${sessionScope.fullName}!
      </c:if>
    </div>

    <div class="account-info" style="background: #fff; color: #4b49c5; border: 2px solid #6c63ff; border-radius: 15px; padding: 20px; box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); width: 350px; margin: 20px auto; text-align: center; display: flex; flex-direction: column; align-items: center; position: relative;">
                <a href="#" id="myBtn" style="position: absolute; top: 10px; right: 15px; color: #6c63ff; text-decoration: none; font-size: 14px; font-weight: bold;">
                    Chi tiết ›
                </a>
                <div style="font-size: 22px; font-weight: bold; margin-bottom: 10px; letter-spacing: 1px;">
                    <%= session.getAttribute("accountNumber") %>
                </div>
                <div style="font-size: 28px; font-weight: bold; margin-top: 10px; color: #4b49c5;">
                    <%= NumberFormat.getNumberInstance().format(session.getAttribute("balance")) %> VND
                </div>
    </div>

    <div class="dashboard-content">
      <a href="<%= transferLink %>" class="feature-box">
        <img src="https://i.ibb.co/n7pf104/transfer.png">
        <h3>Chuyển khoản</h3>
      </a>

      <a href="<%= withdrawLink %>" class="feature-box">
        <img src=" https://i.ibb.co/3CFFL75/withdraw.png">
        <h3>Rút tiền</h3>

      </a>

      <a href="${pageContext.request.contextPath}/TransactionHistoryServlet" class="feature-box">
        <img src="https://i.ibb.co/X55gPxM/hisstorytranss.png">
        <h3>Lịch sử giao dịch</h3>
      </a>

      <a href="<%= rechargeLink %>" class="feature-box">
        <img src="https://i.ibb.co/hK7M4Zr/money-transfer.png">
        <h3>Nạp tiền điện thoại</h3>
      </a>

      <a href="${pageContext.request.contextPath}/gifts" class="feature-box">
        <img src="https://i.ibb.co/wwCcTdq/gift.png">
        <h3>Đổi quà tặng</h3>
      </a>

      <a href="tuitionPtit.jsp" class="feature-box">
        <img src="https://i.ibb.co/7Ryf4sZ/tuition.png">
        <h3>Đóng học phí</h3>
      </a>

      <a href="settings.jsp" class="feature-box">
        <img src="https://i.ibb.co/h76VKzg/setting.png">
        <h3>Cài đặt</h3>
      </a>
    </div>

  </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
    const tienIchLink = document.querySelector('.sidebar a[href="#tienich"]');
    const tienIchList = document.getElementById('tienich');

    tienIchLink.addEventListener('click', function(event) {
      event.preventDefault();

      if (tienIchList.classList.contains('show')) {
        tienIchList.classList.remove('show');
      } else {
        tienIchList.classList.add('show');
      }
    });
  });
   // JavaScript cho mục Cài đặt
    const caiDatLink = document.querySelector('.sidebar a[href="#caidat"]');
    const caiDatList = document.getElementById('caidat');

    caiDatLink.addEventListener('click', function(event) {
      event.preventDefault();

      if (caiDatList.classList.contains('show')) {
        caiDatList.classList.remove('show');
      } else {
        caiDatList.classList.add('show');
      }
    });
  // Lấy URL hiện tại
  var currentUrl = window.location.pathname;

  // Duyệt qua các liên kết trong sidebar
  var sidebarLinks = document.querySelectorAll('.sidebar ul li a');
  sidebarLinks.forEach(function(link) {
    // Kiểm tra xem URL hiện tại có khớp với href của liên kết không
    if (currentUrl.includes(link.getAttribute('href'))) {
      // Thêm class "active" vào liên kết
      link.classList.add('active');
    }
  });
  function performLogout() {
            fetch('${pageContext.request.contextPath}/logout', { method: 'GET' })
                .then(response => {
                    if (response.ok) {
                        window.location.href = '/PTITBANK';
                    }
                })
                .catch(error => {
                    console.error('Đã xảy ra lỗi khi đăng xuất:', error);
                });
        }
</script>
</script>
</body>

</html>