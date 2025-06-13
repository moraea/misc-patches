#define trace NSLog

@import Foundation;

@interface NFSecureElement:NSObject
@end
@interface NFSecureElement(Stub)
@end
@implementation NFSecureElement(Stub)

+(NSData*)embeddedSecureElementSerialNumber
{
	// TODO: this is the cache miss path and will probably be slow
	// TODO: these functions generate a lot of warnings
	
	NSObject* manager=[NSClassFromString(@"NFHardwareManager") sharedHardwareManager];
	
	NSError* error=nil;
	NSObject* element=[manager secureElementWithIdentifier:@"embedded" error:&error];
	
	return [NSData NF_dataWithHexString:[element serialNumber]];
}

@end

// TODO: this was crashing as a bad bind, which is weird. we should've at least gotten a stub..

NSString* NFSecureElementSerialNumberToString(NSData* data)
{
	return [data NF_asHexString];
}

/*

hopper 15.5 rc libnfshared.dylib, copied all but not sure which called yet
in practice, won't really do anything without NFXPCConnectionUserInfoDictionary etc..
should at least clear missing selectors since stubber (🤦🏻‍♀️) doesn't handle categories

*/

@interface NSXPCConnection(Shim_NFUserInfo)
@end

@implementation NSXPCConnection(Shim_NFUserInfo)

-(NSObject*)NF_userInfo
{
	trace(@"NSXPCConnection NF_userInfo %@",NSThread.callStackSymbols);
	
	return [self userInfo];
}

-(NSString*)NF_clientName
{
	trace(@"NSXPCConnection NF_clientName %@",NSThread.callStackSymbols);
	
	return [[self userInfo] clientName];
}

-(NSNumber*)NF_serviceType
{
	trace(@"NSXPCConnection NF_serviceType %@",NSThread.callStackSymbols);
	
	return [[self userInfo] objectForKeyedSubscript:@"serviceType"];
}

-(BOOL)NF_presentmentIntentSuppressionHolder
{
	trace(@"NSXPCConnection NF_presentmentIntentSuppressionHolder %@",NSThread.callStackSymbols);
	
	return [[[self userInfo] objectForKeyedSubscript:@"PresentmentIntentSuppressionHolder"] boolValue];
}

-(NSObject*)NF_setPresentmentIntentSuppressionHolder
{
	trace(@"NSXPCConnection NF_setPresentmentIntentSuppressionHolder %@",NSThread.callStackSymbols);
	
	/*
	
	i don't know what the object is supposed to be?
	a global broken by hopper dsc extractor, not an argument to the function
	
	[[self userInfo] setObject:???? forKey::@"PresentmentIntentSuppressionHolder"];
	
	*/
	
	return nil;
}

-(NSObject*)NF_clearPresentmentIntentSuppressionHolder
{
	trace(@"NSXPCConnection NF_clearPresentmentIntentSuppressionHolder %@",NSThread.callStackSymbols);
	
	[[self userInfo] removeObjectForKey:@"PresentmentIntentSuppressionHolder"];
	
	return nil;
}

-(BOOL)NF_fdPresentmentIntentSuppressionHolder
{
	trace(@"NSXPCConnection NF_fdPresentmentIntentSuppressionHolder %@",NSThread.callStackSymbols);
	
	return [[[self userInfo] objectForKeyedSubscript:@"FDPresentmentIntentSuppressionHolder"] boolValue];
}

-(NSObject*)NF_setFDPresentmentIntentSuppressionHolder
{
	trace(@"NSXPCConnection NF_setFDPresentmentIntentSuppressionHolder %@",NSThread.callStackSymbols);
	
	/*
	
	same problem as above but different key
	
	*/
	
	return nil;
}

-(NSObject*)NF_clearFDPresentmentIntentSuppressionHolder
{
	trace(@"NSXPCConnection NF_clearFDPresentmentIntentSuppressionHolder %@",NSThread.callStackSymbols);
	
	[[self userInfo] removeObjectForKey:@"FDPresentmentIntentSuppressionHolder"];
	
	return nil;
}

@end
