#import "Utils.h"

void add(Class class,NSString* selString,IMP imp,char* types)
{
	BOOL result=class_addMethod(class,NSSelectorFromString(selString),imp,types);
	if(swizzleLog)
	{
		trace(@"add %@ %@ returned %d",NSStringFromClass(class),selString,result);
	}
}

id fake(id self,SEL sel,id rdx)
{
	return nil;
}

long fake_true()
{
	return 1;
}

long fake_kil()
{
	return 0;
}

// TEMPORARY AMY CURSED THING

dispatch_data_t amyCursed(dispatch_data_t original)
{
	// TODO: leaks memory but we have bigger problems lol
	
	void* bytes;
	long size;
	dispatch_data_create_map(original,&bytes,&size);
	
	return dispatch_data_create((char*)bytes+0x50,size-0x50,NULL,DISPATCH_DATA_DESTRUCTOR_FREE);
}

NSObject* (*real_MTLRenderPipelineReflectionInternal_initWithVertexData)(NSObject*,SEL,dispatch_data_t,dispatch_data_t,dispatch_data_t,NSObject*,long,long);

NSObject* fake_MTLRenderPipelineReflectionInternal_initWithVertexData(NSObject* self,SEL sel,dispatch_data_t vertexData,dispatch_data_t fragmentData,dispatch_data_t weirdData,NSObject* device,long options,long flags)
{
	vertexData=amyCursed(vertexData);
	fragmentData=amyCursed(fragmentData);
	
	return real_MTLRenderPipelineReflectionInternal_initWithVertexData(self,sel,vertexData,fragmentData,weirdData,device,options,flags);
}

NSObject* (*real_MTLComputePipelineReflectionInternal_initWithSerializedData)(NSObject*,SEL,dispatch_data_t,dispatch_data_t,NSObject*,long,long);

NSObject* fake_MTLComputePipelineReflectionInternal_initWithSerializedData(NSObject* self,SEL sel,dispatch_data_t functionData,dispatch_data_t weirdData,NSObject* device,long options,long flags)
{
	functionData=amyCursed(functionData);
	
	return real_MTLComputePipelineReflectionInternal_initWithSerializedData(self,sel,functionData,weirdData,device,options,flags);
}

__attribute__((constructor))
void load()
{
	@autoreleasepool
	{
		traceLog=true;
		tracePrint=false;
		swizzleLog=false;
		
		NSString* process=NSProcessInfo.processInfo.arguments[0];
		
		swizzleImp(@"MTLCompiler",@"validateLanguageAndAIRVersionForFunction:completionHandler:",true,(IMP)fake_true,NULL);
		
		// xcode crash
		add(NSClassFromString(@"MTLHeapDescriptorInternal"),@"addressRanges",(IMP)fake,"@@:@");
		add(NSClassFromString(@"MTLHeapDescriptorInternal"),@"setAddressRanges:",(IMP)fake,"@@:@");
		
		// WhatsApp app crash
		add(NSClassFromString(@"NSProcessInfo"),@"isDeviceCertifiedFor:",(IMP)fake,"@@:@");
		add(NSClassFromString(@"NSProcessInfo"),@"hasPerformanceProfile:",(IMP)fake,"@@:@");
		
		// hide distracting items
		if([process containsString:@"Safari"])
		{
        	swizzleImp(@"_MTLFunction",@"newArgumentEncoderWithBufferIndex:reflection:functionReflection:",true,(IMP)fake_kil,NULL);
        	swizzleImp(@"_MTLDevice",@"newArgumentEncoderWithBufferBinding:",true,(IMP)fake_kil,NULL);
		}
		
		if([process containsString:@"WallpaperSequoiaExtension"])
		{
        	swizzleImp(@"MTLTextureDescriptorInternal",@"validateWithDevice:",true,(IMP)fake_true,NULL);
			swizzleImp(@"MTLRenderPipelineDescriptorInternal",@"validateWithDevice:error:",true,(IMP)fake_true,NULL);
		}
		
		// TEMPORARY AMY CURSED THING
		
		swizzleImp(@"MTLRenderPipelineReflectionInternal",@"initWithVertexData:fragmentData:serializedVertexDescriptor:device:options:flags:",true,(IMP)fake_MTLRenderPipelineReflectionInternal_initWithVertexData,(IMP*)&real_MTLRenderPipelineReflectionInternal_initWithVertexData);
		swizzleImp(@"MTLComputePipelineReflectionInternal",@"initWithSerializedData:serializedStageInputDescriptor:device:options:flags:",true,(IMP)fake_MTLComputePipelineReflectionInternal_initWithSerializedData,(IMP*)&real_MTLComputePipelineReflectionInternal_initWithSerializedData);
	}
}
