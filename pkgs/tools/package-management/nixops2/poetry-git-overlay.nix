{ pkgs }:
self: super: {

  nixops = super.nixops.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/NixOS/nixops.git";
        rev = "8de09879d7b1733bc4085257d5bf3cc734f1ed38";
        sha256 = "0j61q2hfik2hc6pd2jn439g67xx3x20vj8g1bsnhd4hh9wwv7i7c";
      };
    }
  );

  nixops-aws = super.nixops-aws.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/NixOS/nixops-aws.git";
        rev = "7983b03028f1ce139fb2671447fdb87a50e16f68";
        sha256 = "0lq1k2s13jnp20dmds9s4d011vhvv27079ch9w295ibij19kdl9i";
      };
    }
  );

  nixops-digitalocean = super.nixops-digitalocean.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixops-digitalocean.git";
        rev = "60f34f191f5d6658cf0b1e7f98492b8edb12c4f9";
        sha256 = "01y71b00lf8vl6cmp6lnc2h9zlvpppgrk7v3hhk9q2kmswpyfbbr";
      };
    }
  );

  nixops-encrypted-links = super.nixops-encrypted-links.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixops-encrypted-links.git";
        rev = "045d25facbf52dcd63b005392ecd59005fb1d20a";
        sha256 = "00lw4bn2abzgwhjj4bz97fqmiymj3a4fxznyg5drxqwl71h5qgib";
      };
    }
  );

  nixops-gcp = super.nixops-gcp.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixops-gce.git";
        rev = "1dc678c0b51ecd823d2531754b3a194462651b79";
        sha256 = "0qfkiwchhczcvmvmr70mq38k6jl9vciisb89ny6clg35r0qc2pin";
      };
    }
  );

  nixops-virtd = super.nixops-virtd.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixops-libvirtd.git";
        rev = "af6cf5b2ced57b7b6d36b5df7dd27a14e0a5cfb6";
        sha256 = "1j75yg8a44dlbig38mf7n7p71mdzff6ii1z1pdp32i4ivk3l0hy6";
      };
    }
  );

  nixopsvbox = super.nixopsvbox.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixops-vbox.git";
        rev = "2729672865ebe2aa973c062a3fbddda8c1359da0";
        sha256 = "07bmrbg3g2prnba2kwg1rg6rvmnx1vzc538y2q3g04s958hala56";
      };
    }
  );

  nixos-modules-contrib = super.nixos-modules-contrib.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixos-modules-contrib.git";
        rev = "6e4d21f47f0c40023a56a9861886bde146476198";
        sha256 = "12zp1hfmwfnbv7ca8vq95zz92jiabr5ar0xq6g4j7m7li6d3ifcn";
      };
    }
  );

}
