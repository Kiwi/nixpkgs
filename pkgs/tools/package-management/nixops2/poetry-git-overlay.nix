{ pkgs }:
self: super: {

  nixops = super.nixops.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/NixOS/nixops.git";
        rev = "0330ead36be75c0b0f80cf84c227f13380daf414";
        sha256 = "0sdbzzhbjy3vly5zvzybalyc116gzg9lyikqps62drq7k6phpcnl";
      };
    }
  );

  nixops-aws = super.nixops-aws.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/NixOS/nixops-aws.git";
        rev = "36a200f1baec9c97590cf1c2ad2ad02fd88504cf";
        sha256 = "1j5y621cxk67zqnfix75j0f44q6c31frqfaxk3b88a9daa2h090z";
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
        rev = "f761368c248711085542efec604971651ca14033";
        sha256 = "1wfqmi0zj37f5iskgz46dz1rlphglhash24hqywxm7hcy82cdq8h";
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
        rev = "562760e68cbe7f82eaf25c78563c967706dc161a";
        sha256 = "1h02m2z1cn4a8gpjyij87fifdwahq23dbvwk0y5h6xfp5pi9k9w9";
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
