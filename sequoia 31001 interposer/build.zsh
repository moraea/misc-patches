set -e

driverName="$1"
codeName=interposer.m
impostorName=impostor.dylib
impersonatedPath=/System/Library/Frameworks/IOSurface.framework/Versions/A/IOSurface

cp "${driverName}_original" "$driverName"
impostorPath="/System/Library/Extensions/$driverName.bundle/Contents/MacOS/$impostorName"
install_name_tool -change "$impersonatedPath" "$impostorPath" "$driverName"
clang -fmodules -dynamiclib "$codeName" -Wno-unused-getter-return-value -Xlinker -no_warn_inits -I non-metal-common/Utils -I . -install_name "$impostorPath" -Xlinker -reexport_library -Xlinker "$impersonatedPath" -o "$impostorName"
