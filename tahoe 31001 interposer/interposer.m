#import "Utils.h"
@import Darwin;
@import Metal;

#import "interposer utils.m"

@class MTLRenderPipelineColorAttachmentDescriptorArrayInternal;
@class MTLVertexDescriptorInternal;
@class MTLPipelineBufferDescriptorArrayInternal;
@class MTLProfileControl;
@class MTLRenderPipelineDescriptorInternal;
@class MTLComputePipelineDescriptorInternal;
@class MTLRenderPipelineColorAttachmentDescriptorInternal;
@class MTLRenderPassColorAttachmentDescriptorArrayInternal;
@class MTLRenderPassSampleBufferAttachmentDescriptorArrayInternal;
@class MTLRenderPassDescriptorInternal;
@class MTLTextureDescriptorInternal;
@protocol MTLPipelineLibrary;

#import "monterey/MTLRenderPipelineDescriptorPrivate.h"
#import "tahoe/MTLRenderPipelineDescriptorPrivate.h"

#import "monterey/MTLComputePipelineDescriptorPrivate.h"
#import "tahoe/MTLComputePipelineDescriptorPrivate.h"

#import "monterey/MTLRenderPipelineAttachmentDescriptorPrivate.h"
#import "tahoe/MTLRenderPipelineAttachmentDescriptorPrivate.h"

#import "monterey/MTLRenderPassDescriptorPrivate.h"
#import "tahoe/MTLRenderPassDescriptorPrivate.h"

#import "monterey/MTLTextureDescriptorPrivate.h"
#import "tahoe/MTLTextureDescriptorPrivate.h"

pthread_key_t threadKey_MTLRenderPipelineDescriptorPrivate;
dispatch_once_t threadOnce_MTLRenderPipelineDescriptorPrivate;

struct tahoe_MTLRenderPipelineDescriptorPrivate* (*real_MTLRenderPipelineDescriptorInternal__descriptorPrivate)(MTLRenderPipelineDescriptorInternal*,SEL);

