//
//  NSString+Regex.m
//  Additions
//
//  Created by Sumeru Chatterjee on 5/18/11.


#import "NSString+Regex.h"


@implementation NSString (Regex)
///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSString*) firstURLinString
{
    //TODO:Fix the regex

    NSString* url;
	//NSString* pattern =  @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
	NSString* schemePattern = @"(http|https)://(([a-zA-Z0-9-.]+\\.[a-zA-Z]{2,3})|([0-2]*\\d*\\d\\.[0-2]*\\d*\\d\\.[0-2]*\\d*\\d\\.[0-2]*\\d*\\d))(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9-._\\?\\,\\'/\\+&%\\$#\\=~])*[^.\\,)(\\s]$";
	if (url = [self firstStringWithPattern:schemePattern]) {
		return url;
	}

	NSString* noSchemePattern = @"(([a-zA-Z0-9-.]+\\.[a-zA-Z]{2,3})|([0-2]*\\d*\\d\\.[0-2]*\\d*\\d\\.[0-2]*\\d*\\d\\.[0-2]*\\d*\\d))(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9-._\\?\\,\\'/\\+&%\\$#\\=~])*[^.\\,)(\\s]$";
	return [self firstStringWithPattern:noSchemePattern];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSString*) firstStringWithPattern:(NSString*)pattern
{
	NSError* err = nil;
	NSString* result = nil;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&err];
	NSTextCheckingResult* match;
	if (match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])]) {

		if ([match numberOfRanges]>1)
			result = [self substringWithRange:[match rangeAtIndex:1]];
		else
			result = [self substringWithRange:[match range]];
	}

	return result;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(BOOL) matchesPattern:(NSString*)pattern
{

	NSError* err = nil;
	BOOL result = FALSE;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&err];
	NSTextCheckingResult* match;
	NSRange selfRange = NSMakeRange(0, [self length]);

	if (match = [regex firstMatchInString:self options:0 range:selfRange]) {

		result = NSEqualRanges([match range],selfRange);
	}
	return result;
}


@end
