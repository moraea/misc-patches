#import "Utils.h"

void (*real_NSObject_doesNotRecognizeSelector)(NSObject*,SEL,SEL);

void fake_NSObject_doesNotRecognizeSelector(NSObject* self,SEL thisMethodSel,SEL passedSel)
{
	trace(@"NSObject doesNotRecognizeSelector: logger self %@ selector %s stack %@",self,passedSel,NSThread.callStackSymbols);
	
	real_NSObject_doesNotRecognizeSelector(self,thisMethodSel,passedSel);
}

NSObject* fake_CALocalDisplay_displayWithDisplayId_name_deviceName_update_timings()
{
	trace(@"fake_CALocalDisplay_displayWithDisplayId_name_deviceName_update_timings %@",NSThread.callStackSymbols);
	
	return nil;
}

__attribute__((constructor)) void load()
{
	@autoreleasepool
	{
		traceLog=true;
		tracePrint=false;
		swizzleLog=false;
		
		// copied non-metal, only logging
		
		swizzleImp(@"NSObject",@"doesNotRecognizeSelector:",true,(IMP)fake_NSObject_doesNotRecognizeSelector,(IMP*)&real_NSObject_doesNotRecognizeSelector);
		
		// fix weird crash?
		
		swizzleImp(@"CALocalDisplay",@"displayWithDisplayId:name:deviceName:update:timings:",false,(IMP)fake_CALocalDisplay_displayWithDisplayId_name_deviceName_update_timings,NULL);
	}
}

/*

copied non-metal, stubber bug

// nostub CASDFLayer
// nostub CASDFElementLayer

*/

@interface CASDFLayer:CALayer
@end

@implementation CASDFLayer

-(void)setSmoothness:(double)arg2
{
}

-(double)smoothness
{
	return 0;
}

-(id)effect
{
	return nil;
}

-(double)effectOffset
{
	return 0;
}

-(char)mergeElements
{
	return 0;
}

-(void)setEffect:(id)arg2
{
}

-(void)setEffectOffset:(double)arg2
{
}

-(void)setMergeElements:(char)arg2
{
}

@end

@interface CASDFElementLayer:CALayer
@end

@implementation CASDFElementLayer

-(void)setMode:(id)arg2
{
}

-(id)operation
{
	return nil;
}

-(void)setOperation:(id)arg2
{
}

-(id)mode
{
	return nil;
}

-(double)contentsOneValueDistance
{
	return 0;
}

-(double)contentsZeroValueDistance
{
	return 0;
}

-(double)gradientOvalization
{
	return 0;
}

-(char)hitTestsAsFill
{
	return 0;
}

-(void)setContentsOneValueDistance:(double)arg2
{
}

-(void)setContentsZeroValueDistance:(double)arg2
{
}

-(void)setGradientOvalization:(double)arg2
{
}

-(void)setHitTestsAsFill:(char)arg2
{
}

@end
