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
    hash = "sha256-ytFL4Ix4CRFnC+txHO2U7477BLzJAeaL+Yw38gYoTDs=";
  };

  cargoHash = "sha256-906oyvbeDx3332qbuBMsKpPpz3VrDoRMRTMJGXtuMjw=";

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
