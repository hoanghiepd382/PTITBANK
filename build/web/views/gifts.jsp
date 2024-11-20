<%@page import="java.util.List"%>
<%@ include file="header.jsp" %>
<%@ page import="models.Gift" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đổi quà</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="plugins/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 20px;
        }
        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: transform 0.3s;
            margin-bottom: 20px;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .card-img-top {
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            max-height: 200px;
            object-fit: cover;
        }
        .btn-primary {
            background-color: #FFA500;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #e69500;
        }
        .header-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            font-size: 1.2em;
        }
        .header-info a {
            color: #4CAF50;
            text-decoration: none;
        }
        .header-info a:hover {
            text-decoration: underline;
        }
         .message {
            text-align: center;
            font-size: 1.1em;
            color: #4CAF50;
            margin-bottom: 20px;
        }
        #successMessage {
            display: none;
            background-color: #d4edda; /* Màu nền xanh nhạt (thành công) */
            color: #155724; /* Màu chữ xanh đậm */
            border: 1px solid #c3e6cb; /* Viền xanh nhạt */
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            font-size: 16px;
            text-align: center;
            animation: fadeInOut 5s ease-in-out; /* Hiệu ứng mờ */
        }

        /* Hiệu ứng mờ dần */
        @keyframes fadeInOut {
            0% {
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
        }

        /* Lớp phủ (overlay) làm mờ trang */
        #overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6); /* Màu nền đen với độ trong suốt */
            z-index: 50; /* Đặt dưới form xác nhận */
            display: none; /* Chỉ hiện khi được kích hoạt */
        }

        /* Form xác nhận */
        .confirm-container {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff; /* Nền trắng sáng */
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3); /* Đổ bóng làm nổi bật form */
            text-align: center;
            z-index: 100; /* Cao hơn overlay */
            border-radius: 8px;
            display: none; /* Chỉ hiện khi cần */
        }

        .confirm-container button {
            margin: 10px; /* Thêm khoảng cách giữa các nút */
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
        }

        /* Khi form hiển thị */
        #overlay.active,
        .confirm-container.active {
            display: block; /* Hiển thị lớp phủ và form */
        }
        

        #termsModal {
            width: 600px;
            max-width: 90%;
            border-radius: 8px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 4px 6px rgba(0,0,0,0.1);
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: none; /* Ẩn modal theo mặc định */
            max-height: 500px;
            overflow-y: auto;
        }

        #termsModal h3 {
            margin-top: 0;
        }

        #termsModal button {
            margin-top: 10px;
        }

    </style>
   </head>
<body>
    <div class="container">
        <div class="header-info">
            <% Integer creditScore = (Integer) session.getAttribute("creditScore");%>
            <div style="display: flex; align-items: center; gap: 15px;">
                <div><strong>Điểm tín dụng:</strong> <%= creditScore != null ? creditScore : "Không có dữ liệu"%></div>
                <a href="javascript:void(0);" id="termsLink" style=" color: #5da9e9;">Thể lệ</a>
            </div>
            <div><a href="giftHistory">Lịch sử đổi quà</a></div>
        </div>

        <h1 class="text-center mb-4">Danh sách quà</h1>

        <div id="successMessage" class="success-message"></div>
        <%
            String message = (String) request.getAttribute("message");
            if (message != null && !message.isEmpty()) {
        %>
        <script>
            showSuccessMessage('<%= message %>');
        </script>
        <%
            }
        %>

        <div class="row">
            <%
                List<Gift> gifts = (List<Gift>) request.getAttribute("gifts");
                if (gifts != null && !gifts.isEmpty()) {
                    for (Gift gift : gifts) {
            %>
            <div class="col-lg-4 col-md-6 col-sm-12 d-flex align-items-stretch">
                <div class="card w-100">
                    <img src="<%= gift.getImageURL() %>" alt="Gift Image" class="card-img-top">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title"><%= gift.getGiftName() %></h5>
                        <p class="card-text">Số điểm cần: <%= gift.getCost() %></p>
                        <button class="btn btn-primary mt-auto" onclick="showConfirmForm(<%= gift.getGiftID() %>, '<%= gift.getGiftName() %>', <%= gift.getCost() %>)">Đổi quà</button>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-12">
                <p class="text-center">Không có quà nào để hiển thị.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <div id="overlay" class="overlay" onclick="hideConfirmForm()"></div>
    <div id="confirmForm" class="confirm-container">
        <h3>Xác nhận đổi quà</h3>
        <p>Bạn chắc chắn muốn đổi quà: <strong id="giftName"></strong> với số điểm: <strong id="giftCost"></strong>?</p>
        <form action="gifts" method="post">
            <input type="hidden" id="giftIdInput" name="giftId" />
            <div>
                <button type="submit" onclick="showSuccessMessage('Đổi quà thành công!'); hideConfirmForm();" class="btn btn-primary">
                    Xác nhận
                </button>
                <button type="button" onclick="hideConfirmForm()" class="btn btn-secondary">
                    Hủy
                </button>
            </div>
        </form>
    </div>

    <div id="termsModal" class="modal">
        <div class="modal-content">
            <h3>Thể lệ</h3>
            <p>1.Điểm tín dụng là điểm được tích trên mỗi giao dịch chuyển khoản của quý khách, lưu ý chỉ tính mỗi giao dịch chuyển khoản chứ không tính rút tiền hay các dịch vụ khác.</p>
            <p>2.Mỗi 1000 VNĐ trên số tiền giao dịch sẽ tích được 1 điểm tín dụng</p>
            <p>3.Điểm tín dụng còn là điều kiện để bạn có thể thay đổi hạn mức giao dịch ngày.</p>
            <p>4.Các phần quà bạn đã được đổi vui lòng đến trực tiếp quầy giao dịch gần nhất để nhận.</p>
            <p>Cảm ơn quý khách đã sử dụng dịch vụ!!!</p>
            <button onclick="closeTermsModal()">Đóng</button>
        </div>
    </div>

    <script src="plugins/jQuery/jquery.min.js"></script>
    <script src="plugins/bootstrap/bootstrap.min.js"></script>
    <script>
        // Hiển thị thông báo và tự động ẩn sau 3 giây
        function showSuccessMessage(message) {
            var messageDiv = document.getElementById('successMessage');
            messageDiv.innerText = message;
            messageDiv.style.display = 'block';

            setTimeout(function() {
                messageDiv.style.display = 'none';
            }, 3000);
        }

        // Hiển thị form xác nhận
        function showConfirmForm(giftId, giftName, cost) {
            document.getElementById('overlay').classList.add('active');
            document.getElementById('confirmForm').classList.add('active');
            document.getElementById('giftName').innerText = giftName;
            document.getElementById('giftCost').innerText = cost;
            document.getElementById('giftIdInput').value = giftId;
        }

        // Ẩn form xác nhận
        function hideConfirmForm() {
            document.getElementById('overlay').classList.remove('active');
            document.getElementById('confirmForm').classList.remove('active');
        }

        // Mở modal khi nhấn vào liên kết "Thể lệ"
        document.getElementById('termsLink').addEventListener('click', function(event) {
            event.preventDefault();
            document.getElementById('termsModal').style.display = 'block';
        });

        // Đóng modal khi nhấn nút "Đóng"
        function closeTermsModal() {
            document.getElementById('termsModal').style.display = 'none';
        }

        // Đóng modal khi nhấp ngoài modal (nếu cần)
        window.addEventListener('click', function(event) {
            var modal = document.getElementById('termsModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });
    </script>
</body>
</html>
