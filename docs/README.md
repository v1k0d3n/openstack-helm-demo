# Getting Started

1. First, update the host and reboot.

```
sudo apt-get update && sudo apt-get dist-upgrade -y && sudo reboot
```

2. When the host comes back, clone the repository into the /opt directory (example below).

```
git clone git@github.com:v1k0d3n/demo.git && sudo mv demo /opt/demo
```

3. Make sure that a second interface exists, and remains available for OpenStack-Helm to use. This means that the interface is up, yet not specifically configured like the "Interface Example" below.

Interface Example:
```
ubuntu@os-demo:/opt/demo$ cat /etc/network/interfaces

### Unused Interface for Provider Networks:
auto ens4
iface ens4 inet manual
  pre-up ip link set ens4 up

ubuntu@os-demo:/opt/demo$ sudo ifup ens4
```

4. It's helpful to add `/opt/demo/` to your bashrc file (if using bash).

```
export PATH=${PATH}:/opt/demo
```
