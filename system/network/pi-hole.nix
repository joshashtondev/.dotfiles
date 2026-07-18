{ config, pkgs, ... }:

{

  networking.networkmanager.insertNameservers = [ "127.0.0.1" ];

  systemd.tmpfiles.rules = [
    "d /var/lib/pihole 0777 root root -"
    "d /var/lib/pihole/etc 0777 root root -"
    "d /var/lib/pihole/dnsmasq 0777 root root -"
  ];

  # Explicitly set the OCI container backend to Podman
  virtualisation.oci-containers.backend = "podman";

  # Define the Pi-Hole container
  virtualisation.oci-containers.containers.pihole = {
    image = "docker.io/pihole/pihole:latest";
    
    ports = [
      "53:53/tcp"   # DNS
      "53:53/udp"   # DNS
      "8775:80/tcp"   # Web UI
    ];
    
    volumes = [
      "/var/lib/pihole/etc:/etc/pihole"
      "/var/lib/pihole/dnsmasq:/etc/dnsmasq.d"
    ];
    
    environment = {
      TZ = "America/Denver"; 
    };
    
    autoStart = true;
    
    # Extra Podman arguments for additional capabilities Pi-Hole requires
    extraOptions = [
      "--cap-add=NET_ADMIN"
    ];
  };

  # Open the required ports in the NixOS firewall
  networking.firewall = {
    allowedTCPPorts = [ 53 80 ];
    allowedUDPPorts = [ 53 ];
  };
}
