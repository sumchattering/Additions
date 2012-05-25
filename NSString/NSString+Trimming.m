//
//  NSString+Trimming.m
//  Additions
//
//  Created by Sumeru Chatterjee on 11/13/11.
//

#import "NSString+Trimming.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSString (Trimming)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];

    for (location=0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];

    for (length=[self length]; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }

    return [self substringWithRange:NSMakeRange(location, length - location)];
}

@end