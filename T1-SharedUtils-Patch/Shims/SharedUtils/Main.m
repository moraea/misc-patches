#import "Utils.h"

long fake()
{
	return 0;
}

__attribute__((constructor))
void load()
{
	traceLog=false;
	tracePrint=false;
	swizzleLog=false;

	if([NSProcessInfo.processInfo.arguments[0] containsString:@"coreauthd"])
	{
		swizzleImp(@"SecureStorage",@"exportedInterface",false,(IMP)fake,NULL);
	}
}