set -e

victim="$1"
cp "${victim}_original" "$victim"

codeName=interposer.m
impersonated=/System/Library/Frameworks/IOSurface.framework/Versions/A/IOSurface
impostorName=impostor.dylib

impostorPath="/System/Library/Extensions/$victim.bundle/Contents/MacOS/$impostorName"
install_name_tool -change "$impersonated" "$impostorPath" "$victim"
clang -fmodules -dynamiclib "$codeName" -Wno-unused-getter-return-value -Xlinker -no_warn_inits -I non-metal-common/Utils -I . -install_name "$impostorPath" -Xlinker -reexport_library -Xlinker "$impersonated" -o "$impostorName"
