set -e

victim=AMDMTLBronzeDriver
reexported=/System/Library/Frameworks/IOSurface.framework/Versions/A/IOSurface

cp ${victim}_original $victim

impostorInstall=/System/Library/Extensions/$victim.bundle/Contents/MacOS/impostor.dylib

install_name_tool -change $reexported $impostorInstall $victim

clang -fmodules -dynamiclib interpose.m -Wno-unused-getter-return-value -Xlinker -no_warn_inits -I non-metal-common/Utils -I . -install_name $impostorInstall -Xlinker -reexport_library -Xlinker $reexported -o impostor.dylib
