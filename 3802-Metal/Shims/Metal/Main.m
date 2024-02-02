#import "Utils.h"

long fake_validateAIR()
{
	return 1;
}

__attribute__((constructor))
void load()
{
	traceLog=false;
	tracePrint=false;
	swizzleLog=false;

	swizzleImp(@"MTLCompiler",@"validateLanguageAndAIRVersionForFunction:completionHandler:",true,(IMP)fake_validateAIR,NULL);
}