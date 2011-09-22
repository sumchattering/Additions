//
//  SCURLParser.m
//  Additions
//
//  Created by Sumeru Chatterjee on 5/20/11.


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
            [vars addObject:[[tempString copy] autorelease]];
        }
        self.variables = vars;
        [vars release];
    }
    return self;
}

@end
