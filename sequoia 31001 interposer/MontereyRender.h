// auto-generated

@class MTLVertexDescriptorInternal;
@class NSString;
@class MTLPipelineBufferDescriptorArrayInternal;
@class NSDictionary;
@class NSArray;
@class MTLLinkedFunctions;
@class MTLRenderPipelineColorAttachmentDescriptorArrayInternal;
@protocol MTLFunction;
@protocol MTLPipelineLibrary;
struct montereyRender_MTLRenderPipelineDescriptorPrivate
{
	MTLRenderPipelineColorAttachmentDescriptorArrayInternal* attachments;
	unsigned long rtBlendDescHash[8];
	unsigned long depthAttachmentPixelFormat;
	unsigned long stencilAttachmentPixelFormat;
	unsigned long tessellationPartitionMode;
	unsigned long maxTessellationFactor;
	char tessellationFactorScaleEnabled;
	unsigned long tessellationFactorFormat;
	unsigned long tessellationControlPointIndexType;
	unsigned long tessellationFactorStepFunction;
	unsigned long tessellationOutputWindingOrder;
	unsigned long postVertexDumpBufferIndex;
	char supportIndirectCommandBuffers;
	long textureWriteRoundingMode;
	union montereyRender_anonymous_2
	{
		unsigned long sampleCount;
		unsigned long rasterSampleCount;
	} anonymous_1;
	unsigned long sampleMask;
	union montereyRender_anonymous_4
	{
		unsigned int sampleCoverageHash;
		float sampleCoverage;
	} anonymous_3;
	unsigned long paddingToRemove;
	unsigned long colorSampleCount;
	union montereyRender_anonymous_6
	{
		unsigned int miscHash[2];
		struct montereyRender_anonymous_8
		{
			int alphaToCoverageEnabled:1;
			int alphaToOneEnabled:1;
			int rasterizationEnabled:1;
			int inputPrimitiveTopology:2;
			int private0:1;
			int depthStencilWriteDisabled:1;
			int openGLMode:1;
			int sampleCoverageInvert:1;
			int private4:1;
			int vertexAmplificationMode:1;
			int twoSideEnabled:1;
			int pointSizeOutputVS:1;
			int pointCoordLowerLeft:1;
			int pointSmoothEnabled:1;
			int clipDistanceEnableMask:8;
			int alphaTestFunc:3;
			int alphaTestEnabled:1;
			int logicOp:4;
			int logicOpEnabled:1;
			int forceResourceIndex:1;
			int forceSoftwareVertexFetch:1;
			int private6:2;
		} anonymous_7;
	} anonymous_5;
	unsigned int vertexDepthCompareClampMask;
	unsigned int fragmentDepthCompareClampMask;
	unsigned long resourceIndex;
	NSString* label;
	id<MTLFunction>* vertexFunction;
	id<MTLFunction>* fragmentFunction;
	MTLVertexDescriptorInternal* vertexDescriptor;
	MTLPipelineBufferDescriptorArrayInternal* vertexBuffers;
	MTLPipelineBufferDescriptorArrayInternal* fragmentBuffers;
	NSDictionary* driverCompilerOptions;
	id<MTLPipelineLibrary>* pipelineLibrary;
	void* pad0;
	void* pad1;
	NSDictionary* pluginData;
	char needsCustomBorderColorSamplers;
	unsigned int maxVertexAmplificationCount;
	NSArray* binaryArchives;
	unsigned long compilerTimeoutInSeconds;
	MTLLinkedFunctions* vertexLinkedFunctions;
	MTLLinkedFunctions* fragmentLinkedFunctions;
	NSArray* vertexPreloadedLibraries;
	NSArray* fragmentPreloadedLibraries;
	unsigned long maxVertexStackCallDepth;
	unsigned long maxFragmentStackCallDepth;
	char supportAddingVertexBinaryFunctions;
	char supportAddingFragmentBinaryFunctions;
};