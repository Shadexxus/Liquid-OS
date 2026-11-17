# Liquid Universal OS — Alpha 0.1 (fixed source)

This is a **source project, not a built or boot-tested ISO**. It targets Debian 13 (trixie), amd64, XFCE/X11, an ISO-hybrid live image that can boot in legacy BIOS mode. The initial version does **not** install to a hard disk.

## GitHub Actions — shortest method

1. Create an empty GitHub repository.
2. **Extract this ZIP**, then upload the *contents of the `liquid-universal-os-alpha01/` folder* to the repository root. Do not upload just the ZIP itself.
3. Ensure the repository contains exactly one workflow: `.github/workflows/build-live-iso.yml`. **Do not keep old `main.yml` / `build-liquid-os.yml` workflows.**
4. GitHub → **Actions** → **Build Liquid Universal OS ISO** → **Run workflow** (default branch).
5. If successful, open the completed run → **Artifacts** → download `Liquid-Universal-OS-Alpha-0.1`, extract the archive to get the `.iso` and SHA256SUMS.
6. In VirtualBox, create Linux / Debian (64-bit), 4 GiB RAM, 2 vCPU, EFI off, VMSVGA, and attach the `.iso` as optical disk. Boot in live mode. Never confuse this archive with the actual `.iso`.

## How the CI fixes the previous failures

- Uses `debian:trixie` **inside an explicit `sudo docker run --privileged` step**, not GitHub Actions job-level `container:`. This enables `/proc` and `/dev/pts` mounting required by `live-build`.
- Runs Debian 13 `live-build`, with the Debian 13 `--bootloaders syslinux` option. The earlier `--bootloaders` incompatibility arose from running on Ubuntu's different live-build version.
- Builds and uploads the ISO, checksum and log. The first working desktop boot still requires manual verification in VirtualBox.

## Local Debian 13 build

```bash
sudo apt-get update
sudo apt-get install -y live-build debootstrap squashfs-tools xorriso isolinux syslinux-common syslinux-utils dosfstools mtools ca-certificates python3
bash scripts/verify-project.sh
sudo bash scripts/build-iso.sh
bash scripts/check-iso.sh dist/Liquid-Universal-OS-Alpha-0.1-amd64.iso
```

### Known limitations

The visual Liquid UI is a **concept**; the live session uses working XFCE with branded wallpapers and small theme/control utilities. Windows game compatibility, a custom compositor, an independent kernel and full desktop animations are not implemented. Building the source requires network access to Debian mirrors and sufficient disk space. The CI workflow has been statically checked, but no complete ISO build or virtual-machine boot has been verified in this environment.
