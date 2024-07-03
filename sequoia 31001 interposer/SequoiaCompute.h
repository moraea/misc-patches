// auto-generated

@class MTLProfileControl;
@class NSString;
@class MTLStageInputOutputDescriptor;
@class NSDictionary;
@class NSArray;
@class MTLLinkedFunctions;
@class MTLPipelineBufferDescriptorArrayInternal;
@protocol MTLFunction;
@protocol MTLPipelineLibrary;
struct sequoiaCompute_MTLComputePipelineDescriptorPrivate
{
	NSString* label;
	id<MTLFunction>* computeFunction;
	char threadGroupSizeIsMultipleOfThreadExecutionWidth;
	unsigned short maxTotalThreadsPerThreadgroup;
	MTLStageInputOutputDescriptor* stageInputDescriptor;
	NSDictionary* driverCompilerOptions;
	NSDictionary* gpuCompilerSPIOptions;
	MTLPipelineBufferDescriptorArrayInternal* buffers;
	NSArray* binaryArchives;
	union sequoiaCompute_anonymous_2
	{
		NSArray* preloadedLibraries;
		NSArray* insertLibraries;
	} anonymous_1;
	id<MTLPipelineLibrary>* pipelineLibrary;
	char supportIndirectCommandBuffers;
	long shaderValidation;
	long shaderValidationState;
	long textureWriteRoundingMode;
	char forceResourceIndex;
	unsigned long resourceIndex;
	NSDictionary* pluginData;
	char needsCustomBorderColorSamplers;
	int openGLMode:1;
	int openCLMode:1;
	int internalPipeline:1;
	int reserved:29;
	NSArray* functionPointers;
	MTLLinkedFunctions* linkedFunctions;
	unsigned long maxStackCallDepth;
	char supportAddingBinaryFunctions;
	unsigned long compilerTimeoutInSeconds;
	MTLProfileControl* profileControl;
	unsigned long maxAccelerationStructureTraversalDepth;
};
