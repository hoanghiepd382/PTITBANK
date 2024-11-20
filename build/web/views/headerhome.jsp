<%@ page language="java" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <style>
        .logo-button {
            position: absolute;
            top: 10px;
            left: 10px;
            display: flex;
            align-items: center;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }
        .logo-button i {
            font-size: 40px; /* Kích th??c icon */
            margin-right: 8px;
            color: #004080; /* Màu c?a bi?u t??ng */
        }
        .logo-button span {
            font-weight: bold;
            font-size: 1.2em;
            color: #004080;
        }
    </style>
    <!-- T?i Font Awesome qua CDN -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <a href="views/home.jsp" class="logo-button">
        <i class="fa-solid fa-house"></i> <!-- Bi?u t??ng nhà -->
        <span>PTIT Bank</span>
    </a>
</body>
</html>
