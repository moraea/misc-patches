./Binpatcher AppleIntelFramebufferAzul.kext/Contents/MacOS/AppleIntelFramebufferAzul AppleIntelFramebufferAzul.kext/Contents/MacOS/AppleIntelFramebufferAzul '

# IOSurface::getPixelFormat

# AppleIntelFramebuffer::ValidateTransaction

set 0x187b0
write 0x80
'
codesign -fs - AppleIntelFramebufferAzul.kext/Contents/MacOS/AppleIntelFramebufferAzul