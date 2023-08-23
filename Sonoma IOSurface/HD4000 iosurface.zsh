./Binpatcher AppleIntelHD4000Graphics.kext/Contents/MacOS/AppleIntelHD4000Graphics AppleIntelHD4000Graphics.kext/Contents/MacOS/AppleIntelHD4000Graphics '

# IOSurface::getPlaneCount

# IGAccelResource::calculateIOSurfaceDeviceCacheVRAMBytes

set 0x3d50b
write 0xb8

# IOSurface::getPixelFormat

# IGAccelDisplayPipe::performTransaction

set 0x44fed
write 0xac
'
codesign -fs - AppleIntelHD4000Graphics.kext/Contents/MacOS/AppleIntelHD4000Graphics