#import "Utils.h"
#import "metaliskil.m"

__attribute__((constructor))void load()
{
	tracePrint=false;
	traceLog=true;
	
	metalIsKilSetup();
}
