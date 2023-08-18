set -e

cd "$(dirname "$0")"

./X 125/dyld_shared_cache_x86_64 /System/Library/Extensions/AMDMTLBronzeDriver.bundle /System/Library/Extensions/AMDShared.bundle
cp -R 125/AMDShared.bundle 125/AMDMTLBronzeDriver.bundle .
cp -R Out/System/Library/Extensions/AMDShared.bundle .
cp -R Out/System/Library/Extensions/AMDMTLBronzeDriver.bundle .

./Binpatcher AMDMTLBronzeDriver.bundle/Contents/MacOS/AMDMTLBronzeDriver AMDMTLBronzeDriver.bundle/Contents/MacOS/AMDMTLBronzeDriver '

# BronzeMtlDevice computeFunctionKeyWithComputePipelineDescriptor:options:keySize:

# MTLComputePipelineDescriptorPrivate.supportAddingBinaryFunctions
set 0x121873
assert 0x98
write 0x90

# MTLComputePipelineDescriptorPrivate.linkedFunctions
# credit: EduCovas (nop workaround)
set 0x12187d
assert 0x88
write 0x80

# BronzeMtlRenderPipelineState initWithDevice:pipelineStateDescriptor:vertexVariant:fragmentVariant:

# MTLRenderPipelineDescriptorPrivate.maxVertexAmplificationCount
set 0x57041
assert 0x4401
write 0xc401

# amdMtlBronzeDeviceHsMode - rsi is MTLComputePipelineDescriptorPrivate

# BronzeMtlRenderCmdEncoder initWithCommandBuffer:descriptor:
# likely MTLRenderPassDescriptorInternal as it calls validate:width:height:

# amdMtlBronzeHandleLoadActions - r8 is MTLRenderPassDescriptor

# Experiment_VisibilityResultBuffer - rdi is MTLRenderPassDescriptor

# BronzeMtlDevice fragmentFunctionKeyWithRenderPipelineDescriptor:options:previousStateVariant:fragmentKeySize:

# MTLRenderPipelineDescriptorPrivate.maxVertexAmplificationCount
set 0x121bcc
assert 0x4401
write 0xc401

# MTLRenderPipelineDescriptorPrivate.driverCompilerOptions
set 0x121be2
assert 0x1801
write 0x9801

# BronzeMtlDevice vertexFunctionKeyWithRenderPipelineDescriptor:options:nextStageVariant:vertexKeySize:

# MTLRenderPipelineDescriptorPrivate.maxVertexAmplificationCount
set 0x122151
assert 0x4401
write 0xc401

# MTLRenderPipelineDescriptorPrivate.driverCompilerOptions
set 0x122161
assert 0x1801
write 0x9801

'

codesign -fs - --deep AMDShared.bundle
codesign -fs - --deep AMDMTLBronzeDriver.bundle

scp -r AMDShared.bundle AMDMTLBronzeDriver.bundle Amy@Cass.local:/tmp/

# mount -uw / && rm -rf /System/Library/Extensions/AMDShared.bundle /System/Library/Extensions/AMDMTLBronzeDriver.bundle && cp -R /tmp/AMDShared.bundle /tmp/AMDMTLBronzeDriver.bundle /System/Library/Extensions && codesign -fs - /System/Library/Extensions/AMDShared.bundle && codesign -fs - /System/Library/Extensions/AMDMTLBronzeDriver.bundle && killall -9 WindowServer

# TODO: IT IS VERY ALARMING THAT THIS "FIXES" THE UI GLITCHES
# cd /var/folders/*/*/*/WindowServer/com.apple.WindowServer && rm -rf com.apple.metal && touch com.apple.metal && killall -9 WindowServer