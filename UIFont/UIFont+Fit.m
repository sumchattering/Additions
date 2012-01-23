//
//  UIFont+Fit.m
//  Additions
//
//  Created by Sumeru Chatterjee on 12/26/11.
//

#import "UIFont+Fit.h"

@implementation UIFont (Fit)

///////////////////////////////////////////////////////////////////////////////////////////////////
+(UIFont*) maximumBoldSystemFontThatFitsString:(NSString*)string inWidth:(CGFloat)width {
    
    CGFloat min=1,max=300,fontSize;
    CGSize labelSize;
    do {
        
        fontSize = (min+max)/2;
        labelSize = [string sizeWithFont:[UIFont boldSystemFontOfSize:(min+max)/2]];
        
        if(labelSize.width>width)
            max=fontSize;
        else if(labelSize.width<width)
            min=fontSize;
        
    } while ((min<max)&&(labelSize.width!=width));
    
    return [UIFont boldSystemFontOfSize:fontSize];     
}

@end