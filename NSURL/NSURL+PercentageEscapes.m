//
//  NSURL+PercentageEscapes.m
//  Additions
//
//  Created by samyzee on 1/3/13.
//  Copyright (c) 2013 Simple Apps LLC. All rights reserved.
//

#import "NSURL+PercentageEscapes.h"

@implementation NSURL (PercentageEscapes)

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSURL*)unescapedURL {
    return [NSURL URLWithString:[[[self absoluteString]
                                  stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]
                                  stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(NSURL*)escapedURL {
    return [NSURL URLWithString:[[self absoluteString] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
}

@end
