./Binpatcher AppleIntelBDWGraphics.kext/Contents/MacOS/AppleIntelBDWGraphics AppleIntelBDWGraphics.kext/Contents/MacOS/AppleIntelBDWGraphics '

# IOSurface::getPlaneCount

# IGAccelResource::calculateIOSurfaceDeviceCacheVRAMBytes

set 0x5a251
write 0xb8

# IOSurface::getPixelFormat

# IGAccelDisplayPipe::performTransaction

set 0x6664c
write 0xac
'
codesign -fs - AppleIntelBDWGraphics.kext/Contents/MacOS/AppleIntelBDWGraphics