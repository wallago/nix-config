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
    hash = "sha256-qlnWjEx0PXRdtGhaK0sOj1QQKVb5pV+o5ihYotVsrdM=";
  };

  cargoHash = "sha256-gNwCZ+Jcy73lwm3y0UVtFM8PqZaDhyj+2NfZzyDsUcM=";

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
