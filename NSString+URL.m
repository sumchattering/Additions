//
//  NSString+URL.m
//  Facebook
//
//  Created by Sumeru Chatterjee on 5/18/11.
//  Copyright 2011 . All rights reserved.
//

#import "NSString+URL.h"


@implementation NSString (URL)
///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSString*) firstURLinString
{
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
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&error];
	if (error)
		return nil;

	NSArray* matches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
	if ([matches count]>0)
		return [self substringWithRange:[[matches objectAtIndex:0] range]];
	else
		return nil;
}

@end
