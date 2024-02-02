#import "Utils.h"

long fake_canDoHEVC()
{
	return 1;
}

__attribute__((constructor)) void load()
{
	traceLog=true;
	if([NSProcessInfo.processInfo.arguments[0] isEqualToString:@"/usr/libexec/ContinuityCaptureAgent"])
	{
		swizzleImp(@"VCHardwareSettingsMac",@"canDoHEVC",true,(IMP)fake_canDoHEVC,NULL);
	}
}