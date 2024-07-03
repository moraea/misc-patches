#import "Utils.h"
@import Darwin;
@import Metal;

#import "MontereyRender.h"
#import "SequoiaRender.h"
#import "MontereyCompute.h"
#import "SequoiaCompute.h"
#define MontereyRender struct montereyRender_MTLRenderPipelineDescriptorPrivate
#define SequoiaRender struct sequoiaRender_MTLRenderPipelineDescriptorPrivate
#define MontereyCompute struct montereyCompute_MTLComputePipelineDescriptorPrivate
#define SequoiaCompute struct sequoiaCompute_MTLComputePipelineDescriptorPrivate

pthread_key_t threadMontereyRenderKey;
pthread_key_t threadMontereyComputeKey;
dispatch_once_t threadOnce;

void ensureThreadStorageMade()
{
	dispatch_once(&threadOnce,^()
	{
		assert(!pthread_key_create(&threadMontereyRenderKey,free));
		assert(!pthread_key_create(&threadMontereyComputeKey,free));
	});
}

__attribute__((always_inline)) BOOL calledFromMetal()
{
	// hack: we know dsc addresses are like that
	
	char* caller=__builtin_extract_return_addr(__builtin_return_address(0));
	return caller>(char*)0x700000000000;
}

SequoiaRender* (*real_render)(id,SEL);
void* fake_render(id self,SEL sel)
{
	SequoiaRender* sequoia=real_render(self,sel);
	if(calledFromMetal())
	{
		return sequoia;
	}
	
	ensureThreadStorageMade();
	MontereyRender* monterey=pthread_getspecific(threadMontereyRenderKey);
	if(!monterey)
	{
		monterey=malloc(sizeof(MontereyRender));
		pthread_setspecific(threadMontereyRenderKey,monterey);
	}
	monterey->attachments=sequoia->attachments;
	memcpy(monterey->rtBlendDescHash,sequoia->rtBlendDescHash,sizeof(monterey->rtBlendDescHash));
	monterey->depthAttachmentPixelFormat=sequoia->depthAttachmentPixelFormat;
	monterey->stencilAttachmentPixelFormat=sequoia->stencilAttachmentPixelFormat;
	monterey->tessellationPartitionMode=sequoia->tessellationPartitionMode;
	monterey->maxTessellationFactor=sequoia->maxTessellationFactor;
	monterey->tessellationFactorScaleEnabled=sequoia->tessellationFactorScaleEnabled;
	monterey->tessellationFactorFormat=sequoia->tessellationFactorFormat;
	monterey->tessellationControlPointIndexType=sequoia->tessellationControlPointIndexType;
	monterey->tessellationFactorStepFunction=sequoia->tessellationFactorStepFunction;
	monterey->tessellationOutputWindingOrder=sequoia->tessellationOutputWindingOrder;
	monterey->postVertexDumpBufferIndex=sequoia->postVertexDumpBufferIndex;
	monterey->supportIndirectCommandBuffers=sequoia->supportIndirectCommandBuffers;
	monterey->textureWriteRoundingMode=sequoia->textureWriteRoundingMode;
	monterey->anonymous_1.sampleCount=sequoia->anonymous_1.sampleCount;
	monterey->sampleMask=sequoia->sampleMask;
	monterey->anonymous_3.sampleCoverageHash=sequoia->anonymous_3.sampleCoverageHash;
	monterey->colorSampleCount=sequoia->colorSampleCount;
	monterey->anonymous_5.miscHash[0]=sequoia->anonymous_5.miscHash[0];
	monterey->anonymous_5.miscHash[1]=sequoia->anonymous_5.miscHash[1];
	monterey->vertexDepthCompareClampMask=sequoia->vertexDepthCompareClampMask;
	monterey->fragmentDepthCompareClampMask=sequoia->fragmentDepthCompareClampMask;
	monterey->resourceIndex=sequoia->resourceIndex;
	monterey->label=sequoia->label;
	monterey->vertexFunction=sequoia->vertexFunction;
	monterey->fragmentFunction=sequoia->fragmentFunction;
	monterey->vertexDescriptor=sequoia->vertexDescriptor;
	monterey->vertexBuffers=sequoia->vertexBuffers;
	monterey->fragmentBuffers=sequoia->fragmentBuffers;
	monterey->driverCompilerOptions=sequoia->driverCompilerOptions;
	monterey->pipelineLibrary=sequoia->pipelineLibrary;
	monterey->pluginData=sequoia->pluginData;
	monterey->needsCustomBorderColorSamplers=sequoia->needsCustomBorderColorSamplers;
	monterey->maxVertexAmplificationCount=sequoia->maxVertexAmplificationCount;
	monterey->binaryArchives=sequoia->binaryArchives;
	monterey->compilerTimeoutInSeconds=sequoia->compilerTimeoutInSeconds;
	monterey->vertexLinkedFunctions=sequoia->vertexLinkedFunctions;
	monterey->fragmentLinkedFunctions=sequoia->fragmentLinkedFunctions;
	monterey->vertexPreloadedLibraries=sequoia->vertexPreloadedLibraries;
	monterey->fragmentPreloadedLibraries=sequoia->fragmentPreloadedLibraries;
	monterey->maxVertexStackCallDepth=sequoia->maxVertexStackCallDepth;
	monterey->maxFragmentStackCallDepth=sequoia->maxFragmentStackCallDepth;
	monterey->supportAddingVertexBinaryFunctions=sequoia->supportAddingVertexBinaryFunctions;
	monterey->supportAddingFragmentBinaryFunctions=sequoia->supportAddingFragmentBinaryFunctions;
	return monterey;
}

