set -e

patchedActualPath="$1"
impostorActualPath="$(dirname "$patchedActualPath")/impostor.dylib"

patchedInstallPath="$(otool -D "$patchedActualPath" | tail -n 1)"
impersonatedInstallPath=/System/Library/Frameworks/IOSurface.framework/Versions/A/IOSurface
impostorInstallPath="$(dirname "$patchedInstallPath")/impostor.dylib"

echo "\e[35mupdate \"$patchedActualPath\" (install path \"$patchedInstallPath\") to use \"$impostorActualPath\" (install path \"$impostorInstallPath\") impersonating \"$impersonatedInstallPath\"\e[0m"

install_name_tool -change "$impersonatedInstallPath" "$impostorInstallPath" "$patchedActualPath"

codePath="$(dirname "$0")"
clang -fmodules -dynamiclib "$codePath/interposer.m" -Wno-unused-getter-return-value -Xlinker -no_warn_inits -I "$codePath/../../moraea-common/Utils" -install_name "$impostorInstallPath" -Xlinker -reexport_library -Xlinker "$impersonatedInstallPath" -o "$impostorActualPath"

codesign -f -s - "$impostorActualPath"
codesign -f -s - "$patchedActualPath"
