#!/bin/zsh

set -e
cd "$(dirname "$0")"

PATH+=:/Users/amy/Desktop/Build/non-metal-common/Build

cp '/Users/amy/Desktop/PatcherSupportPkg-1.3.1/Universal-Binaries/11.0 Beta 6/System/Library/Extensions/AppleIntelHD4000GraphicsMTLDriver.bundle/Contents/MacOS/AppleIntelHD4000GraphicsMTLDriver' AppleIntelHD4000GraphicsMTLDriver_real

install_name_tool -id /System/Library/Extensions/AppleIntelHD4000GraphicsMTLDriver.bundle/Contents/MacOS/AppleIntelHD4000GraphicsMTLDriver_real AppleIntelHD4000GraphicsMTLDriver_real

clang -dynamiclib -fmodules -I /Users/amy/Desktop/Build/non-metal-common/Utils -mmacosx-version-min=12 -install_name /System/Library/Extensions/AppleIntelHD4000GraphicsMTLDriver.bundle/Contents/MacOS/AppleIntelHD4000GraphicsMTLDriver -Xlinker -reexport_library -Xlinker AppleIntelHD4000GraphicsMTLDriver_real wrap.m -o AppleIntelHD4000GraphicsMTLDriver

codesign -fs - AppleIntelHD4000GraphicsMTLDriver_real
codesign -fs - AppleIntelHD4000GraphicsMTLDriver

scp AppleIntelHD4000GraphicsMTLDriver_real AppleIntelHD4000GraphicsMTLDriver amy@nora.local:/tmp/

# mount -uw / && cp /tmp/AppleIntelHD4000GraphicsMTLDriver* /System/Library/Extensions/AppleIntelHD4000GraphicsMTLDriver.bundle/Contents/MacOS && codesign -fs - /System/Library/Extensions/AppleIntelHD4000GraphicsMTLDriver.bundle/Contents/MacOS/AppleIntelHD4000GraphicsMTLDriver* && find /var/folders -name com.apple.metal -exec rm -rf {} \; ; killall -9 Weather NotificationCenter MTLCompilerService 'Font Book'; log stream -predicate 'message contains "Amy"'