SequoiaCompute* (*real_compute)(id,SEL);
void* fake_compute(id self,SEL sel)
{
	SequoiaCompute* sequoia=real_compute(self,sel);
	if(calledFromMetal())
	{
		return sequoia;
	}
	
	ensureThreadStorageMade();
	MontereyCompute* monterey=pthread_getspecific(threadMontereyComputeKey);
	if(!monterey)
	{
		monterey=malloc(sizeof(MontereyCompute));
		pthread_setspecific(threadMontereyComputeKey,monterey);
	}
	monterey->label=sequoia->label;
	monterey->computeFunction=sequoia->computeFunction;
	monterey->threadGroupSizeIsMultipleOfThreadExecutionWidth=sequoia->threadGroupSizeIsMultipleOfThreadExecutionWidth;
	monterey->maxTotalThreadsPerThreadgroup=sequoia->maxTotalThreadsPerThreadgroup;
	monterey->stageInputDescriptor=sequoia->stageInputDescriptor;
	monterey->driverCompilerOptions=sequoia->driverCompilerOptions;
	monterey->buffers=sequoia->buffers;
	monterey->binaryArchives=sequoia->binaryArchives;
	monterey->anonymous_1.preloadedLibraries=sequoia->anonymous_1.preloadedLibraries;
	monterey->pipelineLibrary=sequoia->pipelineLibrary;
	monterey->supportIndirectCommandBuffers=sequoia->supportIndirectCommandBuffers;
	monterey->textureWriteRoundingMode=sequoia->textureWriteRoundingMode;
	monterey->forceResourceIndex=sequoia->forceResourceIndex;
	monterey->resourceIndex=sequoia->resourceIndex;
	monterey->pluginData=sequoia->pluginData;
	monterey->needsCustomBorderColorSamplers=sequoia->needsCustomBorderColorSamplers;
	monterey->openGLMode=sequoia->openGLMode;
	monterey->openCLMode=sequoia->openCLMode;
	monterey->functionPointers=sequoia->functionPointers;
	monterey->functionPointerGroups=@{};
	monterey->linkedFunctions=sequoia->linkedFunctions;
	monterey->maxStackCallDepth=sequoia->maxStackCallDepth;
	monterey->supportAddingBinaryFunctions=sequoia->supportAddingBinaryFunctions;
	monterey->compilerTimeoutInSeconds=sequoia->compilerTimeoutInSeconds;
	return monterey;
}

__attribute__((constructor)) void load()
{
	@autoreleasepool
	{
		tracePrefix=@"structs interposer";
		traceLog=true;
		swizzleLog=false;
		
		swizzleImp(@"MTLRenderPipelineDescriptorInternal",@"_descriptorPrivate",true,(IMP)fake_render,(IMP*)&real_render);
		swizzleImp(@"MTLComputePipelineDescriptorInternal",@"_descriptorPrivate",true,(IMP)fake_compute,(IMP*)&real_compute);
	}
}
