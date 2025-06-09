set -e

montereyPlaneCount=0xb0
sequoiaPlaneCount=0x98
patchPlaneCount="assert $montereyPlaneCount
write $sequoiaPlaneCount"

montereyPixelFormat=0xa4
sequoiaPixelFormat=0x80
patchPixelFormat="assert $montereyPixelFormat
write $sequoiaPixelFormat"

Binpatcher AMDRadeonX4000.kext/Contents/MacOS/AMDRadeonX4000 AMDRadeonX4000.kext/Contents/MacOS/AMDRadeonX4000 "

# IOSurface::getPlaneCount

# AMDRadeonX4000_AMDAccelResource::zeroVidMemory

set 0x1493d
$patchPlaneCount

# AMDRadeonX4000_AMDAccelResource::getIOSurfacePlaneInfo

set 0x170da
$patchPlaneCount

set 0x1712b
$patchPlaneCount

# AMDRadeonX4000_AMDAccelResource::fillUBMSurfaceInfoBacking

set 0x178ea
$patchPlaneCount

# AMDRadeonX4000_AMDAccelResource::initIOSurface

set 0x168e0
$patchPlaneCount

# AMDRadeonX4000_AMDVIResource::initIOSurface

set 0x5827c
$patchPlaneCount

# IOSurface::getPixelFormat

# AMDRadeonX4000_AMDAccelResource::zeroVidMemory (again)

set 0x1494a
$patchPixelFormat

"

codesign -fs - AMDRadeonX4000.kext/Contents/MacOS/AMDRadeonX4000
