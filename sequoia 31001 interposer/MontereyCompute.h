// auto-generated

@class NSString;
@class MTLStageInputOutputDescriptor;
@class NSDictionary;
@class NSArray;
@class MTLLinkedFunctions;
@class MTLPipelineBufferDescriptorArrayInternal;
@protocol MTLFunction;
@protocol MTLPipelineLibrary;
struct montereyCompute_MTLComputePipelineDescriptorPrivate
{
	NSString* label;
	id<MTLFunction>* computeFunction;
	char threadGroupSizeIsMultipleOfThreadExecutionWidth;
	unsigned short maxTotalThreadsPerThreadgroup;
	MTLStageInputOutputDescriptor* stageInputDescriptor;
	NSDictionary* driverCompilerOptions;
	MTLPipelineBufferDescriptorArrayInternal* buffers;
	NSArray* binaryArchives;
	union montereyCompute_anonymous_2
	{
		NSArray* preloadedLibraries;
		NSArray* insertLibraries;
	} anonymous_1;
	id<MTLPipelineLibrary>* pipelineLibrary;
	char supportIndirectCommandBuffers;
	long textureWriteRoundingMode;
	char forceResourceIndex;
	unsigned long resourceIndex;
	NSDictionary* pluginData;
	char needsCustomBorderColorSamplers;
	int openGLMode:1;
	int openCLMode:1;
	int reserved:30;
	NSArray* functionPointers;
	NSDictionary* functionPointerGroups;
	MTLLinkedFunctions* linkedFunctions;
	unsigned long maxStackCallDepth;
	char supportAddingBinaryFunctions;
	unsigned long compilerTimeoutInSeconds;
};
