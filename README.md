# Gershwin Library

Essential system-wide preferences, user templates, and configuration for Gershwin. Dynamically installs assets into /Library and creates a tar archive for AMD64 or ARM64 used during ISO creation.

## Installation
To install the Gershwin libraries package, follow these steps:

1. Clone the repository:
   ```
   git clone https://github.com/gershwin-os/library.git
   cd library
   ```

2. Install using make:
```
sudo make install
```

## Uninstallation

```
sudo make uninstall
```

## Cleanup

This command will remove the gershwin-library-AMD64.tar.gz or gershwin-library-ARM64.tar.gz tar archive:

```
sudo make clean
```