./Binpatcher AMDRadeonX4000.kext/Contents/MacOS/AMDRadeonX4000 AMDRadeonX4000.kext/Contents/MacOS/AMDRadeonX4000 '

# IOSurface::getPlaneCount

# AMDRadeonX4000_AMDAccelResource::zeroVidMemory

set 0x1493d
write 0x98

# AMDRadeonX4000_AMDAccelResource::getIOSurfacePlaneInfo

set 0x170da
write 0x98

set 0x1712b
write 0x98

# AMDRadeonX4000_AMDAccelResource::fillUBMSurfaceInfoBacking

set 0x178ea
write 0x98

# AMDRadeonX4000_AMDAccelResource::initIOSurface

set 0x168e0
write 0x98

# AMDRadeonX4000_AMDVIResource::initIOSurface

set 0x5827c
write 0x98

# IOSurface::getPixelFormat

# AMDRadeonX4000_AMDAccelResource::zeroVidMemory (again)

set 0x1494a
write 0x80

'

codesign -fs - AMDRadeonX4000.kext/Contents/MacOS/AMDRadeonX4000