//
//  NSObject+Supersequent.h
//  HumanKitCatalog
//
//  Created by Sumeru Chatterjee on 12/24/11.
//  The supersequent methods are courtesy of Matt Gallagher
//  http://cocoawithlove.com/2008/03/supersequent-implementation.html
//  

#import <Foundation/Foundation.h>

//Check if a protocol has a given selector
BOOL protocol_containsSelector(Protocol *p, SEL aSel);

//Call the original method in a category
#define invokeSupersequent(...) ([self getImplementationOf:_cmd after:impOfCallingMethod(self, _cmd)])(self, _cmd, ##__VA_ARGS__)

//Call the original method in a category without any parameters
#define invokeSupersequentNoParameters() ([self getImplementationOf:_cmd after:impOfCallingMethod(self, _cmd)])(self, _cmd)

//Function to get the IMP of the current method
IMP impOfCallingMethod(id lookupObject, SEL selector);

//Description of Caller Method


@interface NSObject (Supersequent)
-(NSString*) descriptionOfMethodAtStackDepth:(NSInteger)depth;
- (IMP)getImplementationOf:(SEL)lookup after:(IMP)skip;
+ (BOOL)swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_;
+ (BOOL)swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_;
@property (readonly) NSDictionary *ivars;
- (NSArray *) superclasses;
@end
