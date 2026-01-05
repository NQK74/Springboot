<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Không tìm thấy trang</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            overflow: hidden;
            position: relative;
        }

        .container {
            text-align: center;
            padding: 40px;
            z-index: 10;
        }

        .error-code {
            font-size: 180px;
            font-weight: 700;
            color: rgba(255, 255, 255, 0.9);
            text-shadow: 4px 4px 0px rgba(0, 0, 0, 0.1);
            line-height: 1;
            animation: float 3s ease-in-out infinite;
            position: relative;
        }

        .error-code::before {
            content: '404';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            color: transparent;
            -webkit-text-stroke: 2px rgba(255, 255, 255, 0.3);
            z-index: -1;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }

        .error-title {
            font-size: 32px;
            color: white;
            margin: 20px 0 10px;
            font-weight: 600;
        }

        .error-message {
            font-size: 18px;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 40px;
            max-width: 500px;
            line-height: 1.6;
        }

        .illustration {
            margin: 30px 0;
        }

        .illustration svg {
            width: 200px;
            height: 200px;
        }

        .astronaut {
            animation: astronaut 5s linear infinite;
        }

        @keyframes astronaut {
            0% { transform: rotate(0deg) translateX(10px) rotate(0deg); }
            100% { transform: rotate(360deg) translateX(10px) rotate(-360deg); }
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 15px 40px;
            background: white;
            color: #667eea;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .btn-home:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
            background: #f8f9fa;
        }

        .btn-home svg {
            width: 20px;
            height: 20px;
            transition: transform 0.3s ease;
        }

        .btn-home:hover svg {
            transform: translateX(-5px);
        }

        /* Floating shapes */
        .shapes {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 1;
        }

        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: shapes 15s linear infinite;
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 60%;
            left: 80%;
            animation-delay: 2s;
        }

        .shape:nth-child(3) {
            width: 60px;
            height: 60px;
            top: 80%;
            left: 20%;
            animation-delay: 4s;
        }

        .shape:nth-child(4) {
            width: 100px;
            height: 100px;
            top: 10%;
            left: 70%;
            animation-delay: 6s;
        }

        .shape:nth-child(5) {
            width: 50px;
            height: 50px;
            top: 40%;
            left: 5%;
            animation-delay: 8s;
        }

        @keyframes shapes {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 0.5;
            }
            50% {
                opacity: 0.8;
            }
            100% {
                transform: translateY(-100vh) rotate(720deg);
                opacity: 0;
            }
        }

        /* Stars */
        .stars {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
        }

        .star {
            position: absolute;
            width: 4px;
            height: 4px;
            background: white;
            border-radius: 50%;
            animation: twinkle 2s infinite;
        }

        @keyframes twinkle {
            0%, 100% { opacity: 0.3; }
            50% { opacity: 1; }
        }

        @media (max-width: 768px) {
            .error-code {
                font-size: 120px;
            }
            .error-title {
                font-size: 24px;
            }
            .error-message {
                font-size: 16px;
                padding: 0 20px;
            }
        }
    </style>
</head>
<body>
    <div class="stars">
        <div class="star" style="top: 10%; left: 20%;"></div>
        <div class="star" style="top: 20%; left: 80%; animation-delay: 0.5s;"></div>
        <div class="star" style="top: 30%; left: 50%; animation-delay: 1s;"></div>
        <div class="star" style="top: 50%; left: 15%; animation-delay: 1.5s;"></div>
        <div class="star" style="top: 70%; left: 70%; animation-delay: 2s;"></div>
        <div class="star" style="top: 85%; left: 35%; animation-delay: 0.3s;"></div>
        <div class="star" style="top: 15%; left: 60%; animation-delay: 0.8s;"></div>
        <div class="star" style="top: 60%; left: 90%; animation-delay: 1.2s;"></div>
    </div>

    <div class="shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    <div class="container">
        <div class="illustration">
            <svg viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
                <g class="astronaut">
                    <!-- Astronaut body -->
                    <ellipse cx="100" cy="110" rx="35" ry="45" fill="white"/>
                    <!-- Helmet -->
                    <circle cx="100" cy="60" r="35" fill="white"/>
                    <circle cx="100" cy="60" r="28" fill="#2d3748"/>
                    <ellipse cx="95" cy="55" rx="8" ry="10" fill="rgba(255,255,255,0.3)"/>
                    <!-- Backpack -->
                    <rect x="125" y="80" width="20" height="50" rx="5" fill="#e2e8f0"/>
                    <!-- Arms -->
                    <ellipse cx="55" cy="100" rx="15" ry="10" fill="white" transform="rotate(-30 55 100)"/>
                    <ellipse cx="145" cy="100" rx="15" ry="10" fill="white" transform="rotate(30 145 100)"/>
                    <!-- Legs -->
                    <ellipse cx="85" cy="155" rx="12" ry="20" fill="white"/>
                    <ellipse cx="115" cy="155" rx="12" ry="20" fill="white"/>
                    <!-- Details -->
                    <rect x="80" y="90" width="40" height="10" rx="2" fill="#667eea"/>
                </g>
                <!-- Planet -->
                <circle cx="170" cy="170" r="25" fill="rgba(255,255,255,0.2)"/>
                <ellipse cx="170" cy="170" rx="35" ry="8" fill="rgba(255,255,255,0.1)" transform="rotate(-20 170 170)"/>
            </svg>
        </div>

        <div class="error-code">404</div>
        <h1 class="error-title">Oops! Trang không tồn tại</h1>
        <p class="error-message">
            Trang bạn đang tìm kiếm có thể đã bị xóa, đổi tên hoặc tạm thời không khả dụng.
        </p>

        <a href="/" class="btn-home">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
            </svg>
            Về trang chủ
        </a>
    </div>
</body>
</html>