#import "Utils.h"

void add(Class class,NSString* selString,IMP imp,char* types)
{
	trace(@"cw: class_addMethod %@ %d",selString,class_addMethod(class,NSSelectorFromString(selString),imp,types));
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
	
__attribute__((constructor))
void load()
{
	@autoreleasepool
	{
		traceLog=false;
		tracePrint=false;
		swizzleLog=false;

		swizzleImp(@"MTLCompiler",@"validateLanguageAndAIRVersionForFunction:completionHandler:",true,(IMP)fake_true,NULL);
		
		// xcode crash
		add(NSClassFromString(@"MTLHeapDescriptorInternal"),@"addressRanges",(IMP)fake,"@@:@");
		add(NSClassFromString(@"MTLHeapDescriptorInternal"),@"setAddressRanges:",(IMP)fake,"@@:@");
		
		// WhatsApp app crash
		add(NSClassFromString(@"NSProcessInfo"),@"isDeviceCertifiedFor:",(IMP)fake,"@@:@");
		add(NSClassFromString(@"NSProcessInfo"),@"hasPerformanceProfile:",(IMP)fake,"@@:@");
		
		// hide distracting items
		if([NSProcessInfo.processInfo.arguments[0] containsString:@"Safari"])
		{
        	swizzleImp(@"_MTLFunction",@"newArgumentEncoderWithBufferIndex:reflection:functionReflection:",true,(IMP)fake_kil,NULL);
        	swizzleImp(@"_MTLDevice",@"newArgumentEncoderWithBufferBinding:",true,(IMP)fake_kil,NULL);
		}
		
		if([NSProcessInfo.processInfo.arguments[0] containsString:@"WallpaperSequoiaExtension"])
		{
        	swizzleImp(@"MTLTextureDescriptorInternal",@"validateWithDevice:",true,(IMP)fake_true,NULL);
			swizzleImp(@"MTLRenderPipelineDescriptorInternal",@"validateWithDevice:error:",true,(IMP)fake_true,NULL);
		}
	}
}