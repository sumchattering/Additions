//
//  NSURL+PercentageEscapes.h
//  Additions
//
//  Created by samyzee on 1/3/13.
//  Copyright (c) 2013 Simple Apps LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSURL (PercentageEscapes)
-(NSURL*)unescapedURL;
-(NSURL*)escapedURL;
@end
