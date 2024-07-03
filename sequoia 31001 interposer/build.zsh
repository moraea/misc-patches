set -e

victim=AMDMTLBronzeDriver
reexported=/System/Library/Frameworks/IOSurface.framework/Versions/A/IOSurface

cd "$tmp"
PATH+=:"$PWD"

cp ${victim}_original $victim

install_name_tool -change $reexported /System/Library/Extensions/impostor.dylib $victim

clang -fmodules -dynamiclib interpose.m -Wno-unused-getter-return-value -Xlinker -no_warn_inits -I non-metal-common/Utils -I . -install_name /System/Library/Extensions/impostor.dylib -Xlinker -reexport_library -Xlinker $reexported -o impostor.dylib
