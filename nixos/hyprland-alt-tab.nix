{
  pkgs,
  lib,
  fetchFromGitHub,
  python3,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "hyprland-alt-tab";
  name = "hyprtab";
  version = "1.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "simon-bueler";
    repo = "-Hyprland-Alt_tab";
    rev = "ff8604801d4e93c2d56930463322ca819253c203"; # If there is a release like v1.0, otherwise put the commit directly
    sha256 = "sha256-mn5gQEpJ1+us33z1K75Umpkd16+Ps3K1B0/L1zdXn1s="; # <-- dummy hash: after the first compilation this line will give an error and the correct hash. Replace lib.fakeSha256 with "givenhash". Or use nix-prefetch-git. On older nix, this might fail, use sha256 = lib.fakeSha256; instead.
  };

  buildInputs = with pkgs.python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with pkgs;
    [
      ccache
      gcc
      glibc
      zlib
      zstd
      libz
    ]
    ++ (with python3Packages; [
      pyside6
    ]);

  pythonEnv = pkgs.python3.buildEnv.override {
    extraLibs = with pkgs;
      [
        ccache
        gcc
        glibc
        zlib
        zstd
        libz
      ]
      ++ (with python3Packages; [
        pyside6
      ]);
    ignoreCollisions = true;
  };

  preBuild = ''
        cat > setup.py << EOF
    from setuptools import setup

    setup(
      name='hyprtab',
      version='1.0',
      scripts=[
        'Hyprtab.py',
      ],
    )
    EOF
  '';

  installPhase = ''
        mkdir -p $out/bin
        cat > $out/bin/${name} <<EOF
    #!/bin/sh
    exec ${pythonEnv}/bin/python3 ${src}/Hyprtab.py"\$@"
    EOF
        chmod +x $out/bin/${name}
  '';
}
