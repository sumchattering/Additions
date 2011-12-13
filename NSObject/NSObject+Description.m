//
//  NSObject+Description.m
//  Additions
//
//  Created by Sumeru Chatterjee on 6/30/11.

#import <objc/objc.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

#import "NSObject+Description.h"

@interface NSObject (DescriptionPrivate)
///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) hasDefaultDescription;
@end

@implementation NSObject (Description)

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSString*) completeDescription
{
	NSMutableString* description = [NSMutableString stringWithString:@"\n"];

    [description appendFormat:@"\nType:%@",NSStringFromClass([self class])];

	NSString* tabbedIvarDescription = [[self ivarDescription] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];

	[description appendFormat:@"\nInstanceVariables:%@",tabbedIvarDescription];

	return description;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*) ivarDescription
{
	NSMutableString* ivarDescription = [NSMutableString string];

	unsigned int varCount;

	Ivar *vars = class_copyIvarList([self class],&varCount);

	if (varCount==0)
		return @"None";

	for (int i=0;i<varCount; i++) {
		Ivar var = vars[i];

		const char* name = ivar_getName(var);

		const char* type = ivar_getTypeEncoding(var);

		NSString* nameString = [NSString stringWithCString:name encoding:NSASCIIStringEncoding];

		NSString* typeString = [NSString stringWithCString:type encoding:NSASCIIStringEncoding];

		NSString* pureTypeString = [typeString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];

		id object = [self valueForKey:nameString];

		NSString* description=[object description];

		if ([object hasDefaultDescription]) {
			description = [object ivarDescription];
		}
		else if ([object isKindOfClass:[NSArray class]]) {
			if ([object count] == 0) {
				description = @"Empty";
			}
			else {
				NSArray* array = (NSArray*)object;
				NSMutableString* subDescription = [NSMutableString string];

				for (id subObject in array)
				{
					NSString* tabbedSubObjectDescription = [[subObject ivarDescription] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
					[subDescription appendFormat:@"\n<Index:%d> Type:%@ Size:%zd Description:%@",[array indexOfObject:subObject],NSStringFromClass([subObject class]),malloc_size(subObject),tabbedSubObjectDescription];
				}

				description = [NSString stringWithString:subDescription];
			}
		}

		NSString* tabbedDescription = [description stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
		[ivarDescription appendFormat:@"\nType:%@ Name:%@ Size:%zd Description:%@",pureTypeString,nameString,malloc_size(object),tabbedDescription];
	}

	return ivarDescription;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) hasDefaultDescription
{
	NSString* defaultDescriptionRegex = @"<\\S+:\\s0x\\S+>";
	NSPredicate* test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",defaultDescriptionRegex];
	return [test evaluateWithObject:[self description]];
}

@end