void* fake_MTLRenderPipelineDescriptorInternal__descriptorPrivate(MTLRenderPipelineDescriptorInternal* self,SEL sel)
{
	// trace(@"MTLRenderPipelineDescriptorInternal _descriptorPrivate self %@ stack %@",self,NSThread.callStackSymbols);
	
	struct tahoe_MTLRenderPipelineDescriptorPrivate* tahoe=real_MTLRenderPipelineDescriptorInternal__descriptorPrivate(self,sel);
	
	if(calledFromMetal())
	{
		return tahoe;
	}
	
	struct monterey_MTLRenderPipelineDescriptorPrivate* monterey=getOrMakeThreadStorage(&threadOnce_MTLRenderPipelineDescriptorPrivate,&threadKey_MTLRenderPipelineDescriptorPrivate,sizeof(struct monterey_MTLRenderPipelineDescriptorPrivate));
	
	monterey->attachments=tahoe->attachments;
	memcpy(&monterey->rtBlendDescHash,&tahoe->rtBlendDescHash,sizeof(monterey->rtBlendDescHash));
	monterey->depthAttachmentPixelFormat=tahoe->depthAttachmentPixelFormat;
	monterey->stencilAttachmentPixelFormat=tahoe->stencilAttachmentPixelFormat;
	monterey->tessellationPartitionMode=tahoe->tessellationPartitionMode;
	monterey->maxTessellationFactor=tahoe->maxTessellationFactor;
	monterey->tessellationFactorScaleEnabled=tahoe->tessellationFactorScaleEnabled;
	monterey->tessellationFactorFormat=tahoe->tessellationFactorFormat;
	monterey->tessellationControlPointIndexType=tahoe->tessellationControlPointIndexType;
	monterey->tessellationFactorStepFunction=tahoe->tessellationFactorStepFunction;
	monterey->tessellationOutputWindingOrder=tahoe->tessellationOutputWindingOrder;
	monterey->postVertexDumpBufferIndex=tahoe->postVertexDumpBufferIndex;
	monterey->supportIndirectCommandBuffers=tahoe->supportIndirectCommandBuffers;
	
	// tahoe unused: shaderValidation
	// tahoe unused: shaderValidationState
	
	monterey->textureWriteRoundingMode=tahoe->textureWriteRoundingMode;
	memcpy(&monterey->x14,&tahoe->x16,sizeof(monterey->x14));
	monterey->sampleMask=tahoe->sampleMask;
	memcpy(&monterey->x16,&tahoe->x18,sizeof(monterey->x16));
	monterey->paddingToRemove=tahoe->paddingToRemove;
	monterey->colorSampleCount=tahoe->colorSampleCount;
	
	// union miscHash and settings, treating as the latter bc members changed
	// hopefully hashes will remain unique after reordering..?
	
	// these changed from 1 bit to 2? what
	
	monterey->x19.x1.alphaToCoverageEnabled=!!tahoe->x21.x1.alphaToCoverageEnabled;
	monterey->x19.x1.alphaToOneEnabled=!!tahoe->x21.x1.alphaToOneEnabled;
	
	monterey->x19.x1.rasterizationEnabled=tahoe->x21.x1.rasterizationEnabled;
	monterey->x19.x1.inputPrimitiveTopology=tahoe->x21.x1.inputPrimitiveTopology;
	
	// monterey unset: private0
	// tahoe unused: private1
	
	monterey->x19.x1.depthStencilWriteDisabled=tahoe->x21.x1.depthStencilWriteDisabled;
	monterey->x19.x1.openGLMode=tahoe->x21.x1.openGLMode;
	monterey->x19.x1.sampleCoverageInvert=tahoe->x21.x1.sampleCoverageInvert;
	
	// monterey unset: private4
	// tahoe unused: private5
	
	monterey->x19.x1.vertexAmplificationMode=tahoe->x21.x1.vertexAmplificationMode;
	monterey->x19.x1.twoSideEnabled=tahoe->x21.x1.twoSideEnabled;
	monterey->x19.x1.pointSizeOutputVS=tahoe->x21.x1.pointSizeOutputVS;
	monterey->x19.x1.pointCoordLowerLeft=tahoe->x21.x1.pointCoordLowerLeft;
	monterey->x19.x1.pointSmoothEnabled=tahoe->x21.x1.pointSmoothEnabled;
	monterey->x19.x1.clipDistanceEnableMask=tahoe->x21.x1.clipDistanceEnableMask;
	monterey->x19.x1.alphaTestFunc=tahoe->x21.x1.alphaTestFunc;
	monterey->x19.x1.alphaTestEnabled=tahoe->x21.x1.alphaTestEnabled;
	monterey->x19.x1.logicOp=tahoe->x21.x1.logicOp;
	monterey->x19.x1.logicOpEnabled=tahoe->x21.x1.logicOpEnabled;
	monterey->x19.x1.forceResourceIndex=tahoe->x21.x1.forceResourceIndex;
	monterey->x19.x1.forceSoftwareVertexFetch=tahoe->x21.x1.forceSoftwareVertexFetch;
	
	// monterey unset: private6
	// tahoe unused: objectThreadgroupSizeIsMultipleOfThreadExecutionWidth
	// tahoe unused: meshThreadgroupSizeIsMultipleOfThreadExecutionWidth
	// tahoe unused: internalPipeline
	// tahoe unused: private9
	// end of union
	
	monterey->vertexDepthCompareClampMask=tahoe->vertexDepthCompareClampMask;
	monterey->fragmentDepthCompareClampMask=tahoe->fragmentDepthCompareClampMask;
	monterey->resourceIndex=tahoe->resourceIndex;
	monterey->label=tahoe->label;
	monterey->vertexFunction=tahoe->vertexFunction;
	monterey->fragmentFunction=tahoe->fragmentFunction;
	monterey->vertexDescriptor=tahoe->vertexDescriptor;
	
	// tahoe unused: objectFunction
	// tahoe unused: meshFunction
	// tahoe unused: objectThreadsPerThreadgroup_DO_NOT_USE_WILL_BE_REMOVED
	// tahoe unused: meshThreadsPerThreadgroup_DO_NOT_USE_WILL_BE_REMOVED
	// tahoe unused: maxPipelineChildren
	// tahoe unused: pipelineMemoryLength
	// tahoe unused: objectBuffers
	// tahoe unused: meshBuffers
	// tahoe unused: maxTotalThreadsPerObjectThreadgroup
	// tahoe unused: maxTotalThreadsPerMeshThreadgroup
	
	monterey->vertexBuffers=tahoe->vertexBuffers;
	monterey->fragmentBuffers=tahoe->fragmentBuffers;
	monterey->driverCompilerOptions=tahoe->driverCompilerOptions;
	
	// tahoe unused: gpuCompilerSPIOptions
	
	monterey->pipelineLibrary=tahoe->pipelineLibrary;
	
	// not sure if these ever have real data but can't hurt lol
	
	monterey->pad0=tahoe->pad0;
	monterey->pad1=tahoe->pad1;
	
	monterey->pluginData=tahoe->pluginData;
	monterey->needsCustomBorderColorSamplers=tahoe->needsCustomBorderColorSamplers;
	monterey->maxVertexAmplificationCount=tahoe->maxVertexAmplificationCount;
	monterey->binaryArchives=tahoe->binaryArchives;
	monterey->compilerTimeoutInSeconds=tahoe->compilerTimeoutInSeconds;
	monterey->vertexLinkedFunctions=tahoe->vertexLinkedFunctions;
	monterey->fragmentLinkedFunctions=tahoe->fragmentLinkedFunctions;
	
	// tahoe unused: objectLinkedFunctions
	// tahoe unused: meshLinkedFunctions
	
	monterey->vertexPreloadedLibraries=tahoe->vertexPreloadedLibraries;
	monterey->fragmentPreloadedLibraries=tahoe->fragmentPreloadedLibraries;
	
	// tahoe unused: objectPreloadedLibraries
	// tahoe unused: meshPreloadedLibraries
	
	monterey->maxVertexStackCallDepth=tahoe->maxVertexStackCallDepth;
	monterey->maxFragmentStackCallDepth=tahoe->maxFragmentStackCallDepth;
	monterey->supportAddingVertexBinaryFunctions=tahoe->supportAddingVertexBinaryFunctions;
	monterey->supportAddingFragmentBinaryFunctions=tahoe->supportAddingFragmentBinaryFunctions;
	
	// end of monterey struct
	
	// tahoe unused: maxMeshStackCallDepth
	// tahoe unused: maxObjectStackCallDepth
	// tahoe unused: supportAddingMeshBinaryFunctions
	// tahoe unused: supportAddingObjectBinaryFunctions
	// tahoe unused: profileControl
	// tahoe unused: explicitVisibilityGroupID
	// tahoe unused: maxAccelerationStructureTraversalDepth
	// tahoe unused: requiredThreadsPerObjectThreadgroup
	// tahoe unused: requiredThreadsPerMeshThreadgroup
	// tahoe unused: name
	// tahoe unused: colorAttachmentMappingState
	
	return monterey;
}

