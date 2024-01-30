./Binpatcher AppleIntelSKLGraphicsFramebuffer.kext/Contents/MacOS/AppleIntelSKLGraphicsFramebuffer AppleIntelSKLGraphicsFramebuffer.kext/Contents/MacOS/AppleIntelSKLGraphicsFramebuffer '

# IOSurface::getPixelFormat

# AppleIntelFramebuffer::ValidateTransaction

set 0x27530
write 0x80
'
codesign -fs - AppleIntelSKLGraphicsFramebuffer.kext/Contents/MacOS/AppleIntelSKLGraphicsFramebuffer