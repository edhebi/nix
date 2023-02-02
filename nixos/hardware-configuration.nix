{ pkgs, inputs, ... }:

{
	imports = [
		inputs.hardware.nixosModules.common-cpu-intel
		inputs.hardware.nixosModules.common-gpu-nvidia
		inputs.hardware.nixosModules.common-pc-ssd
	];

	boot = {
		initrd = {
			availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
			kernelModules = [ "kvm-intel" ];
		};
		loader.efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot/efi";
		};
		loader.grub = {
			enable = true;
			version = 2;
			efiSupport = true;
			devices = ["nodev"];
			useOSProber = true;
		};
	};

	environment.systemPackages = [ pkgs.os-prober ];

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/4d3128ac-750f-4e29-9d5b-2389b93a4294";
			fsType = "btrfs";
			options = [ "subvol=@" ];
		};
		"/boot/efi" = {
			device = "/dev/disk/by-uuid/AAB4-A520";
			fsType = "vfat";
		};
	};

	nixpkgs.hostPlatform.system = "x86_64-linux";
	hardware.video.hidpi.enable = true;
	hardware.nvidia.prime.offload.enable = false;
}
