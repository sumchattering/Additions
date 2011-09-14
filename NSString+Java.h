//
//  NSString+Java.h
//  Additions
//
//  Created by Alberto Gimeno Brieba on 12/09/11.
//

#import <Foundation/Foundation.h>

@interface NSString (helper)

- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b;

- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts;

- (NSString*)trim;

- (BOOL)startsWith:(NSString*)s;

- (BOOL)containsString:(NSString*)aString;

- (NSString*)urlEncode;

- (NSString*)sha1;

@end