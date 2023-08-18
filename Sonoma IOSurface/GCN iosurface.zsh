# unstable, safer to just downgrade IOSurface.kext at this time!
# credit EduCovas for downgrade, MykolaG for pointing out IOSurface::get* changes

set -e
cd ~/Desktop
PATH+=:/Volumes/Files/sonoma/tmp/spaghetti

root12='/Volumes/Temporary 39/Unfiled/versions.noindex/12.6.7 (21G708)/root'
rm -rf AMDRadeonX4000.kext
cp -RX "$root12/System/Library/Extensions/AMDRadeonX4000.kext" .

Binpatcher AMDRadeonX4000.kext/Contents/MacOS/AMDRadeonX4000 AMDRadeonX4000.kext/Contents/MacOS/AMDRadeonX4000 '

# IOSurface::getPlaneCount

# AMDRadeonX4000_AMDAccelResource::zeroVidMemory

set 0x1493d
assert 0xb0
write 0xb8

# AMDRadeonX4000_AMDAccelResource::getIOSurfacePlaneInfo

set 0x170da
assert 0xb0
write 0xb8

set 0x1712b
assert 0xb0
write 0xb8

# AMDRadeonX4000_AMDAccelResource::fillUBMSurfaceInfoBacking

set 0x178ea
assert 0xb0
write 0xb8

# AMDRadeonX4000_AMDAccelResource::initIOSurface

set 0x168e0
assert 0xb0
write 0xb8

# IOSurface::getPixelFormat

# AMDRadeonX4000_AMDAccelResource::zeroVidMemory (again)

set 0x1494a
assert 0xa4
write 0xac

# TODO: there are almost certainly more problems like this
# and one of them seems to have turned my entire screen red for like 30 seconds... 👁️👄👁️

'

codesign -fs - AMDRadeonX4000.kext

scp -r AMDRadeonX4000.kext amy@cass.local:/tmp/