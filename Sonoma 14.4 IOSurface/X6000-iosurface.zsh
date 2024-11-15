#
# this is based on EDUs Vega X5000 patch script
# used Hopper to indetify functions and locations
# you will find the old Vega references and address calculations in comments
# checked every address and command in code manually
#
# tested on Sonoma 14.6.1 with iMac12,2 RX5500XT successfully
#
./Binpatcher AMDRadeonX6000.kext/Contents/MacOS/AMDRadeonX6000 AMDRadeonX6000.kext/Contents/MacOS/AMDRadeonX6000 '

# IOSurface::getPlaneCount

# AMDRadeonX6000_AMDAccelResource::zeroVidMemory

# set 0x14ca1 = 0x14c9f+2
# X6000: 0x14dcb + 2
set 0x14dcd  
write 0x98

# AMDRadeonX6000_AMDAccelResource::getIOSurfacePlaneInfo

# set 0x172c2 = 0x172c0 +2
# X6000: 17410 + 2
set 0x17412
write 0x98

# set 0x17313 = 0x17310 +3
# X6000: 0x17460 + 3 
set 0x17463
write 0x98

# AMDRadeonX6000_AMDAccelResource::fillUBMSurfaceInfoBacking

# set 0x17ad2 = 0x17ace + 4
# X6000: 0x17c84 + 4
set 0x17c88 
write 0x98

# AMDRadeonX6000_AMDAccelResource::initIOSurface

# set 0x16ac8 = 0x16ac5 + 3
# X6000: 0x16c15 + 3
set 0x16c18
write 0x98

# AMDRadeonX6000_AMDGFX9Resource::initIOSurface

# set 0x3d112 = 0x3d10e + 4 
# X6000: 0x3d070 + 4
set 0x3d074
write 0x98

# IOSurface::getPixelFormat

# AMDRadeonX6000_AMDAccelResource::zeroVidMemory (again)

# set 0x14cae = 0x14cac + 2
# X6000:  0x14dd8 + 2 
set 0x14dda
write 0x80
'
codesign -fs - AMDRadeonX6000.kext/Contents/MacOS/AMDRadeonX6000

