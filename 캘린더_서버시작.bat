@echo off
chcp 65001 >nul
echo 공사 일정 캘린더 서버 시작 중...
echo.
echo 브라우저에서 아래 주소로 접속하세요:
echo http://localhost:8761/calendar.html
echo.
echo 이 창을 닫으면 서버가 종료됩니다.
echo.
cd /d "%~dp0"
start "" "http://localhost:8761/calendar.html"
python -m http.server 8761
pause
