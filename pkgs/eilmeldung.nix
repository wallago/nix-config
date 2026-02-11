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
    hash = "sha256-mevjTJ+8g0Rot2A41C5SBhap+hpuOyOcm2DsNG2X3xY=";
  };

  cargoHash = "sha256-RTIIAGnhttEhx9FuVUWbo/+Ce3k28NW2YPHCJxwnCW8=";

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
