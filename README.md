# FPS Boost v3.0.0 — Application Windows 10 / 11

Application desktop signée numériquement d'optimisation système, télémétrie matérielle 100% temps réel, lab réseau, bouclier Anti-DDoS et centre de mises à jour pour **Windows 10 & Windows 11 (64-bit)**.

> **Distribution officielle uniquement (package MSIX signé SHA-256)** — L'application s'installe dans le conteneur système protégé Windows (`WindowsApps`) et son intégrité cryptographique est vérifiée avant chaque installation.

---

## Installation (Tout PC Windows)

1. Téléchargez le dépôt (**Code -> Download ZIP** et extrayez le dossier) ou clonez-le :
   ```bash
   git clone https://github.com/Hiver-protect/FpsBoost.git
   cd FpsBoost
   ```
2. Faites un clic droit ou double-cliquez sur **`Installer_MSIX.bat`** puis acceptez l'élévation **Administrateur (UAC)**.
3. L'installeur effectue automatiquement :
   - Le déblocage des fichiers téléchargés ;
   - L'installation du certificat officiel **`FPSBoost_Cert.cer`** (`CN=LeVraisJay`) ;
   - La vérification cryptographique de la signature SHA-256 de **`FPSBoost_v3.0.0.msix`** ;
   - L'installation de **FPS Boost** dans le Menu Démarrer Windows (et commande `fpsboost.exe`).

---

## Fonctionnalités Clés

- **Télémétrie Temps Réel Synchronisée** : CPU global & par cœur (`C0..C31`), Turbo GHz, GPU NVIDIA/AMD/Intel (64-bit VRAM, horloges, températures), RAM exacte (`Utilisée + Libre`), SSD/NVMe (santé + température IOCTL directe), réseau & ping ICMP/jitter.
- **Optimiseur Système & Analyseur de Goulot** : Mode Jeu, HAGS, Timer noyau `0.5 ms`, Profils **Esports 0-Latence**, Purge Standby RAM & Auto-Boost jeu actif.
- **Processus Pro & Réseau Anti-DDoS** : Priorités & affinité CPU persistantes, EcoQoS Win32, Sonde MTU, Benchmark DNS, Pare-feu & **Mode Bunker**.
- **Centre de Mises à Jour Live** : Contrôle SHA-256, suivi version GitHub et scanner/installeur de mises à jour PC via **Winget** en temps réel.

---

## Prérequis
- Windows 10 ou Windows 11 (64-bit)
- Droits Administrateur requis lors de l'installation du certificat/MSIX et des tweaks système
