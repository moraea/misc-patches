set -e

cd "$(dirname "$0")"

# ./X 12b6/dyld_shared_cache_x86_64 /System/Library/Extensions/GeForceMTLDriver.bundle
# cp -R 12b6/GeForceMTLDriver.bundle .
# cp Out/System/Library/Extensions/GeForceMTLDriver.bundle/Contents/MacOS/GeForceMTLDriver GeForceMTLDriver.bundle/Contents/MacOS/GeForceMTLDriver

# https://github.com/dortania/PatcherSupportPkg/blob/master/Universal-Binaries/11.0%20Beta%203/System/Library/Extensions/GeForceMTLDriver.bundle
cp -R dortania/GeForceMTLDriver.bundle .

./Binpatcher GeForceMTLDriver.bundle/Contents/MacOS/GeForceMTLDriver GeForceMTLDriver.bundle/Contents/MacOS/GeForceMTLDriver '

# NVMTLHeap newTextureWithDescriptor:

# MTLTextureDescriptorPrivate.cpuCacheMode
# set 0x10cddb
set 0x10b234
assert 0xa0
write 0xb0

# MTLTextureDescriptorPrivate.storageMode
# set 0x10cde2
set 0x10b23b
assert 0xa8
write 0xb8

# NVMTLTexture initWithDevice:descriptor:sysMemSize:sysMemRowBytes:vidMemSize:vidMemRowBytes:args:argsSize:

# MTLTextureDescriptorPrivate.storageMode
# set 0x15894b
set 0x1583be
assert 0xa8
write 0xb8

# MTLTextureDescriptorPrivate.cpuCacheMode
# set 0x158956
set 0x1583c9
assert 0xa0
write 0xb0

# MTLTextureDescriptorPrivate.resolvedUsage
# set 0x158a33
set 0x1584a6
assert 0x98
write 0xa8

# unnamed

# MTLTextureDescriptorPrivate.resolvedUsage
# set 0x1727ee
# assert 0x98
# write 0xa8

# unnamed

# MTLTextureDescriptorPrivate.resolvedUsage
# set 0x172eef
# assert 0x98
# write 0xa8'

clang -fmodules -dynamiclib -Xlinker -reexport_library -Xlinker /System/Library/Frameworks/Foundation.framework/Versions/C/Foundation -install_name /System/Library/Extensions/GeForceMTLDriver.bundle/Contents/MacOS/Shim.dylib Shim.m -o GeForceMTLDriver.bundle/Contents/MacOS/Shim.dylib

install_name_tool -change /System/Library/Frameworks/Foundation.framework/Versions/C/Foundation /System/Library/Extensions/GeForceMTLDriver.bundle/Contents/MacOS/Shim.dylib GeForceMTLDriver.bundle/Contents/MacOS/GeForceMTLDriver

codesign -fs - --deep GeForceMTLDriver.bundle

# scp -r GeForceMTLDriver.bundle Amy@Cass.local:/tmp/

# mount -uw / && rm -rf /System/Library/Extensions/GeForceMTLDriver.bundle && cp -R /tmp/GeForceMTLDriver.bundle /System/Library/Extensions && codesign -fs - /System/Library/Extensions/GeForceMTLDriver.bundle && killall -9 WindowServer