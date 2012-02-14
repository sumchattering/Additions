//
//  NSString+QuickHTML.h
//  Additions
//
//  Created by Sumeru Chatterjee on 2/14/12.
//  Copyright (c) 2012 Sumeru Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QuickHTML)
- (NSString *)flattenHTML;
- (NSString *)textForHTMLNodeAtIndex:(NSInteger)index;
@end
