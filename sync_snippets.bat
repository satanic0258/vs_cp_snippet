@echo off
setlocal
cd /d "%~dp0"
if errorlevel 1 goto :error

echo === Visual C++ Snippets: GitHub Sync ===
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ERROR: This folder is not a Git repository.
    goto :error
)

git add -A
if errorlevel 1 goto :error

git diff --cached --quiet
if errorlevel 2 goto :error
if errorlevel 1 (
    git commit -m "Update Visual C++ snippets"
    if errorlevel 1 goto :error
) else (
    echo No new changes to commit.
)

git push
if errorlevel 1 goto :error

echo.
echo Sync completed successfully.
pause
exit /b 0

:error
echo.
echo Sync failed. Check the error message above.
pause
exit /b 1
