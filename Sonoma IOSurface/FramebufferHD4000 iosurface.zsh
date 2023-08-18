./Binpatcher AppleIntelFramebufferCapri.kext/Contents/MacOS/AppleIntelFramebufferCapri AppleIntelFramebufferCapri.kext/Contents/MacOS/AppleIntelFramebufferCapri '

# IOSurface::getPixelFormat

# AppleIntelFramebuffer::ValidateTransaction

set 0x1289f
write 0xac
'
codesign -fs - AppleIntelFramebufferCapri.kext/Contents/MacOS/AppleIntelFramebufferCapri