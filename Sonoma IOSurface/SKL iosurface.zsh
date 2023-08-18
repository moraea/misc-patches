./Binpatcher AppleIntelSKLGraphics.kext/Contents/MacOS/AppleIntelSKLGraphics AppleIntelSKLGraphics.kext/Contents/MacOS/AppleIntelSKLGraphics '

# IOSurface::getPlaneCount

# IGAccelResource::calculateIOSurfaceDeviceCacheVRAMBytes

set 0x5da6c
write 0xb8

# IOSurface::getPixelFormat

# IGAccelDisplayPipe::performTransaction

set 0x6ca19
write 0xac
'
codesign -fs - AppleIntelSKLGraphics.kext/Contents/MacOS/AppleIntelSKLGraphics