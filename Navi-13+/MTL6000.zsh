#
# this is based on EDUs Vega MTL patch script
# used Hopper to indetify functions and locations
# you will find the old Vega references in comments
#
# the first two patches are necessary to run on iMac12,2 RX5500XT with Ventura
# the patching of GFX10_MtlComputePipeLineState has subtle consequences, first
# the GPU is no longer shown in "About This Mac" since all displays are clamped
# down and the performace on simple MetalBench get 15% up to Monterey level
#
# extraction with DCSE binary her called Extract
#
# ./Extract /System/Library/dyld/dyld_shared_cache_x86_64 /System/Library/Extensions/AMDRadeonX6000MTLDriver.bundle/Contents/MacOS
#
#
./Binpatcher navi_dsce navi_reconstructed '
# GFX10_MtlDevice computeFunctionKeyWithComputePipeLineDescriptor

# set 0x132ad
set 0x1060d2
# assert 0x88
write 0x80

# set 0x13508
set 0x10632d
# assert 0x88
write 0x80

# GFX10_MtlComputePipeLineState initWithDevice

# set 0x8e9ec
set 0xb9b83
assert 0x88
write 0x80

# set 0x8ea31
set 0xb9bc8
assert 0x88
write 0x80

# set 0x8ea59
set 0xb9bf5
assert 0x88
write 0x80

# set 0x8ea87
set 0xb9c2b
assert 0x88
write 0x80

# set 0x8eae2
set 0xb9c88
assert 0x88
write 0x80

# set 0x8eb19
set 0xb9ce1
assert 0x88
write 0x80

# set 0x8eb52
set 0xb9d12
assert 0x88
write 0x80

# set 0x8eb7b
set 0xb9d3a
assert 0x88
write 0x80

# set 0x8eba7
set 0xb9d66
assert 0x88
write 0x80

# set 0x8ec06
set 0xb9dc3
assert 0x88
write 0x80

# set 0x8ec06
set 0xb9e39
assert 0x88
write 0x80

# set 0x8ecb7
set 0xb9e70
assert 0x88
write 0x80

# set 0x8ee14
set 0xb9fbf
assert 0x88
write 0x80
'
# codesign -fs - AMDRadeonX6000MTLDriver.bundle/Contents/MacOS/AMDRadeonX6000MTLDriver

