
@echo off
echo =====================================
echo ≡ Starting Export from Database: photoEquipmentRentalMS
echo =====================================

:: غير بيانات الدخول إذا لزم الأمر
set DB_USER=root
set DB_PASS=
set DB_NAME=photoequipmentrentalms

:: مسار ملف التصدير الثابت
set OUTPUT_FILE=..\photoEquipmentRentalMS.sql

:: تنفيذ التصدير
mysqldump -u %DB_USER% -p%DB_PASS% %DB_NAME% > %OUTPUT_FILE%

if %ERRORLEVEL%==0 (
    echo Export completed successfully!
) else (
    echo Export failed. Please check your settings.
)

pause
