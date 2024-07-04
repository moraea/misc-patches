// TODO: check, move some to general utils?

void* getOrMakeThreadStorage(dispatch_once_t* setupOnce,pthread_key_t* keyReference,unsigned long size)
{
	dispatch_once(setupOnce,^()
	{
		assert(!pthread_key_create(keyReference,free));
	});
	
	void* storage=pthread_getspecific(*keyReference);
	if(!storage)
	{
		storage=malloc(size);
		pthread_setspecific(*keyReference,storage);
	}
	
	return storage;
}

BOOL inDSC(void* address)
{
	return address>(void*)0x700000000000;
}

BOOL alreadySwizzled(NSString* className,NSString* selName,BOOL isInstance)
{
	Class class=NSClassFromString(className);
	if(!class)
	{
		return false;
	}
	
	SEL sel=NSSelectorFromString(selName);
	Method method=(isInstance?class_getInstanceMethod:class_getClassMethod)(class,sel);
	if(!method)
	{
		return false;
	}
	
	return !inDSC(method_getImplementation(method));
}

void swizzleSafer(NSString* className,NSString* selName,BOOL isInstance,IMP newImp,IMP* oldImpOut)
{
	if(alreadySwizzled(className,selName,isInstance))
	{
		return;
	}
	
	swizzleImp(className,selName,isInstance,newImp,oldImpOut);
}

__attribute__((always_inline)) BOOL calledFromMetal()
{
	void* caller=__builtin_extract_return_addr(__builtin_return_address(0));
	return inDSC(caller);
}
