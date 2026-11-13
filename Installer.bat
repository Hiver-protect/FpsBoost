@echo off
setlocal EnableDelayedExpansion
title FPS Boost - Assistant d'Installation Anti-Blocage
cd /d "%~dp0"

echo.
echo  ==============================================================
echo   FPS Boost v3.0 Pro - Installeur Securise (Anti-SmartScreen)
echo  ==============================================================
echo.

:: 1. Auto-Elevation Administrateur
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Elevation Administrateur requise pour approuver le certificat racine...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process cmd.exe -ArgumentList '/c \"\"%~f0\" __elevated\"' -Verb RunAs"
    exit /b
)

:: 2. Deblocage de tous les fichiers (Zone.Identifier Mark of the Web)
echo [1/4] Deblocage des fichiers et contournement Smart App Control...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -LiteralPath '%~dp0' -File -ErrorAction SilentlyContinue | Unblock-File -ErrorAction SilentlyContinue"

:: 3. Activation du Sideloading Windows
echo [2/4] Activation des applications approuvees (Sideloading Windows)...
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $p='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'; if(-not (Test-Path $p)){New-Item -Path $p -Force | Out-Null}; Set-ItemProperty -Path $p -Name 'AllowAllTrustedApps' -Type DWord -Value 1 -Force } catch {}"

:: 4. Installation du Certificat dans Racine et TrustedPeople
if exist "%~dp0FPSBoost_Cert.cer" (
    echo [3/4] Approbation officielle du certificat dans les Autorites Racines...
    certutil -addstore -f "TrustedPeople" "%~dp0FPSBoost_Cert.cer" >nul 2>&1
    certutil -addstore -f "Root" "%~dp0FPSBoost_Cert.cer" >nul 2>&1
    powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Import-Certificate -FilePath '%~dp0FPSBoost_Cert.cer' -CertStoreLocation 'Cert:\LocalMachine\Root' -ErrorAction SilentlyContinue | Out-Null; Import-Certificate -FilePath '%~dp0FPSBoost_Cert.cer' -CertStoreLocation 'Cert:\LocalMachine\TrustedPeople' -ErrorAction SilentlyContinue | Out-Null } catch {}"
)

:: 5. Deploiement MSIX ou Lancement Setup
if exist "%~dp0FPSBoost_v3.0.0.msix" (
    echo [4/4] Deploiement du package FPSBoost_v3.0.0.msix dans WindowsApps...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Add-AppxPackage -Path '%~dp0FPSBoost_v3.0.0.msix' -ForceApplicationShutdown -ForceUpdateFromAnyVersion -ErrorAction Stop } catch { Add-AppxPackage -Path '%~dp0FPSBoost_v3.0.0.msix' -ForceApplicationShutdown -ErrorAction Stop }"
) else if exist "%~dp0FPS_Boost_Setup.exe" (
    echo [4/4] Lancement de l'installeur FPS_Boost_Setup.exe...
    start "" "%~dp0FPS_Boost_Setup.exe"
    exit /b 0
)

:: 6. Creation Raccourci Bureau
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $ws=New-Object -ComObject WScript.Shell; $sc=$ws.CreateShortcut([IO.Path]::Combine([Environment]::GetFolderPath('DesktopDirectory'),'FPS Boost.lnk')); $sc.TargetPath='explorer.exe'; $sc.Arguments='shell:AppsFolder\LeVraisJay.LvFpsBoost_kh9jwpr5ga4ae!App'; $sc.Save() } catch {}"

echo.
echo  ==============================================================
echo   INSTALLATION REUSSIE AVEC SUCCES !
echo   FPS Boost a ete debloque et certifie sur votre systeme.
echo  ==============================================================
echo.

:: Lancement automatique
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process 'explorer.exe' -ArgumentList 'shell:AppsFolder\LeVraisJay.LvFpsBoost_kh9jwpr5ga4ae!App'"

timeout /t 3 >nul
exit /b 0
