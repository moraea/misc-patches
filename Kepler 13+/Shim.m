@import Foundation;
@import ObjectiveC;

long fake(NSObject* self,SEL sel)
{
	return *(long*)((char*)self+0x90);
}

__attribute__((constructor)) void load()
{
	class_addMethod(NSClassFromString(@"NVMTLHeap"),sel_registerName("protectionOptions"),(IMP)fake,"q@:");
}
