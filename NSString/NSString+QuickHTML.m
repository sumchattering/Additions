//
//  NSString+QuickHTML.m
//  Additions
//
//  Created by Sumeru Chatterjee on 2/14/12.
//  Copyright (c) 2012 Sumeru Chatterjee. All rights reserved.
//

#import "NSString+QuickHTML.h"

@implementation NSString (QuickHTML)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)flattenHTML {

    NSString *text = nil;
    NSMutableString* fullText = [NSMutableString string];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    while (![scanner isAtEnd]) {

        [scanner scanUpToString:@"<" intoString:&text] ;
        [scanner scanUpToString:@">" intoString:NULL] ;
        [scanner setScanLocation:scanner.scanLocation+1];

        if(text) {
            [fullText appendString:text];
            text=nil;
        }
    }
    return fullText;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)textForHTMLNodeAtIndex:(NSInteger)index {

    NSInteger counter = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    while (![scanner isAtEnd]) {

        NSString *text = nil;
        [scanner scanUpToString:@"<" intoString:&text] ;

        if(++counter>index) {
            return text;
        }

        [scanner scanUpToString:@">" intoString:NULL] ;
        [scanner setScanLocation:scanner.scanLocation+1];
    }
    return nil;
}


@end
