./Binpatcher AMDRadeonX5000.kext/Contents/MacOS/AMDRadeonX5000 AMDRadeonX5000.kext/Contents/MacOS/AMDRadeonX5000 '

# IOSurface::getPlaneCount

# AMDRadeonX5000_AMDAccelResource::zeroVidMemory

set 0x14ca1
write 0xb8

# AMDRadeonX5000_AMDAccelResource::getIOSurfacePlaneInfo

set 0x172c2
write 0xb8

set 0x17313
write 0xb8

# AMDRadeonX5000_AMDAccelResource::fillUBMSurfaceInfoBacking

set 0x17ad2
write 0xb8

# AMDRadeonX5000_AMDAccelResource::initIOSurface

set 0x16ac8
write 0xb8

# IOSurface::getPixelFormat

# AMDRadeonX5000_AMDAccelResource::zeroVidMemory (again)

set 0x14cae
write 0xac
'
codesign -fs - AMDRadeonX5000.kext/Contents/MacOS/AMDRadeonX5000