pthread_key_t threadKey_MTLComputePipelineDescriptorPrivate;
dispatch_once_t threadOnce_MTLComputePipelineDescriptorPrivate;

struct tahoe_MTLComputePipelineDescriptorPrivate* (*real_MTLComputePipelineDescriptorInternal__descriptorPrivate)(MTLComputePipelineDescriptorInternal*,SEL);

void* fake_MTLComputePipelineDescriptorInternal__descriptorPrivate(MTLComputePipelineDescriptorInternal* self,SEL sel)
{
	// trace(@"MTLComputePipelineDescriptorInternal _descriptorPrivate self %@ stack %@",self,NSThread.callStackSymbols);
	
	struct tahoe_MTLComputePipelineDescriptorPrivate* tahoe=real_MTLComputePipelineDescriptorInternal__descriptorPrivate(self,sel);
	
	if(calledFromMetal())
	{
		return tahoe;
	}
	
	struct monterey_MTLComputePipelineDescriptorPrivate* monterey=getOrMakeThreadStorage(&threadOnce_MTLComputePipelineDescriptorPrivate,&threadKey_MTLComputePipelineDescriptorPrivate,sizeof(struct monterey_MTLComputePipelineDescriptorPrivate));
	
	monterey->label=tahoe->label;
	monterey->computeFunction=tahoe->computeFunction;
	monterey->threadGroupSizeIsMultipleOfThreadExecutionWidth=tahoe->threadGroupSizeIsMultipleOfThreadExecutionWidth;
	monterey->maxTotalThreadsPerThreadgroup=tahoe->maxTotalThreadsPerThreadgroup;
	monterey->stageInputDescriptor=tahoe->stageInputDescriptor;
	monterey->driverCompilerOptions=tahoe->driverCompilerOptions;
	
	// tahoe unused: gpuCompilerSPIOptions
	
	monterey->buffers=tahoe->buffers;
	monterey->binaryArchives=tahoe->binaryArchives;
	memcpy(&monterey->x8,&tahoe->x9,sizeof(monterey->x8));
	monterey->pipelineLibrary=tahoe->pipelineLibrary;
	monterey->supportIndirectCommandBuffers=tahoe->supportIndirectCommandBuffers;
	
	// tahoe unused: shaderValidation
	// tahoe unused: shaderValidationState
	
	monterey->textureWriteRoundingMode=tahoe->textureWriteRoundingMode;
	monterey->forceResourceIndex=tahoe->forceResourceIndex;
	monterey->resourceIndex=tahoe->resourceIndex;
	monterey->pluginData=tahoe->pluginData;
	monterey->needsCustomBorderColorSamplers=tahoe->needsCustomBorderColorSamplers;
	monterey->openGLMode=tahoe->openGLMode;
	monterey->openCLMode=tahoe->openCLMode;
	
	// monterey unset: reserved
	// tahoe unused: internalPipeline
	// tahoe unused: reserved
	
	monterey->functionPointers=tahoe->functionPointers;
	
	// monterey unset: functionPointerGroups
	// no equivalent for this?
	
	monterey->linkedFunctions=tahoe->linkedFunctions;
	monterey->maxStackCallDepth=tahoe->maxStackCallDepth;
	monterey->supportAddingBinaryFunctions=tahoe->supportAddingBinaryFunctions;
	monterey->compilerTimeoutInSeconds=tahoe->compilerTimeoutInSeconds;
	
	// end of monterey struct
	
	// tahoe unused: profileControl
	// tahoe unused: maxAccelerationStructureTraversalDepth
	// tahoe unused: requiredThreadsPerThreadgroup
	// tahoe unused: name
	
	return monterey;
}

