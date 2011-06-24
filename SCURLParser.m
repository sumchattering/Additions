//
//  SCURLParser.m
//  Facebook
//
//  Created by Sumeru Chatterjee on 5/20/11.
//  Copyright 2011 . All rights reserved.
//

#import "SCURLParser.h"

@implementation SCURLParser

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithNavigatorParamString:(NSString *)params{
    self = [super init];
    if (self != nil) {
        NSString *string = params;
        NSScanner *scanner = [NSScanner scannerWithString:string];
        [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"&="]];
        NSString *tempString;
        NSMutableArray *vars = [NSMutableArray new];
		while ([scanner scanUpToString:@"&" intoString:&tempString]) {
            [vars addObject:[tempString copy]];
        }
        self.variables = vars;
        [vars release];
    }
    return self;
}

@end
