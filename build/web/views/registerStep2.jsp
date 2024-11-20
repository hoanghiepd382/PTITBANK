<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <style>
        /* CSS cơ bản cho giao diện */
        body { font-family: Arial, sans-serif; background-color: #f0f2f5; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }
        .container { width: 100%; max-width: 400px; padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); }
        h2 { color: #333; text-align: center; }
        input, select { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; }
        button { width: 100%; padding: 10px; background-color: #4CAF50; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #45a049; }
        .error { color: red; font-size: 14px; text-align: center; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Đăng ký</h2>

        <!-- Hiển thị lỗi nếu có -->
        <c:if test="${not empty errorMessage}">
            <p class="error">${errorMessage}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/RegisterStep2Servlet" method="post">
            <label>Họ và tên:</label>
            <input type="text" name="fullName" required>

            <label>Số điện thoại:</label>
            <input type="text" name="phone" required>

            <label>Địa chỉ:</label>
            <input type="text" name="address" required>

            <label>Thành phố:</label>
            <input type="text" name="city" required>

            <label>Quốc gia:</label>
            <input type="text" name="country" required>

            <label>Số căn cước/chứng minh thư:</label>
            <input type="text" name="idNumber" required>

            <label>Giới tính:</label>
            <select name="gender" required>
                <option value="male">Nam</option>
                <option value="female">Nữ</option>
            </select>

            <label>Ngày sinh:</label>
            <input type="date" name="birthDate" required>

            <button type="submit">Đăng ký</button>
        </form>
    </div>
</body>
</html>
