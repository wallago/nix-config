{
  fetchFromGitHub,
  rustPlatform,
  pkgs,
}:
rustPlatform.buildRustPackage rec {
  pname = "eilmeldung";
  version = "0.7.4";

  src = fetchFromGitHub {
    owner = "christo-auer";
    repo = "eilmeldung";
    rev = "main";
    hash = "sha256-nRK939ZesKwHR3IUsiz/JBHB76rGkKSgHrpFfBmrtoI=";
  };

  cargoHash = "sha256-yktc3T1SG6oUpV6P2zCAGYjLnsuz+PGXLcjCXi6eFeg=";

  nativeBuildInputs = with pkgs; [
    pkg-config
    perl
    llvmPackages.libclang
  ];

  buildInputs = with pkgs; [
    openssl
    libxml2
    sqlite
  ];

  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
  BINDGEN_EXTRA_CLANG_ARGS = "-isystem ${pkgs.llvmPackages.libclang.lib}/lib/clang/${pkgs.llvmPackages.libclang.version}/include -isystem ${pkgs.glibc.dev}/include";
}
