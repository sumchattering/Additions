//
//  UIColor_Categories.m
//  Additions
//
//  Created by Matthias Bauch on 24.11.10.
//  Copyright 2010 Matthias Bauch. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [UIColor colorWithHex:x];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}

@end