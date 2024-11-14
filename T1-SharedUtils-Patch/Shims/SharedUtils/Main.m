#import "Utils.h"

id fake()
{
	return nil;
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
		
        if([NSProcessInfo.processInfo.arguments[0] containsString:@"identityservicesd"])
        {
            swizzleImp(@"NGMFullPrekey",@"initWithPrekeySignedBy:error:",true,(IMP)fake,NULL);
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

@interface LACachedExternalizedContext:NSObject
@end
@interface LACachedExternalizedContext(Stub)
@end
@implementation LACachedExternalizedContext(Stub)
-(id)invalidate
{
    return nil;
}
@end

@interface LAPasscodeHelper:NSObject
@end
@interface LAPasscodeHelper(Stub)
@end
@implementation LAPasscodeHelper(Stub)
-(id)verifyPasswordUsingAKS:(id)arg2 acmContext:(id)arg3 userId:(id)arg4 policy:(id)arg5 options:(id)arg6 bioLockoutRecovery:(id)arg7
{
    return nil;
}
@end