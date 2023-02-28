{ fetchFromGitHub, stdenv, lib }

stdenv.mkDerivation rec {
  pname = "fbx2gltf";
  version = "v0.13.0-p1";

  src = fetchFromGithub {
    owner = "godotengine"
    repo = "FBX2glTF"
    hash
  }
  
}