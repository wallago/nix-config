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
    hash = "sha256-U06lFiRzL/ywo8a4CDvRi9EybZj/wAiYAq0Jnd7XRds=";
  };

  cargoHash = "sha256-Jum0abPXkCv2Itx5vIBDRXYUpJIZWeh+kAcbBOKJKO0=";

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
