//
//  NSString+Regex.h
//  Additions
//
//  Created by Sumeru Chatterjee on 5/18/11.


#import <Foundation/Foundation.h>


@interface  NSString (Regex)
-(NSString*) firstURLinString;
-(NSString*) firstStringWithPattern:(NSString*)pattern;
@end