pthread_key_t threadKey_MTLRenderPipelineAttachmentDescriptorPrivate;
dispatch_once_t threadOnce_MTLRenderPipelineAttachmentDescriptorPrivate;

struct tahoe_MTLRenderPipelineAttachmentDescriptorPrivate* (*real_MTLRenderPipelineColorAttachmentDescriptorInternal__descriptorPrivate)(MTLRenderPipelineColorAttachmentDescriptorInternal*,SEL);

void* fake_MTLRenderPipelineColorAttachmentDescriptorInternal__descriptorPrivate(MTLRenderPipelineColorAttachmentDescriptorInternal* self,SEL sel)
{
	// trace(@"MTLRenderPipelineColorAttachmentDescriptorInternal _descriptorPrivate stack %@",NSThread.callStackSymbols);
	
	struct tahoe_MTLRenderPipelineAttachmentDescriptorPrivate* tahoe=real_MTLRenderPipelineColorAttachmentDescriptorInternal__descriptorPrivate(self,sel);
	
	if(calledFromMetal())
	{
		return tahoe;
	}
	
	struct monterey_MTLRenderPipelineAttachmentDescriptorPrivate* monterey=getOrMakeThreadStorage(&threadOnce_MTLRenderPipelineAttachmentDescriptorPrivate,&threadKey_MTLRenderPipelineAttachmentDescriptorPrivate,sizeof(struct monterey_MTLRenderPipelineAttachmentDescriptorPrivate));
	
	// other union member just "bits", little choice but to copy the flags one
	// changed from 1 bit to 2 again?
	
	monterey->x0.x0.blendingEnabled=!!tahoe->x0.x0.blendingEnabled;
	
	monterey->x0.x0.rgbBlendOperation=tahoe->x0.x0.rgbBlendOperation;
	monterey->x0.x0.alphaBlendOperation=tahoe->x0.x0.alphaBlendOperation;
	monterey->x0.x0.sourceRGBBlendFactor=tahoe->x0.x0.sourceRGBBlendFactor;
	monterey->x0.x0.sourceAlphaBlendFactor=tahoe->x0.x0.sourceAlphaBlendFactor;
	monterey->x0.x0.destinationRGBBlendFactor=tahoe->x0.x0.destinationRGBBlendFactor;
	monterey->x0.x0.destinationAlphaBlendFactor=tahoe->x0.x0.destinationAlphaBlendFactor;
	
	// changed from 4 to 5 bits? uh oh
	
	monterey->x0.x0.writeMask=tahoe->x0.x0.writeMask;
	
	monterey->x0.x0.logicOpEnabled=tahoe->x0.x0.logicOpEnabled;
	monterey->x0.x0.logicOp=tahoe->x0.x0.logicOp;
	
	// changed from 28 to 22 bits
	
	monterey->x0.x0.pixelFormat=tahoe->x0.x0.pixelFormat;
	
	// end of both structs, no entirely new members
	
	return monterey;
}

