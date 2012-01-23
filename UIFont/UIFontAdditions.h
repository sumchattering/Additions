//
//  UIFontAdditions.h
//  HumanKitCatalog
//
//  Created by Sumeru Chatterjee on 12/26/11.
//  Copyright (c) 2011 Sumeru Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFont (HICategory) 
+(UIFont*) maximumBoldSystemFontThatFitsString:(NSString*)string inWidth:(CGFloat)width;
@end

