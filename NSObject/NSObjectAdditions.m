//
//  NSObjectAdditions.m
//  HumanKitCatalog
//
//  Created by Sumeru Chatterjee on 12/24/11.
//  Copyright (c) 2011 Sumeru Chatterjee. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObjectAdditions.h"

#define SetNSErrorFor(FUNC, ERROR_VAR, FORMAT,...)	\
if (ERROR_VAR) {	\
NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
code:-1	\
userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
}

#define SetNSError(ERROR_VAR, FORMAT,...) SetNSErrorFor(__func__, ERROR_VAR, FORMAT, ##__VA_ARGS__)
#define GetClass(obj)	object_getClass(obj)


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL protocol_containsSelector(Protocol *p, SEL aSel) {    
    
    //Check for required methods
    struct objc_method_description methodDescription = protocol_getMethodDescription(p,aSel, YES, YES);
    if(methodDescription.name!=nil)
        return YES;
    
    //Check for optional methods
    methodDescription = protocol_getMethodDescription(p,aSel, NO, YES);
    return (methodDescription.name!=nil);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
IMP impOfCallingMethod(id lookupObject, SEL selector)
{
    NSUInteger returnAddress = (NSUInteger)__builtin_return_address(0);
    NSUInteger closest = 0;
    
    // Iterate over the class and all superclasses
    Class currentClass = object_getClass(lookupObject);
    while (currentClass)
    {
        // Iterate over all instance methods for this class
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        unsigned int i;
        for (i = 0; i < methodCount; i++)
        {
            // Ignore methods with different selectors
            if (method_getName(methodList[i]) != selector)
            {
                continue;
            }
            
            // If this address is closer, use it instead
            NSUInteger address = (NSUInteger)method_getImplementation(methodList[i]);
            if (address < returnAddress && address > closest)
            {
                closest = address;
            }
        }
        
        free(methodList);
        currentClass = class_getSuperclass(currentClass);
    }
    return (IMP)closest;
}


@implementation NSObject (HICategory)

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSString*) descriptionOfMethodAtStackDepth:(NSInteger) depth {
    
    NSArray *syms = [NSThread  callStackSymbols]; 
    if ([syms count] > depth+1) { 
        return [NSString stringWithFormat:@"%@",[syms objectAtIndex:depth+1]];
    } else {
        return [NSString stringWithString:@"Depth exceeds maximum depth"]; 
    }
}

// Lookup the next implementation of the given selector after the
// default one. Returns nil if no alternate implementation is found.
///////////////////////////////////////////////////////////////////////////////////////////////////
- (IMP)getImplementationOf:(SEL)lookup after:(IMP)skip
{   
    BOOL found = NO;
    
    Class currentClass = object_getClass(self);
    while (currentClass)
    {
        // Get the list of methods for this class
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        
        // Iterate over all methods
        unsigned int i;
        for (i = 0; i < methodCount; i++)
        {
            // Look for the selector
            if (method_getName(methodList[i]) != lookup)
            {
                continue;
            }
            
            IMP implementation = method_getImplementation(methodList[i]);
            
            // Check if this is the "skip" implementation
            if (implementation == skip)
            {
                found = YES;
            }
            else if (found)
            {
                // Return the match.
                free(methodList);
                return implementation;
            }
        }
        
        // No match found. Traverse up through super class' methods.
        free(methodList);
        
        currentClass = class_getSuperclass(currentClass);
    }
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_ {
	
    Method origMethod = class_getInstanceMethod(self, origSel_);
	if (!origMethod) {
		SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self class]);
		return NO;
	}
    
	Method altMethod = class_getInstanceMethod(self, altSel_);
	if (!altMethod) {
		SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self class]);
		return NO;
	}
    
	class_addMethod(self,
					origSel_,
					class_getMethodImplementation(self, origSel_),
					method_getTypeEncoding(origMethod));
	class_addMethod(self,
					altSel_,
					class_getMethodImplementation(self, altSel_),
					method_getTypeEncoding(altMethod));
    
	method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));
	return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_ {
	return [GetClass((id)self) swizzleMethod:origSel_ withMethod:altSel_ error:error_];
}

// Return an array of all an object's properties
///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSArray *) getIvarListForClass
{
	NSMutableArray *ivarNames = [NSMutableArray array];
	unsigned int num;
	Ivar *ivars = class_copyIvarList(self, &num);
	for (int i = 0; i < num; i++)
		[ivarNames addObject:[NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding]];
	free(ivars);
	return ivarNames;
}

// Return a dictionary with class/selectors entries, all the way up to NSObject
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDictionary *) ivars
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	[dict setObject:[[self class] getIvarListForClass] forKey:NSStringFromClass([self class])];
	for (Class cl in [self superclasses])
		[dict setObject:[cl getIvarListForClass] forKey:NSStringFromClass(cl)];
	return dict;
}

// Return an array of an object's superclasses
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray *) superclasses
{
	Class cl = [self class];
	NSMutableArray *results = [NSMutableArray arrayWithObject:cl];
    
	do
	{
		cl = [cl superclass];
		[results addObject:cl];
	}
	while (![cl isEqual:[NSObject class]]) ;
    
	return results;
}

@end
