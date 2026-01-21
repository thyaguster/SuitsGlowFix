@echo off
setlocal

echo ================================
echo  Lethal Company Suits Glow Fix
echo ================================
echo.
echo Choose an option:
echo   1) Change 1.0 -^> 1
echo   2) Change 1 -^> 1.0
echo.

set /p CHOICE=Type 1 or 2 and press Enter: 

if "%CHOICE%"=="1" goto TO_INT
if "%CHOICE%"=="2" goto TO_FLOAT
echo.
echo Invalid option.
pause
exit /b


:TO_INT
echo.
echo Converting 1.0 to 1...
powershell -NoProfile -Command ^
  "$changed=0; Get-ChildItem -Filter *.json | ForEach-Object { " ^
  "  $t = Get-Content -Raw $_.FullName; " ^
  "  $t2 = $t.Replace('\"_EmissiveColor\": \"1.0, 1.0, 1.0, 1.0\"','\"_EmissiveColor\": \"1, 1, 1, 1\"'); " ^
  "  if($t -ne $t2){ Set-Content $_.FullName $t2 -NoNewline; $changed++ } " ^
  "}; Write-Host ('Files changed: ' + $changed)"
echo Done.
pause
exit /b


:TO_FLOAT
echo.
echo Converting 1 to 1.0...
powershell -NoProfile -Command ^
  "$changed=0; Get-ChildItem -Filter *.json | ForEach-Object { " ^
  "  $t = Get-Content -Raw $_.FullName; " ^
  "  $t2 = $t.Replace('\"_EmissiveColor\": \"1, 1, 1, 1\"','\"_EmissiveColor\": \"1.0, 1.0, 1.0, 1.0\"'); " ^
  "  if($t -ne $t2){ Set-Content $_.FullName $t2 -NoNewline; $changed++ } " ^
  "}; Write-Host ('Files changed: ' + $changed)"
echo.
echo Done.
pause
exit /b
