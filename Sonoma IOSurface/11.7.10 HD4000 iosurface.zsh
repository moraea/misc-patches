./Binpatcher AppleIntelHD4000Graphics.kext/Contents/MacOS/AppleIntelHD4000Graphics AppleIntelHD4000Graphics.kext/Contents/MacOS/AppleIntelHD4000Graphics '

# IOSurface::getPlaneCount

# IGAccelResource::calculateIOSurfaceDeviceCacheVRAMBytes

set 0x3e4b7
write 0xb8

# IOSurface::getPixelFormat

# IGAccelDisplayPipe::performTransaction

set 0x45fbd
write 0xac
'
codesign -fs - AppleIntelHD4000Graphics.kext/Contents/MacOS/AppleIntelHD4000Graphics