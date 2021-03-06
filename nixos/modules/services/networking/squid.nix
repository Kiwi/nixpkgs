{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.squid;


  squidConfig = pkgs.writeText "squid.conf"
    (if cfg.configText != null then cfg.configText else
    ''
      #
      # Recommended minimum configuration (3.5):
      #

      # Example rule allowing access from your local networks.
      # Adapt to list your (internal) IP networks from where browsing
      # should be allowed
      acl localnet src 10.0.0.0/8     # RFC 1918 possible internal network
      acl localnet src 172.16.0.0/12  # RFC 1918 possible internal network
      acl localnet src 192.168.0.0/16 # RFC 1918 possible internal network
      acl localnet src 169.254.0.0/16 # RFC 3927 link-local (directly plugged) machines
      acl localnet src fc00::/7       # RFC 4193 local private network range
      acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines

      acl SSL_ports port 443          # https
      acl Safe_ports port 80          # http
      acl Safe_ports port 21          # ftp
      acl Safe_ports port 443         # https
      acl Safe_ports port 70          # gopher
      acl Safe_ports port 210         # wais
      acl Safe_ports port 1025-65535  # unregistered ports
      acl Safe_ports port 280         # http-mgmt
      acl Safe_ports port 488         # gss-http
      acl Safe_ports port 591         # filemaker
      acl Safe_ports port 777         # multiling http
      acl CONNECT method CONNECT

      #
      # Recommended minimum Access Permission configuration:
      #
      # Deny requests to certain unsafe ports
      http_access deny !Safe_ports

      # Deny CONNECT to other than secure SSL ports
      http_access deny CONNECT !SSL_ports

      # Only allow cachemgr access from localhost
      http_access allow localhost manager
      http_access deny manager

      # We strongly recommend the following be uncommented to protect innocent
      # web applications running on the proxy server who think the only
      # one who can access services on "localhost" is a local user
      http_access deny to_localhost

      # Application logs to syslog, access and store logs have specific files
      cache_log       syslog
      access_log      stdio:/var/log/squid/access.log
      cache_store_log stdio:/var/log/squid/store.log

      # Required by systemd service
      pid_filename    /run/squid.pid

      # Run as user and group squid
      cache_effective_user squid squid

      #
      # INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
      #
      ${cfg.extraConfig}

      # Example rule allowing access from your local networks.
      # Adapt localnet in the ACL section to list your (internal) IP networks
      # from where browsing should be allowed
      http_access allow localnet
      http_access allow localhost

      # And finally deny all other access to this proxy
      http_access deny all

      # Squid normally listens to port 3128
      http_port ${toString cfg.proxyPort}

      # Leave coredumps in the first cache dir
      coredump_dir /var/cache/squid

      #
      # Add any of your own refresh_pattern entries above these.
      #
      refresh_pattern ^ftp:           1440    20%     10080
      refresh_pattern ^gopher:        1440    0%      1440
      refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
      refresh_pattern .               0       20%     4320
    '');

in

{

  options = {

    services.squid = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to run squid web proxy.";
      };

      proxyPort = mkOption {
        type = types.int;
        default = 3128;
        description = "TCP port on which squid will listen.";
      };

      extraConfig = mkOption {
        type = types.lines;
        default = "";
        description = ''
          Squid configuration. Contents will be added
          verbatim to the configuration file.
        '';
      };

      configText = mkOption {
        type = types.nullOr types.lines;
        default = null;
        description = ''
          Verbatim contents of squid.conf. If null (default), use the
          autogenerated file from NixOS instead.
        '';
      };

    };

  };

  config = mkIf cfg.enable {

    users.users.squid = {
      isSystemUser = true;
      group = "squid";
      home = "/var/cache/squid";
      createHome = true;
    };

    users.groups.squid = { };

    systemd.services.squid = {
      description = "Squid caching web proxy";
      after = [ "network.target" "nss-lookup.target" ];
      wantedBy = [ "multi-user.target" ];
      preStart = ''
        mkdir -p "/var/log/squid"
        chown squid:squid "/var/log/squid"
      '';
      serviceConfig = {
        Type = "forking";
        PIDFile = "/run/squid.pid";
        ExecStart = "${pkgs.squid}/bin/squid -YCs -f ${squidConfig}";
      };
    };

  };

}
