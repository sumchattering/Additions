//
//  SCURLParser.h
//  Facebook
//
//  Created by Sumeru Chatterjee on 5/20/11.
//  Copyright 2011 . All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDURLParser.h"


@interface SCURLParser : DDURLParser 
- (id) initWithNavigatorParamString:(NSString *)params;
@end
