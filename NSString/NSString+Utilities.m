//
//  NSString+Utilities.m
//  Additions
//
//  Created by Erica Sadun, http://ericasadun.com
//  iPhone Developer's Cookbook, 3.0 Edition
//  BSD License, Use at your own risk

#import "NSString+Utilities.h"

@implementation  NSString (UtilityExtensions)
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) trimmedString
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (int) occurrencesOfString: (NSString *) aString
{
	return [self componentsSeparatedByString:aString].count -1;
}

// run srandom() somewhere in your app // http://tinypaste.com/5f1c9
// Requested by BleuLlama
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) stringByAppendingRandomStringOfRandomLength
{
	int len = random() % 32;
	NSMutableArray *chars = [NSMutableArray array];
	NSMutableString *s = [NSMutableString stringWithString:self];

	NSMutableCharacterSet *cs = [[NSMutableCharacterSet alloc] init];
	[cs formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
	[cs formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
	// [cs formUnionWithCharacterSet:[NSCharacterSet symbolCharacterSet]];
	// [cs formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];

	// init char array from charset
	for (int c = 0; c < 128; c++) // 7 bit only
		if ([cs characterIsMember:(unichar)c])
			[chars addObject:[NSString stringWithFormat:@"%c", c]];

	for (int i = 0; i < len; i++) [s appendString:[chars objectAtIndex:(random() % chars.count)]];

	[cs release];
	return s;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDate *) date
{
	// Return a date from a string
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	formatter.dateFormat = @"MM-dd-yyyy";
	NSDate *date = [formatter dateFromString:self];
	return date;
}

// return a comma delimited string
///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *) commasForNumber: (long long) num
{
	if (num < 1000) return [NSString stringWithFormat:@"%d", num];
	return	[[self commasForNumber:num/1000] stringByAppendingFormat:@",%03d", (num % 1000)];
}
@end

