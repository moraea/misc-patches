./Binpatcher GeForce.kext/Contents/MacOS/GeForce GeForce.kext/Contents/MacOS/GeForce '

# IOSurface::getPlaneCount

# nvTextureBuffer::SetupOOLForIOSurface

set 0x5de50
write 0xb8

# nvTextureBuffer::CaclulateIOSurfacePagingData (Caclulate???)

set 0x5e6d6
write 0xb8

set 0x5e73d
write 0xb8
'
codesign -fs - GeForce.kext/Contents/MacOS/GeForce