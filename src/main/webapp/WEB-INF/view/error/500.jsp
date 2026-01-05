<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Lỗi máy chủ</title>
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
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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
            position: relative;
        }

        .error-code::before {
            content: '500';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            color: transparent;
            -webkit-text-stroke: 2px rgba(255, 255, 255, 0.3);
            z-index: -1;
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
            position: relative;
        }

        .gear-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: -20px;
        }

        .gear {
            animation: rotate 4s linear infinite;
        }

        .gear.reverse {
            animation: rotate-reverse 4s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        @keyframes rotate-reverse {
            from { transform: rotate(0deg); }
            to { transform: rotate(-360deg); }
        }

        .smoke {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
        }

        .smoke-particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            animation: smoke 3s ease-out infinite;
        }

        @keyframes smoke {
            0% {
                transform: translateY(0) scale(1);
                opacity: 0.5;
            }
            100% {
                transform: translateY(-100px) scale(2);
                opacity: 0;
            }
        }

        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 15px 35px;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
        }

        .btn-home {
            background: white;
            color: #f5576c;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .btn-home:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
            background: #f8f9fa;
        }

        .btn-retry {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid white;
        }

        .btn-retry:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-3px);
        }

        .btn svg {
            width: 20px;
            height: 20px;
            transition: transform 0.3s ease;
        }

        .btn-home:hover svg {
            transform: translateX(-5px);
        }

        .btn-retry:hover svg {
            transform: rotate(180deg);
        }

        /* Glitch effect */
        .glitch {
            animation: glitch 2s infinite;
        }

        @keyframes glitch {
            0%, 90%, 100% {
                transform: translate(0);
            }
            92% {
                transform: translate(-5px, 5px);
            }
            94% {
                transform: translate(5px, -5px);
            }
            96% {
                transform: translate(-5px, -5px);
            }
            98% {
                transform: translate(5px, 5px);
            }
        }

        /* Circuit pattern background */
        .circuit {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0.1;
            z-index: 0;
        }

        .circuit-line {
            position: absolute;
            background: white;
        }

        /* Floating warning icons */
        .warnings {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 1;
            overflow: hidden;
        }

        .warning-icon {
            position: absolute;
            font-size: 30px;
            opacity: 0.2;
            animation: float-warning 6s ease-in-out infinite;
        }

        @keyframes float-warning {
            0%, 100% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(10deg);
            }
        }

        /* Pulse effect */
        .pulse-ring {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 300px;
            height: 300px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            animation: pulse 2s ease-out infinite;
        }

        .pulse-ring:nth-child(2) {
            animation-delay: 0.5s;
        }

        .pulse-ring:nth-child(3) {
            animation-delay: 1s;
        }

        @keyframes pulse {
            0% {
                transform: translate(-50%, -50%) scale(0.5);
                opacity: 1;
            }
            100% {
                transform: translate(-50%, -50%) scale(1.5);
                opacity: 0;
            }
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
            .btn-group {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <div class="pulse-ring"></div>
    <div class="pulse-ring"></div>
    <div class="pulse-ring"></div>

    <div class="warnings">
        <span class="warning-icon" style="top: 15%; left: 10%;">⚠️</span>
        <span class="warning-icon" style="top: 25%; left: 85%; animation-delay: 1s;">⚡</span>
        <span class="warning-icon" style="top: 70%; left: 15%; animation-delay: 2s;">🔧</span>
        <span class="warning-icon" style="top: 80%; left: 80%; animation-delay: 0.5s;">⚙️</span>
        <span class="warning-icon" style="top: 45%; left: 5%; animation-delay: 1.5s;">🔥</span>
        <span class="warning-icon" style="top: 55%; left: 92%; animation-delay: 2.5s;">💥</span>
    </div>

    <div class="container">
        <div class="illustration">
            <div class="smoke">
                <div class="smoke-particle" style="left: 45%; top: 30%; width: 20px; height: 20px; animation-delay: 0s;"></div>
                <div class="smoke-particle" style="left: 55%; top: 35%; width: 15px; height: 15px; animation-delay: 0.5s;"></div>
                <div class="smoke-particle" style="left: 50%; top: 25%; width: 25px; height: 25px; animation-delay: 1s;"></div>
            </div>
            <div class="gear-container">
                <svg class="gear" width="80" height="80" viewBox="0 0 100 100" fill="white">
                    <path d="M50 20 L55 10 L60 20 L70 15 L68 27 L80 30 L72 40 L85 50 L72 60 L80 70 L68 73 L70 85 L60 80 L55 90 L50 80 L45 90 L40 80 L30 85 L32 73 L20 70 L28 60 L15 50 L28 40 L20 30 L32 27 L30 15 L40 20 L45 10 Z"/>
                    <circle cx="50" cy="50" r="20" fill="#f5576c"/>
                </svg>
                <svg class="gear reverse" width="60" height="60" viewBox="0 0 100 100" fill="rgba(255,255,255,0.8)" style="margin-left: -15px;">
                    <path d="M50 25 L54 15 L58 25 L68 22 L66 32 L78 35 L70 45 L82 50 L70 55 L78 65 L66 68 L68 78 L58 75 L54 85 L50 75 L46 85 L42 75 L32 78 L34 68 L22 65 L30 55 L18 50 L30 45 L22 35 L34 32 L32 22 L42 25 L46 15 Z"/>
                    <circle cx="50" cy="50" r="18" fill="#f5576c"/>
                </svg>
            </div>
        </div>

        <div class="glitch">
            <div class="error-code">500</div>
        </div>
        <h1 class="error-title">Oops! Có lỗi xảy ra</h1>
        <p class="error-message">
            Máy chủ đang gặp sự cố. Đội ngũ kỹ thuật đang khắc phục. Vui lòng thử lại sau ít phút.
        </p>

        <div class="btn-group">
            <a href="/" class="btn btn-home">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                </svg>
                Về trang chủ
            </a>
            <button onclick="location.reload()" class="btn btn-retry">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                </svg>
                Thử lại
            </button>
        </div>
    </div>
</body>
</html>