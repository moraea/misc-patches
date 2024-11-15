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
