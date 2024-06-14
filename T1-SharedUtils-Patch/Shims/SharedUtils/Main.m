#import "Utils.h"

long fake()
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
        
        if([NSProcessInfo.processInfo.arguments[0] containsString:@"coreauthd"])
        {
            swizzleImp(@"SecureStorage",@"exportedInterface",false,(IMP)fake,NULL);
        }
    }
}

@interface LAACMHelper:NSObject
@end
@interface LAACMHelper(Stub)
@end
@implementation LAACMHelper(Stub)
-(id)clear
{
    return nil;
}
@end

@interface LAAssertionsProxy:NSObject
@end
@interface LAAssertionsProxy(Stub)
@end
@implementation LAAssertionsProxy(Stub)
-(id)takeTouchIdAssertionWithReason:(id)arg2 reply:(id)arg3
{
    return nil;
}
-(id)dropTouchIdAssertionWithReason:(id)arg2 reply:(id)arg3
{
    return nil;
}
@end
