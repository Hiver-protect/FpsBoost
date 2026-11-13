@echo off
setlocal EnableDelayedExpansion
title FPS Boost - Assistant d'Installation Pro
cd /d "%~dp0"

echo.
echo  ==============================================================
echo   FPS Boost v3.0 Pro - Installeur Securise et Anti-Blocage
echo  ==============================================================
echo.

:: 1. Verifie si elevated, sinon tente l'elevation doucement sans bloquer
set "IS_ADMIN=0"
net session >nul 2>&1
if %errorlevel% equ 0 (
    set "IS_ADMIN=1"
) else (
    if /i "%~1" NEQ "__user" if /i "%~1" NEQ "__elevated" (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Start-Process cmd.exe -ArgumentList '/c \"\"%~f0\" __elevated\"' -Verb RunAs } catch { Start-Process cmd.exe -ArgumentList '/c \"\"%~f0\" __user\"' }"
        exit /b
    )
)

:: 2. Deblocage de tous les fichiers (Zone.Identifier Mark of the Web)
echo [1/4] Deblocage des fichiers telecharges...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -LiteralPath '%~dp0' -File -ErrorAction SilentlyContinue | Unblock-File -ErrorAction SilentlyContinue"

:: 3. Activation du Sideloading Windows (Systeme et Utilisateur)
echo [2/4] Configuration Windows Sideloading (Approbation des applications)...
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $cu='HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'; if(-not (Test-Path $cu)){New-Item -Path $cu -Force | Out-Null}; Set-ItemProperty -Path $cu -Name 'AllowAllTrustedApps' -Type DWord -Value 1 -Force } catch {}; if ('%IS_ADMIN%' -eq '1') { try { $lm='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'; if(-not (Test-Path $lm)){New-Item -Path $lm -Force | Out-Null}; Set-ItemProperty -Path $lm -Name 'AllowAllTrustedApps' -Type DWord -Value 1 -Force } catch {} }"

:: 4. Installation du Certificat dans TrustedPeople & Racine
if exist "%~dp0FPSBoost_Cert.cer" (
    echo [3/4] Enregistrement du certificat officiel dans le magasin securise...
    certutil -user -addstore -f "TrustedPeople" "%~dp0FPSBoost_Cert.cer" >nul 2>&1
    certutil -user -addstore -f "Root" "%~dp0FPSBoost_Cert.cer" >nul 2>&1
    if "%IS_ADMIN%"=="1" (
        certutil -addstore -f "TrustedPeople" "%~dp0FPSBoost_Cert.cer" >nul 2>&1
        certutil -addstore -f "Root" "%~dp0FPSBoost_Cert.cer" >nul 2>&1
    )
    powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Import-Certificate -FilePath '%~dp0FPSBoost_Cert.cer' -CertStoreLocation 'Cert:\CurrentUser\TrustedPeople' -ErrorAction SilentlyContinue | Out-Null } catch {}"
)

:: 5. Deploiement MSIX
if exist "%~dp0FPSBoost_v3.0.0.msix" (
    echo [4/4] Installation du package FPS Boost v3.0 dans WindowsApps...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Add-AppxPackage -Path '%~dp0FPSBoost_v3.0.0.msix' -ForceApplicationShutdown -ForceUpdateFromAnyVersion -ErrorAction Stop } catch { Add-AppxPackage -Path '%~dp0FPSBoost_v3.0.0.msix' -ForceApplicationShutdown -ErrorAction Stop }"
)

:: 6. Creation Raccourci Bureau
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $ws=New-Object -ComObject WScript.Shell; $sc=$ws.CreateShortcut([IO.Path]::Combine([Environment]::GetFolderPath('DesktopDirectory'),'FPS Boost.lnk')); $sc.TargetPath='explorer.exe'; $sc.Arguments='shell:AppsFolder\LeVraisJay.LvFpsBoost_kh9jwpr5ga4ae!App'; $sc.Description='FPS Boost Pro'; $sc.Save() } catch {}"

echo.
echo  ==============================================================
echo   INSTALLATION REUSSIE ! Lancement automatique de FPS Boost...
echo  ==============================================================
echo.

:: 7. Lancement automatique direct
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process 'explorer.exe' -ArgumentList 'shell:AppsFolder\LeVraisJay.LvFpsBoost_kh9jwpr5ga4ae!App'"

ping 127.0.0.1 -n 3 >nul
exit /b 0
