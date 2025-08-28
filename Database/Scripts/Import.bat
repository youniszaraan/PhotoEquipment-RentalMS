@echo off
echo ===========================================
echo 🚀 Starting Import into Database: photoEquipmentRentalMS
echo ===========================================

set MYSQL_PATH="C:\wamp64\bin\mysql\mysql8.0.30\bin"
set DB_NAME=photoEquipmentRentalMS
set DB_USER=root
set DB_PASS=

%MYSQL_PATH%\mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < "..\photoEquipmentRentalMS.sql"

if %ERRORLEVEL%==0 (
    echo ✅ Import completed successfully! Database is now up to date.
) else (
    echo ❌ Import failed. Please check your settings.
)

pause
