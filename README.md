# NixOS Multi-Host Configuration

Ten repository zawiera konfigurację NixOS przystosowaną do łatwego zarządzania wieloma hostami. Umożliwia synchronizację konfiguracji między różnymi komputerami, gdzie każdy host ma własną konfigurację sprzętową.

## Struktura projektu

```
├── flake.nix                 # Definicje wszystkich hostów
├── flake.lock               # Zablokowane wersje zależności
├── common/
│   └── common.nix           # Wspólne ustawienia systemowe
├── users/
│   └── anrzej.nix           # Konfiguracja użytkownika
├── home/
│   └── home.nix             # Konfiguracja home-manager
├── hosts/
│   ├── t490/
│   │   ├── default.nix      # Konfiguracja specyficzna dla T490
│   │   └── hardware-configuration.nix
│   ├── p14s/
│   │   ├── default.nix      # Konfiguracja specyficzna dla P14s
│   │   └── hardware-configuration.nix
│   └── server/
│       ├── default.nix      # Konfiguracja specyficzna dla serwera
│       └── hardware-configuration.nix
└── dotfiles_configs/        # Dodatkowe pliki konfiguracyjne
```

## Dostępne hosty

- **anrzej-t490** - Laptop T490 (aktualny komputer)
- **anrzej-p14s** - Laptop P14s
- **anrzej-server** - Konfiguracja serwera (bez GUI)

## Instalacja na nowym komputerze

### 1. Sklonuj repository
```bash
git clone https://github.com/AnrzejAF/nixos-config.git
cd nixos-config
```

### 2. Wygeneruj konfigurację sprzętową
```bash
# Dla nowego hosta (np. P14s)
sudo nixos-generate-config --show-hardware-config > hosts/p14s/hardware-configuration.nix

# Lub jeśli instalujesz z ISO
sudo nixos-generate-config --root /mnt --show-hardware-config > hosts/p14s/hardware-configuration.nix
```

### 3. Zbuduj system
```bash
# Dla T490
sudo nixos-rebuild switch --flake .#anrzej-t490

# Dla P14s
sudo nixos-rebuild switch --flake .#anrzej-p14s

# Dla serwera
sudo nixos-rebuild switch --flake .#anrzej-server
```

## Synchronizacja między hostami

### Co synchronizować
- `common/common.nix` - wspólne ustawienia systemowe
- `users/anrzej.nix` - konfiguracja użytkownika
- `home/home.nix` - ustawienia home-manager
- `hosts/*/default.nix` - konfiguracje specyficzne dla hostów

### Czego NIE synchronizować
- `hosts/*/hardware-configuration.nix` - te pliki są unikalne dla każdego komputera

### Workflow
1. Zrób zmiany w plikach konfiguracyjnych
2. Commituj tylko zmiany nie związane ze sprzętem:
   ```bash
   git add common/ users/ home/ hosts/*/default.nix
   git commit -m "Update configuration"
   git push
   ```
3. Na innych hostach:
   ```bash
   git pull
   sudo nixos-rebuild switch --flake .#anrzej-[hostname]
   ```

## Dodawanie nowego hosta

### 1. Utwórz folder dla nowego hosta
```bash
mkdir -p hosts/nowy-host
```

### 2. Utwórz default.nix
```nix
{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
    ../../users/anrzej.nix
  ];

  networking.hostName = "anrzej-nowy-host";
  
  # Host-specific configuration
}
```

### 3. Wygeneruj hardware-configuration.nix
```bash
sudo nixos-generate-config --show-hardware-config > hosts/nowy-host/hardware-configuration.nix
```

### 4. Dodaj do flake.nix
```nix
anrzej-nowy-host = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./hosts/nowy-host
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.anrzej = import ./home/home.nix;
    }
  ];
  specialArgs = {
    flatpaks = inputs.flatpaks;
  };
};
```

## Konfiguracja specyficzna dla hostów

### T490 (Desktop/Laptop)
- Pełna konfiguracja z GUI (Plasma 6)
- Steam, Docker, programy deweloperskie
- Konfiguracja dla pracy i rozrywki

### P14s (Laptop biznesowy)
- Podobna do T490, możliwe dostosowania pod biznes
- Inne sterowniki graficzne (jeśli potrzebne)

### Server
- Bez GUI (wyłączone X11, SDDM, Plasma)
- Włączone SSH
- Wyłączone Steam, KDE Connect
- Minimalna konfiguracja dla serwera

## Przydatne komendy

```bash
# Sprawdź status buildu
nix flake check

# Zbuduj bez przełączania
sudo nixos-rebuild build --flake .#anrzej-t490

# Pokaż różnice
nixos-rebuild build --flake .#anrzej-t490 

# Aktualizuj flake inputs
nix flake update

# Wyczyść stare generacje
sudo nix-collect-garbage -d
```

## Rozwiązywanie problemów

### Problem z hardware-configuration.nix
Jeśli system nie bootuje po synchronizacji, prawdopodobnie skopiowałeś hardware-configuration.nix z innego hosta. Wygeneruj nowy:
```bash
sudo nixos-generate-config --show-hardware-config > hosts/[twoj-host]/hardware-configuration.nix
```

### Problem z hostname
Upewnij się, że hostname w `hosts/*/default.nix` jest unikalny i odpowiada nazwie w flake.nix.

### Problem z budowaniem
Sprawdź błędy składni:
```bash
nix flake check
```