{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "SpoofDPI";
  version = "0.10.8";

  src = fetchFromGitHub {
    owner = "xvzc";
    repo = "SpoofDPI";
    rev = "v0.10.8";
    hash = "sha256-gAC5nlFVlcRqWLytKpeki/Y7i4kHjVQ/B4ByHYTVSH0=";
  };

  vendorHash = "sha256-sIqkpoaXx+Un1GdOKgPkZnn3/DWCNAcDHqGaw8i6qDk=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.currentSha=${src.rev}"
  ];

  meta = {
    description = "A simple and fast anti-censorship tool written in Go";
    homepage = "https://github.com/xvzc/SpoofDPI";
  };
}
