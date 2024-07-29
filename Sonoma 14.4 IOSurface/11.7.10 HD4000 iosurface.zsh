./Binpatcher AppleIntelHD4000Graphics.kext/Contents/MacOS/AppleIntelHD4000Graphics AppleIntelHD4000Graphics.kext/Contents/MacOS/AppleIntelHD4000Graphics '

# IOSurface::getPlaneCount

# IGAccelResource::calculateIOSurfaceDeviceCacheVRAMBytes

set 0x3e4b7
write 0x98

# IOSurface::getPixelFormat

# IGAccelDisplayPipe::performTransaction

set 0x45fbd
write 0x80
'
codesign -fs - AppleIntelHD4000Graphics.kext/Contents/MacOS/AppleIntelHD4000Graphics