pthread_key_t threadKey_MTLRenderPassDescriptorPrivate;
dispatch_once_t threadOnce_MTLRenderPassDescriptorPrivate;

struct tahoe_MTLRenderPassDescriptorPrivate* (*real_MTLRenderPassDescriptorInternal__descriptorPrivate)(MTLRenderPassDescriptorInternal*,SEL);

void* fake_MTLRenderPassDescriptorInternal__descriptorPrivate(MTLRenderPassDescriptorInternal* self,SEL sel)
{
	// trace(@"MTLRenderPassDescriptorInternal _descriptorPrivate stack %@",NSThread.callStackSymbols);
	
	struct tahoe_MTLRenderPassDescriptorPrivate* tahoe=real_MTLRenderPassDescriptorInternal__descriptorPrivate(self,sel);
	
	if(calledFromMetal())
	{
		return tahoe;
	}
	
	struct monterey_MTLRenderPassDescriptorPrivate* monterey=getOrMakeThreadStorage(&threadOnce_MTLRenderPassDescriptorPrivate,&threadKey_MTLRenderPassDescriptorPrivate,sizeof(struct monterey_MTLRenderPassDescriptorPrivate));
	
	monterey->attachments=tahoe->attachments;
	monterey->visibilityResultBuffer=tahoe->visibilityResultBuffer;
	monterey->renderTargetWidth=tahoe->renderTargetWidth;
	monterey->renderTargetHeight=tahoe->renderTargetHeight;
	monterey->defaultColorSampleCount=tahoe->defaultColorSampleCount;
	monterey->fineGrainedBackgroundVisibilityEnabled=tahoe->fineGrainedBackgroundVisibilityEnabled;
	
	// tahoe unused: skipEmptyTilesOnClearEnabled
	
	monterey->ditherEnabled=tahoe->ditherEnabled;
	monterey->openGLModeEnabled=tahoe->openGLModeEnabled;
	monterey->renderTargetArrayLength=tahoe->renderTargetArrayLength;
	monterey->tileWidth=tahoe->tileWidth;
	monterey->tileHeight=tahoe->tileHeight;
	memcpy(&monterey->x11,&tahoe->x12,sizeof(monterey->x11));
	monterey->imageBlockSampleLength=tahoe->imageBlockSampleLength;
	monterey->threadgroupMemoryLength=tahoe->threadgroupMemoryLength;
	memcpy(&monterey->x,&tahoe->x,sizeof(monterey->x));
	monterey->numCustomSamplePositions=tahoe->numCustomSamplePositions;
	monterey->rasterizationRateMap=tahoe->rasterizationRateMap;
	monterey->sampleBufferAttachments=tahoe->sampleBufferAttachments;
	monterey->pointCoordYFlipEnabled=tahoe->pointCoordYFlipEnabled;
	
	// end of monterey struct
	// tahoe unused: visibilityResultType
	// tahoe unused: supportColorAttachmentMapping
	
	return monterey;
}

pthread_key_t threadKey_MTLTextureDescriptorPrivate;
dispatch_once_t threadOnce_MTLTextureDescriptorPrivate;

struct tahoe_MTLTextureDescriptorPrivate* (*real_MTLTextureDescriptorInternal_descriptorPrivate)(MTLTextureDescriptorInternal*,SEL);

