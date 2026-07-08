@echo off
REM تفعيل ترميز UTF-8 لعرض النص العربي بشكل صحيح في نافذة الأوامر
chcp 65001 >nul
REM سكربت تشغيل المشروع على ويندوز: يشغّل الخادم والواجهة معًا
REM ضع مفتاح Claude هنا لتفعيل الصوت/التصوير (اختياري):
REM set ANTHROPIC_API_KEY=sk-ant-...

echo ========================================
echo   تشغيل نظام تعداد الاسر
echo ========================================

REM التحقق من المتطلبات
where dotnet >nul 2>nul
if errorlevel 1 (
  echo [خطأ] .NET SDK 8.0 غير مثبت. حمّله من: https://dotnet.microsoft.com/download/dotnet/8.0
  pause
  exit /b 1
)
where npm >nul 2>nul
if errorlevel 1 (
  echo [خطأ] Node.js غير مثبت. حمّله من: https://nodejs.org
  pause
  exit /b 1
)

REM تثبيت حزم الواجهة عند أول تشغيل
if not exist "client\node_modules" (
  echo تثبيت حزم الواجهة...
  pushd client
  call npm install
  popd
)

echo بدء الخادم على http://localhost:5080 ...
start "Census Server" cmd /k "chcp 65001 >nul && cd Server && dotnet run"

echo بدء الواجهة على http://localhost:5173 ...
start "Census Client" cmd /k "chcp 65001 >nul && cd client && npm run dev"

echo.
echo تم التشغيل. افتح المتصفح على: http://localhost:5173
echo (نافذتان جديدتان فُتحتا للخادم والواجهة)
echo ملاحظة: لعرض العربية بأفضل شكل استخدم خط "Cascadia Mono" أو Windows Terminal.
pause
