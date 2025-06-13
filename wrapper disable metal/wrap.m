#import "Utils.h"

id returnNil()
{
	return nil;
}

__attribute__((constructor))void l()
{
	traceLog=true;
	tracePrefix=@"Amy";
	
	if([@[@"/System/Library/CoreServices/NotificationCenter.app/Contents/MacOS/NotificationCenter",@"/System/Applications/Font Book.app/Contents/MacOS/Font Book"] containsObject:NSProcessInfo.processInfo.arguments[0]])
	{
		if([NSUserDefaults.standardUserDefaults boolForKey:@"Amy.IvyMetalDisableDisable"])
		{
			trace(@"no lack of Metal for you!");
		}
		else
		{
			trace(@"no Metal for you!");
			swizzleImp(@"MTLIGAccelDevice",@"initWithAcceleratorPort:",true,(IMP)returnNil,NULL);
		}
	}
}