#import "Utils.h"

id fake()
{
	return nil;
}

NSXPCInterface* (*real_LAInternalProtocols_interfaceWithInternalProtocol)(NSObject*,SEL,Protocol*);

NSXPCInterface* fake_LAInternalProtocols_interfaceWithInternalProtocol(NSObject* self,SEL selector,Protocol* protocol)
{
	if(protocol&&[@[@"LACRemoteUIHost",@"LACAgentProxyXPC",@"LACRemoteUI",@"LACUIMechanism"] containsObject:[NSString stringWithUTF8String:protocol_getName(protocol)]])
	{
		Class LACXPCInterface=NSClassFromString(@"LACXPCInterface");
		return [LACXPCInterface interfaceForXPCProtocol:protocol];
	}
	
	return real_LAInternalProtocols_interfaceWithInternalProtocol(self,selector,protocol);
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
        
        Class MechanismBase=NSClassFromString(@"MechanismBase");
        if(MechanismBase)
        {
			class_addMethod(MechanismBase,sel_registerName("canRecoverFromError:request:"),(IMP)fake,"q@:qq");
		}

        swizzleImp(@"LAParamChecker",@"checkOptions:",false,(IMP)fake,NULL);
        
        swizzleImp(@"LAInternalProtocols",@"interfaceWithInternalProtocol:",false,(IMP)fake_LAInternalProtocols_interfaceWithInternalProtocol,(IMP*)&real_LAInternalProtocols_interfaceWithInternalProtocol);
    }
}

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
-(id)invalidateBecauseOfInvalidConnection:(id)arg2
{
    return nil;
}
@end

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
