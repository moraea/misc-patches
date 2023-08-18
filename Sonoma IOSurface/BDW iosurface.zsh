./Binpatcher AppleIntelBDWGraphics.kext/Contents/MacOS/AppleIntelBDWGraphics AppleIntelBDWGraphics.kext/Contents/MacOS/AppleIntelBDWGraphics '

# IOSurface::getPlaneCount

# IGAccelResource::calculateIOSurfaceDeviceCacheVRAMBytes

set 0x5a251
write 0xb8
'
codesign -fs - AppleIntelBDWGraphics.kext/Contents/MacOS/AppleIntelBDWGraphics