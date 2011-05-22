//
//  NSArray+Identical.m
//  Additions
//
//  Created by Sumeru Chatterjee on 5/19/11.
//  Copyright 2011 . All rights reserved.
//

#import "NSArray+Identical.h"


@implementation NSArray (Identical)
+ arrayWithIdenticalObjectsWithObject:(id)object count:(NSInteger)count
{	
	if (!object){
		return nil;
	}
	
	NSMutableArray* array = [NSMutableArray array];
	
	if (!count) {
		return array;
	}
	
	[array addObject:object];
	for (NSInteger iteration=1; iteration<count; iteration++) {
		[array addObject:[[object copy] autorelease]];
	}
	
	return [NSArray arrayWithArray:array];
}	

@end
