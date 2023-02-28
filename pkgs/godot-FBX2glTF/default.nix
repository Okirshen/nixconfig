{
  stdenv,
  lib,
  fetchurl,
  unzip,
  autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname ="godot-FBX2glTF";
  version = "v0.13.0-p1";
  meta = with lib; {
    description = "A command-line tool for the conversion of 3D model assets on the FBX file format to the glTF file format.";
    platforms = platforms.linux;
    license = licenses.unfreeRedistributable;
    homepage = "https://github.com/godotengine/FBX2glTF";
    downloadPage = "https://github.com/godotengine/FBX2glTF/releases";
    maintainers = with maintainers; [ okirshen ];
    mainProgram = "FBX2glTF";
  };
  src = fetchurl {
    url = "https://github.com/godotengine/FBX2glTF/releases/download/${version}/FBX2glTF-linux-x86_64.zip";
    sha256 = "68f7f609125e60197faf2edfdeee7bb0f0087f01e2b260e9b6f942377a6c8931";
  };

  nativeBuildInputs = [ 
    unzip 
    autoPatchelfHook
  ];

  libPath = lib.makeLibraryPath [
    stdenv.cc.cc.lib
  ];

  preBuild = ''
    addAutoPatchelfSearchPath ${libPath}
  '';

  installPhase = ''
    mkdir -p "$out/bin"
    mv "FBX2glTF-linux-x86_64" "$out/bin/FBX2glTF"
    '';

  
}