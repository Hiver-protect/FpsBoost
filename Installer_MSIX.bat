@echo off
setlocal
title Installation FPS Boost MSIX (Windows 10 / 11)
cd /d "%~dp0"

set "LV_INSTALL_BAT=%~f0"
set "LV_DIR=%~dp0"
set "LV_CER=%~dp0FPSBoost_Cert.cer"
set "LV_MSIX=%~dp0FPSBoost_v3.0.0.msix"

net session >nul 2>&1
if %errorlevel% neq 0 (
  if /i "%~1" NEQ "__elevated" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath $env:LV_INSTALL_BAT -ArgumentList '__elevated' -Verb RunAs"
    exit /b
  )
)

echo.
echo  ============================================================
echo   FPS Boost v3.0.0 - Installation Package MSIX Securise
echo  ============================================================
echo.

if not exist "%LV_MSIX%" (
  echo [ERREUR] Package introuvable : %LV_MSIX%
  pause
  exit /b 1
)

echo [1/4] Preparation Windows & deblocage fichiers telecharges...
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "try { Get-ChildItem -LiteralPath $env:LV_DIR -File -EA SilentlyContinue | Unblock-File -EA SilentlyContinue } catch {}; try { $p='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'; if(-not (Test-Path $p)){New-Item -Path $p -Force | Out-Null}; Set-ItemProperty -Path $p -Name 'AllowAllTrustedApps' -Type DWord -Value 1 -Force } catch {}"

if exist "%LV_CER%" (
  echo [2/4] Installation du certificat officiel CN=LeVraisJay...
  "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "Import-Certificate -FilePath $env:LV_CER -CertStoreLocation 'Cert:\LocalMachine\Root' | Out-Null; Import-Certificate -FilePath $env:LV_CER -CertStoreLocation 'Cert:\LocalMachine\TrustedPeople' | Out-Null"
) else (
  echo [2/4] Verification de la signature integree...
)

"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "$s = Get-AuthenticodeSignature -LiteralPath $env:LV_MSIX; if ($s.Status -ne 'Valid' -or $s.SignerCertificate.Subject -notlike '*CN=LeVraisJay*') { Write-Host ('[ERREUR INTEGRITE] Signature MSIX invalide ou package modifie (' + $s.Status + ').'); exit 2 }"
if %errorlevel% neq 0 (
  echo.
  echo [BLOCAGE SECURITE] Le package MSIX a ete modifie ou sa signature n'est pas valide.
  pause
  exit /b 2
)

echo [3/4] Installation de FPSBoost_v3.0.0.msix (mode protege WindowsApps)...
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "try { Add-AppxPackage -Path $env:LV_MSIX -ForceApplicationShutdown -ForceUpdateFromAnyVersion -EA Stop } catch { Add-AppxPackage -Path $env:LV_MSIX -ForceApplicationShutdown -EA Stop }"
if %errorlevel% neq 0 (
  echo.
  echo [ERREUR] Echec de l'installation MSIX ^(code %errorlevel%^).
  pause
  exit /b %errorlevel%
)

echo [4/4] Installation terminee avec succes ^(application verrouillee en lecture seule^) !
echo.
set /p LAUNCH_NOW="Lancer FPS Boost maintenant ? (O/N) : "
if /i "%LAUNCH_NOW%"=="O" (
  "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "$p = Get-AppxPackage -Name 'LeVraisJay.LvFpsBoost' | Select-Object -First 1; if ($p) { Start-Process 'explorer.exe' -ArgumentList ('shell:AppsFolder\' + $p.PackageFamilyName + '!App') }"
)
exit /b 0
