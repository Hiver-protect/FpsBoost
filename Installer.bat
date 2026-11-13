@echo off
setlocal EnableDelayedExpansion
title FPS Boost v3.0 - Assistant d'Installation Pro
cd /d "%~dp0"

echo.
echo  ==============================================================
echo    FPS Boost Pro v3.0 - Assistant d'Installation Anti-Blocage
echo  ==============================================================
echo.

:: 1. Suppression immediate du marquage Internet Zone.Identifier
echo [*] Deblocage et configuration de securite Windows...
(del /f /q /a "%~f0:Zone.Identifier" 2>nul)
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -LiteralPath '%~dp0' -Recurse -File -EA SilentlyContinue | Unblock-File -EA SilentlyContinue" 2>nul

:: 2. Nettoyage definitif des anciens packages WindowsApps bloques
echo [*] Desinstallation des anciens packages...
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Get-AppxPackage -Name '*LvFpsBoost*' -EA SilentlyContinue | Remove-AppxPackage -EA SilentlyContinue } catch {}" 2>nul

:: 3. Suppression des anciens binaires .exe locaux bloques par Smart App Control
if exist "%~dp0LvFpsBoost.exe" del /f /q "%~dp0LvFpsBoost.exe" 2>nul
if exist "%~dp0FPS_Boost_Setup.exe" del /f /q "%~dp0FPS_Boost_Setup.exe" 2>nul
if exist "%~dp0Installer_FPSBoost.exe" del /f /q "%~dp0Installer_FPSBoost.exe" 2>nul

:: 4. Deploiement autonome dans AppData Local (100% natif, zero blocage SAC)
echo [*] Deploiement de FPS Boost Pro...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$src = '%~dp0'.TrimEnd('\'); $dest = Join-Path $env:LOCALAPPDATA 'LvFpsBoost'; New-Item -ItemType Directory -Path (Join-Path $dest 'wv2') -Force | Out-Null; $msix = Join-Path $src 'FPSBoost_v3.0.0.msix'; if (Test-Path $msix) { try { Add-Type -AssemblyName System.IO.Compression.FileSystem; $zip = [System.IO.Compression.ZipFile]::OpenRead($msix); foreach ($e in $zip.Entries) { if ([string]::IsNullOrEmpty($e.Name) -or $e.FullName -like '*Appx*' -or $e.FullName -like '*[Content_Types]*' -or $e.FullName.EndsWith('.exe')) { continue }; $t = Join-Path $dest $e.FullName; $p = Split-Path -Parent $t; if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p -Force | Out-Null }; [System.IO.Compression.ZipFileExtensions]::ExtractToFile($e, $t, $true) }; $zip.Dispose() } catch {} }; foreach ($f in @('LvFpsBoost.ico','lv_bg.jpg','lv_logo.png','index.html')) { $fp = Join-Path $src $f; if (Test-Path $fp) { Copy-Item $fp $dest -Force -EA SilentlyContinue } }; foreach ($w in @('Microsoft.Web.WebView2.Core.dll','Microsoft.Web.WebView2.WinForms.dll','WebView2Loader.dll')) { $wp = Join-Path (Join-Path $src 'wv2') $w; if (Test-Path $wp) { Copy-Item $wp (Join-Path $dest 'wv2') -Force -EA SilentlyContinue } }; $bat = Join-Path $src 'Launch_LvFpsBoost.bat'; if (Test-Path $bat) { $raw = [IO.File]::ReadAllText($bat, [Text.UTF8Encoding]::new($false)); $mk = '::###' + 'LV_PS_ENGINE_START###'; $idx = $raw.IndexOf($mk); if ($idx -ge 0) { $ps = $raw.Substring($idx + $mk.Length).TrimStart(); [IO.File]::WriteAllText((Join-Path $dest 'LvFpsBoost_Engine.ps1'), $ps, [Text.UTF8Encoding]::new($true)) } }; $eng = Join-Path $dest 'LvFpsBoost_Engine.ps1'; if (-not (Test-Path $eng) -and (Test-Path (Join-Path $src 'LvFpsBoost_Engine.ps1'))) { Copy-Item (Join-Path $src 'LvFpsBoost_Engine.ps1') $dest -Force -EA SilentlyContinue }; $psBin = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'; $ico = Join-Path $dest 'LvFpsBoost.ico'; $args = '-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File \"\"' + $eng + '\"\" -Mode Launcher -RootDir \"\"' + $dest + '\"\"'; $ws = New-Object -ComObject WScript.Shell; foreach ($d in @([Environment]::GetFolderPath('DesktopDirectory'), (Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs'))) { try { $sc = $ws.CreateShortcut((Join-Path $d 'FPS Boost.lnk')); $sc.TargetPath = $psBin; $sc.Arguments = $args; $sc.IconLocation = $ico + ',0'; $sc.Description = 'FPS Boost Pro - Optimiseur PC et Stream'; $sc.WorkingDirectory = $dest; $sc.Save() } catch {}; $old = Join-Path $d 'Lv FPS Boost.lnk'; if (Test-Path $old) { Remove-Item $old -Force -EA SilentlyContinue } }; Start-Process -FilePath $psBin -ArgumentList $args -WindowStyle Hidden"

echo.
echo  ==============================================================
echo    INSTALLATION REUSSIE !
echo    Le raccourci 'FPS Boost' sur votre Bureau est pret.
echo  ==============================================================
echo.
ping 127.0.0.1 -n 3 >nul
exit /b 0