void* fake_MTLTextureDescriptorInternal_descriptorPrivate(MTLTextureDescriptorInternal* self,SEL sel)
{
	struct tahoe_MTLTextureDescriptorPrivate* tahoe=real_MTLTextureDescriptorInternal_descriptorPrivate(self,sel);
	
	if(calledFromMetal())
	{
		return tahoe;
	}
	
	struct monterey_MTLTextureDescriptorPrivate* monterey=getOrMakeThreadStorage(&threadOnce_MTLTextureDescriptorPrivate,&threadKey_MTLTextureDescriptorPrivate,sizeof(struct monterey_MTLTextureDescriptorPrivate));
	
	monterey->textureType=tahoe->textureType;
	monterey->pixelFormat=tahoe->pixelFormat;
	monterey->width=tahoe->width;
	monterey->height=tahoe->height;
	monterey->depth=tahoe->depth;
	monterey->mipmapLevelCount=tahoe->mipmapLevelCount;
	monterey->sampleCount=tahoe->sampleCount;
	monterey->arrayLength=tahoe->arrayLength;
	monterey->zeroFill=tahoe->zeroFill;
	monterey->rotation=tahoe->rotation;
	monterey->framebufferOnly=tahoe->framebufferOnly;
	monterey->isDrawable=tahoe->isDrawable;
	monterey->swizzle=tahoe->swizzle;
	monterey->writeSwizzleEnabled=tahoe->writeSwizzleEnabled;
	monterey->compressionMode=tahoe->compressionMode;
	memcpy(&monterey->x15,&tahoe->x15,sizeof(monterey->x15));
	monterey->resourceOptions=tahoe->resourceOptions;
	monterey->sparseSurfaceDefaultValue=tahoe->sparseSurfaceDefaultValue;
	monterey->allowGPUOptimizedContents=tahoe->allowGPUOptimizedContents;
	monterey->forceResourceIndex=tahoe->forceResourceIndex;
	monterey->resourceIndex=tahoe->resourceIndex;
	monterey->protectionOptions=tahoe->protectionOptions;
	monterey->compressionFootprint=tahoe->compressionFootprint;
	monterey->compressionType=tahoe->compressionType;
	
	// tahoe unused: colorSpaceConversionMatrix
	// tahoe unused: placementSparsePageSize
	
	monterey->resolvedUsage=tahoe->resolvedUsage;
	monterey->cpuCacheMode=tahoe->cpuCacheMode;
	monterey->storageMode=tahoe->storageMode;
	
	// end of both structs
	
	return monterey;
}

id returnNil()
{
	return nil;
}

#if defined NoMetalIntel
#define NoMetalProcesses @[@"/System/Library/CoreServices/NotificationCenter.app/Contents/MacOS/NotificationCenter",@"/System/Applications/Font Book.app/Contents/MacOS/Font Book",@"/System/Library/ExtensionKit/Extensions/UsersGroups.appex/Contents/MacOS/UsersGroups"]
#elif defined NoMetalGCN
#define NoMetalProcesses @[@"/System/Library/ExtensionKit/Extensions/UsersGroups.appex/Contents/MacOS/UsersGroups"]
#endif

__attribute__((constructor)) void load()
{
	@autoreleasepool
	{
		traceLog=true;
		tracePrint=false;
		swizzleLog=false;
		
		// fix crashes
		
		swizzleSafer(@"MTLRenderPipelineDescriptorInternal",@"_descriptorPrivate",true,(IMP)fake_MTLRenderPipelineDescriptorInternal__descriptorPrivate,(IMP*)&real_MTLRenderPipelineDescriptorInternal__descriptorPrivate);
		swizzleSafer(@"MTLComputePipelineDescriptorInternal",@"_descriptorPrivate",true,(IMP)fake_MTLComputePipelineDescriptorInternal__descriptorPrivate,(IMP*)&real_MTLComputePipelineDescriptorInternal__descriptorPrivate);
		
		// fix solid yellow screen
		
		swizzleSafer(@"MTLRenderPipelineColorAttachmentDescriptorInternal",@"_descriptorPrivate",true,(IMP)fake_MTLRenderPipelineColorAttachmentDescriptorInternal__descriptorPrivate,(IMP*)&real_MTLRenderPipelineColorAttachmentDescriptorInternal__descriptorPrivate);
		
		// TODO: called, but unsure if it fixes anything
		
		swizzleSafer(@"MTLRenderPassDescriptorInternal",@"_descriptorPrivate",true,(IMP)fake_MTLRenderPassDescriptorInternal__descriptorPrivate,(IMP*)&real_MTLRenderPassDescriptorInternal__descriptorPrivate);
		swizzleSafer(@"MTLTextureDescriptorInternal",@"descriptorPrivate",true,(IMP)fake_MTLTextureDescriptorInternal_descriptorPrivate,(IMP*)&real_MTLTextureDescriptorInternal_descriptorPrivate);
		
#ifdef NoMetalProcesses
		if([NoMetalProcesses containsObject:NSProcessInfo.processInfo.arguments[0]])
		{
			swizzleImp(@"MTLIOAccelDevice",@"initWithAcceleratorPort:",true,(IMP)returnNil,NULL);
		}
#endif
	}
}
