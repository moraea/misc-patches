./Binpatcher AppleIntelBDWGraphicsFramebuffer.kext/Contents/MacOS/AppleIntelBDWGraphicsFramebuffer AppleIntelBDWGraphicsFramebuffer.kext/Contents/MacOS/AppleIntelBDWGraphicsFramebuffer '

# IOSurface::getPixelFormat

# AppleIntelFramebuffer::ValidateTransaction

set 0x1b52e
write 0x80
'
codesign -fs - AppleIntelBDWGraphicsFramebuffer.kext/Contents/MacOS/AppleIntelBDWGraphicsFramebuffer