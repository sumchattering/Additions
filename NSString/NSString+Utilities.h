/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>


@interface NSString (UtilityExtensions)
- (NSString *) stringByAppendingRandomStringOfRandomLength;
- (int) occurrencesOfString: (NSString *) aString;
- (NSDate *) date;
+ (NSString *) commasForNumber: (long long) num;
@property (readonly) NSString *trimmedString;
@property (readonly) NSDate *date;
@end

@interface NSString (UTF8String)
@property (readonly) char *UTF8String; // a favorite!
@end
