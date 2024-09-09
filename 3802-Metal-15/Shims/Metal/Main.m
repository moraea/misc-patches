#import "Utils.h"

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
		
		if([NSProcessInfo.processInfo.arguments[0] containsString:@"WallpaperSequoiaExtension"])
		{
        	swizzleImp(@"MTLTextureDescriptorInternal",@"validateWithDevice:",true,(IMP)fake_true,NULL);
			swizzleImp(@"MTLRenderPipelineDescriptorInternal",@"validateWithDevice:error:",true,(IMP)fake_true,NULL);
		}
		
		if([NSProcessInfo.processInfo.arguments[0] containsString:@"Safari"])
		{
        	swizzleImp(@"_MTLFunction",@"newArgumentEncoderWithBufferIndex:reflection:functionReflection:",true,(IMP)fake_kil,NULL);
        	swizzleImp(@"_MTLDevice",@"newArgumentEncoderWithBufferBinding:",true,(IMP)fake_kil,NULL);
		}
	}
}