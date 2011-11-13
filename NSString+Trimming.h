//
//  NSString+Trimming.h
//  Additions
//
//  Created by Sumeru Chatterjee on 11/13/11.
//

#import <Foundation/Foundation.h>

@interface NSString (Trimming)
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
@end
