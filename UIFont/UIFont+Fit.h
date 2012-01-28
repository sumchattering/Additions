//
//  UIFont+Fit.h
//  Additions
//
//  Created by Sumeru Chatterjee on 12/26/11.
//

#import <UIKit/UIKit.h>

@interface UIFont (Fit) 
+(UIFont*) maximumBoldSystemFontThatFitsSingleLineString:(NSString*)string inWidth:(CGFloat)width;
+(UIFont*) maximumBoldSystemFontThatFitsString:(NSString*)string inSize:(CGSize)maxSize;
@end

